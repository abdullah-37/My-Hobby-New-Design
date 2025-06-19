import 'package:hobby_club_app/models/response_model.dart';
import 'package:hobby_club_app/services/api_services.dart';
import 'package:hobby_club_app/utils/api_url.dart';

class MyClubsRepo {
  final ApiServices _api = ApiServices();

  Future<ResponseModel> getMyClubs() async {
    final url = '${ApiUrl.baseUrl}${ApiUrl.getUserClub}';
    ResponseModel responseModel = await _api.getRequest(url, passHeader: true);
    print('repo resposne UserClub ${responseModel.responseJson} ');

    return responseModel;
  }
}
