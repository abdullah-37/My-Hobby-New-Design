import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hobby_club_app/models/events_model.dart';
import 'package:hobby_club_app/models/response_model.dart';
import 'package:hobby_club_app/repo/evets_repo.dart';

class EvetsController extends GetxController {
  EventsRepository eventRepository = EventsRepository();
  RxList<EventModel> upcommingEvents = <EventModel>[].obs;
  RxList<EventModel> allEvents = <EventModel>[].obs;

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    getUpcommingEvents();
    super.onInit();
  }

  void getUpcommingEvents() async {
    isLoading.value = true;
    try {
      ResponseModel response = await eventRepository.getUpcommingEvents();
      if (response.isSuccess) {
        print('Discussions ${jsonDecode(response.responseJson)}');

        ClubEventsModel eventModel = ClubEventsModel.fromJson(
          jsonDecode(response.responseJson),
        );
        upcommingEvents.value = eventModel.data;
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  // Get All Evets
  void getClubEvents(int clubId) async {
    isLoading.value = true;
    try {
      ResponseModel response = await eventRepository.getClubEvents(clubId);
      if (response.isSuccess) {
        print('Discussions ${jsonDecode(response.responseJson)}');

        ClubEventsModel eventModel = ClubEventsModel.fromJson(
          jsonDecode(response.responseJson),
        );
        allEvents.value = eventModel.data;
      }
    } catch (e) {
      // print(e);
    } finally {
      isLoading.value = false;
    }
  }
}
