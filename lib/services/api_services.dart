import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hobby_club_app/models/response_model.dart';
import 'package:hobby_club_app/view/screens/no_internet_screen.dart';
import 'package:http/http.dart' as http;

class ApiServices extends GetxService {
  final GetStorage storage = GetStorage();

  String token = '';
  String tokenType = 'Bearer';

  Future<void> initToken() async {
    token = storage.read('token') ?? '';
    tokenType = storage.read('tokenType') ?? 'Bearer';
  }

  Future<void> saveToken(String accessToken, {String type = 'Bearer'}) async {
    token = accessToken;
    tokenType = type;

    await storage.write('token', token);
    await storage.write('tokenType', tokenType);

    await initToken();
  }

  Future<void> clearToken() async {
    token = '';
    tokenType = 'Bearer';

    await storage.remove('token');
    await storage.remove('tokenType');
  }

  Future<ResponseModel> postRequest(
    String uri,
    Map<String, dynamic>? params, {
    bool passHeader = true,
    bool isOnlyAcceptType = false,
  }) async {
    Uri url = Uri.parse(uri);
    http.Response response;

    try {
      await initToken();
      if (passHeader) {
        if (isOnlyAcceptType) {
          response = await http.post(
            url,
            body: params,
            headers: {"Accept": "application/json"},
          );
        } else {
          response = await http.post(
            url,
            body: jsonEncode(params),
            headers: {
              "Content-Type": "application/json",
              "Authorization": "$tokenType $token",
            },
          );
        }
      } else {
        response = await http.post(url, body: params);
      }

      debugPrint('POST $uri');
      debugPrint('Token: $token');
      debugPrint('Status code: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');
      debugPrint('Params: $params');

      dynamic responseBody;
      try {
        responseBody = jsonDecode(response.body);
      } catch (_) {
        responseBody = null;
      }

      if (response.statusCode == 200) {
        return ResponseModel(true, 'Success', 200, response.body);
      } else if (response.statusCode == 422) {
        String errorMessage = 'Validation error';
        if (responseBody != null && responseBody['errors'] != null) {
          final errors = responseBody['errors'] as Map<String, dynamic>;
          if (errors.isNotEmpty) {
            final firstKey = errors.keys.first;
            final firstErrorList = errors[firstKey] as List<dynamic>;
            if (firstErrorList.isNotEmpty) {
              errorMessage = firstErrorList[0].toString();
            }
          }
        }
        return ResponseModel(false, errorMessage, 422, response.body);
      } else {
        String errorMessage = 'Failed with status ${response.statusCode}';
        if (responseBody != null &&
            responseBody is Map<String, dynamic> &&
            responseBody['message'] != null) {
          errorMessage = responseBody['message'].toString();
        }
        return ResponseModel(
          false,
          errorMessage,
          response.statusCode,
          response.body,
        );
      }
    } on SocketException {
      return ResponseModel(false, 'No internet connection', 503, '');
    } on FormatException {
      return ResponseModel(false, 'Bad response format', 400, '');
    } catch (e) {
      return ResponseModel(false, 'Unexpected error: $e', 500, '');
    }
  }

  Future<ResponseModel> uploadMultipartRequest(
    String uri,
    Map<String, dynamic>? params, {
    bool passHeader = true,
    File? file,
    String fileFieldName = 'img',
  }) async {
    Uri url = Uri.parse(uri);
    http.Response response;

    try {
      await initToken();
      if (file == null || !file.existsSync()) {
        return ResponseModel(false, 'Image file is required', 400, '');
      }

      var request = http.MultipartRequest('POST', url);

      // Attach file
      request.files.add(
        await http.MultipartFile.fromPath(fileFieldName, file.path),
      );

      // Attach fields
      if (params != null) {
        request.fields.addAll(params.map((k, v) => MapEntry(k, v.toString())));
      }

      // Attach headers
      if (passHeader) {
        request.headers.addAll({"Authorization": "Bearer $token"});
      }

      // Send request
      final streamedResponse = await request.send();
      response = await http.Response.fromStream(streamedResponse);

      debugPrint('📤 URL: $uri');
      debugPrint('📤 Status code: ${response.statusCode}');
      debugPrint('📤 Response: ${response.body}');

      dynamic responseBody;
      try {
        responseBody = jsonDecode(response.body);
      } catch (_) {
        responseBody = null;
      }

      if (response.statusCode == 200) {
        return ResponseModel(true, 'Success', 200, response.body);
      } else {
        String errorMessage =
            responseBody?['message'] ?? 'Error ${response.statusCode}';
        return ResponseModel(
          false,
          errorMessage,
          response.statusCode,
          response.body,
        );
      }
    } on SocketException {
      return ResponseModel(false, 'No internet connection', 503, '');
    } on FormatException {
      return ResponseModel(false, 'Invalid response format', 400, '');
    } catch (e) {
      return ResponseModel(false, 'Unexpected error: $e', 500, '');
    }
  }

  Future<ResponseModel> getRequest(
    String uri, {
    bool passHeader = true,
    bool isOnlyAcceptType = false,
  }) async {
    Uri url = Uri.parse(uri);
    http.Response response;

    try {
      await initToken();
      if (passHeader) {
        initToken();
        if (isOnlyAcceptType) {
          response = await http.get(
            url,
            headers: {"Accept": "application/json"},
          );
        } else {
          response = await http.get(
            url,
            headers: {
              "Content-Type": "application/json",
              "Authorization": "$tokenType $token",
            },
          );
        }
      } else {
        response = await http.get(url);
      }

      debugPrint('GET $uri');
      debugPrint('Token: $token');
      debugPrint('Status code: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return ResponseModel(true, 'Success', 200, response.body);
      } else if (response.statusCode == 422) {
        String errorMessage = 'Validation error';
        if (responseBody['errors'] != null) {
          final errors = responseBody['errors'] as Map<String, dynamic>;
          if (errors.isNotEmpty) {
            final firstKey = errors.keys.first;
            final firstErrorList = errors[firstKey] as List<dynamic>;
            if (firstErrorList.isNotEmpty) {
              errorMessage = firstErrorList[0].toString();
            }
          }
        }
        return ResponseModel(false, errorMessage, 422, response.body);
      } else {
        String errorMessage = 'Failed with status ${response.statusCode}';
        if (responseBody is Map<String, dynamic> &&
            responseBody['message'] != null) {
          errorMessage = responseBody['message'].toString();
        }

        return ResponseModel(
          false,
          errorMessage,
          response.statusCode,
          response.body,
        );
      }
    } on SocketException {
      Get.offAll(() => const NoInternetScreen());
      return ResponseModel(false, 'No internet connection', 503, '');
    } on FormatException {
      return ResponseModel(false, 'Bad response format', 400, '');
    } catch (e) {
      return ResponseModel(false, 'Unexpected error: $e', 500, '');
    }
  }
}
