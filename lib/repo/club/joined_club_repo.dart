import 'package:hobby_club_app/models/raw/response_model.dart';
import 'package:hobby_club_app/services/api_services.dart';
import 'package:hobby_club_app/utils/api_url.dart';

class JoinedClubRepo {
  final ApiServices _api = ApiServices();

  Future<ResponseModel> getJoinClubs() async {
    final url = '${ApiUrl.baseUrl}${ApiUrl.getJoinedClub}';
    ResponseModel responseModel = await _api.getRequest(url, passHeader: true);
    return responseModel;
  }
}
