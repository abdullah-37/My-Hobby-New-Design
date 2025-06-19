import 'package:hobby_club_app/models/response_model.dart';
import 'package:hobby_club_app/services/api_services.dart';
import 'package:hobby_club_app/utils/api_url.dart';

class EventsRepository {
  final ApiServices _api = ApiServices();

  Future<ResponseModel> getUpcommingEvents() async {
    const url = '${ApiUrl.baseUrl}${ApiUrl.upcomingschedule}';
    print(url);
    ResponseModel responseModel = await _api.getRequest(url, passHeader: true);
    print(responseModel.responseJson);

    return responseModel;
  }

  Future<ResponseModel> getClubEvents(int clubId) async {
    String url = '${ApiUrl.baseUrl}${ApiUrl.upcomingschedule}/$clubId';
    // print(url);
    ResponseModel responseModel = await _api.getRequest(url, passHeader: true);
    // print(responseModel);

    return responseModel;
  }
}
