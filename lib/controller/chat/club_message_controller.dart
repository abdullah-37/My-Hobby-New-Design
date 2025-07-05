import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hobby_club_app/models/common/user_model.dart';
import 'package:hobby_club_app/utils/api_url.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class ChatController extends GetxController {
  final PusherChannelsFlutter pusher = PusherChannelsFlutter();
  var messages = <dynamic>[].obs;
  var status = ChatStatus.initial.obs;
  GetStorage storage = GetStorage();
  User user = User();

  getUser() {
    final userData = storage.read("user");
    if (userData != null) {
      user = User.fromJson(userData);
    }
  }

  @override
  void onInit() {
    getUser();
    super.onInit();
  }

  Future<void> initClubChat({
    required String clubId,
    required String token,
  }) async {
    try {
      await pusher.init(
        apiKey: 'eb37c9c5a3dcf84b6722',
        cluster: 'eu',
        onConnectionStateChange: (current, previous) {
          debugPrint("Pusher connection: $previous -> $current");
        },
        onEvent: (event) {
          debugPrint("Event received: ${event.eventName} with data: ${event.data}");
          if (event.eventName == 'App\\Events\\ClubMessageSent' ||
              event.eventName == 'ClubMessageSent') {
            try {
              final messageData = jsonDecode(event.data!);
              debugPrint("New message data: $messageData");
              final currentUserId = user.id;
              final isCurrentUser = messageData['sender']['sender_id'] == currentUserId;

              final newMessage = {
                'id': messageData['id'],
                'message': messageData['message'],
                'sender': {
                  'id': messageData['sender']['sender_id'],
                  'userName': isCurrentUser
                      ? 'You'
                      : messageData['sender']['userName'] ?? 'Unknown',
                  'img': messageData['sender']['img'] ?? '',
                },
                'created_at': messageData['created_at']
              };
              messages.insert(0, newMessage);

            } catch (e) {
              debugPrint('Error parsing message: $e');
            }
          }
        },
        onSubscriptionSucceeded: (channelName, data) {
          debugPrint("Subscribed to $channelName");
        },
        authEndpoint: '${ApiUrl.baseUrl}broadcasting/auth',
        onAuthorizer: (channelName, socketId, options) async {
          try {
            final response = await http.post(
              Uri.parse('${ApiUrl.baseUrl}broadcasting/auth'),
              headers: {
                'Authorization': 'Bearer $token',
                'Content-Type': 'application/json',
                'Accept': 'application/json',
              },
              body: jsonEncode({
                'socket_id': socketId,
                'channel_name': channelName,
              }),
            );

            if (response.statusCode == 200) {
              return jsonDecode(response.body);
            } else {
              debugPrint(
                'Auth failed: ${response.statusCode} - ${response.body}',
              );
              throw Exception('Pusher Auth failed: ${response.body}');
            }
          } catch (e) {
            debugPrint('Authorizer error: $e');
            rethrow;
          }
        },
      );

      await pusher.subscribe(channelName: 'private-club.$clubId');
      await pusher.connect();
    } catch (e) {
      debugPrint('Pusher init error: $e');
      rethrow;
    }
  }

  Future<void> sendClubMessage(int clubId, String message, String token) async {
    final response = await http.post(
      Uri.parse('${ApiUrl.baseUrl}${ApiUrl.CLUBMESSAGE}'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'club_id': clubId, 'message': message}),
    );

    debugPrint('BaseURL: ${ApiUrl.baseUrl}${ApiUrl.CLUBMESSAGE}');
    debugPrint('Response status: ${response.statusCode}');
    debugPrint('Response body: ${response.body}');

    if (response.statusCode == 200) {
      debugPrint('Message sent');
    } else {
      debugPrint('Error sending message: ${response.body}');
    }
  }

  Future<List<dynamic>> fetchClubMessages(String clubId, String token) async {
    status.value = ChatStatus.loading;
    try {
      final response = await http.get(
        Uri.parse('${ApiUrl.baseUrl}${ApiUrl.GETCLUBMESSAGE}$clubId'),
        headers: {'Authorization': 'Bearer $token'},
      );

      debugPrint('BaseURL: ${ApiUrl.baseUrl}${ApiUrl.GETCLUBMESSAGE}$clubId');
      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        messages.value = json['data'];
        status.value = ChatStatus.success;
        return json['data'];
      } else {
        status.value = ChatStatus.failure;
        throw Exception('Failed to load messages');
      }
    } catch (e) {
      status.value = ChatStatus.failure;
      rethrow;
    }
  }
}

enum ChatStatus { initial, loading, success, failure }
