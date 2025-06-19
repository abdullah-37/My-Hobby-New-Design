import 'package:hobby_club_app/models/response_model.dart';
import 'package:hobby_club_app/services/api_services.dart';
import 'package:hobby_club_app/utils/api_url.dart';

class AllClubRepo {
  final ApiServices _api = ApiServices();

  Future<ResponseModel> getAllClubs() async {
    final url = '${ApiUrl.baseUrl}${ApiUrl.getAllClub}';
    ResponseModel responseModel = await _api.getRequest(url, passHeader: true);
    print('repo resposne ${responseModel.responseJson} ');
    return responseModel;
  }
}
