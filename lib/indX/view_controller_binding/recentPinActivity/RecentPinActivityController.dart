import 'package:get/get.dart';
import '../../api/TypeActions.dart';
import '../../api/model/login/LoginResponse.dart';
import '../../api/model/recentPinActivity/RecentPinActivityData.dart';
import '../../utils/Utility.dart';
import 'RecentPinActivityApi.dart';

class RecentPinActivityController extends GetxController {

  RecentPinActivityApi api = RecentPinActivityApi();
  LoginResponse loginResponse =Get.find();
  var list = <RecentPinActivityData>[].obs;
  var isApiCalled=false.obs;



  @override
  void onInit() async {
    super.onInit();

    getReport(false);
  }



 Future<void> getReport( bool isFromClick) async {

    await api.getReport(loginResponse.data!,isFromClick, (action, response,{bool? isFromApi = false}) async {
      isApiCalled.value=true;
      if (action == TypeActions.INSTANCE.SUCCESS) {
        list.value=response;
      } else if (action == TypeActions.INSTANCE.ERROR) {
        Utility.INSTANCE.dialogIconOneButton("error", "", response, "Cancel");
      } else if (action == TypeActions.INSTANCE.NETWROK_ERROR) {
        Utility.INSTANCE.dialogIconOneButton("wifi_error", "Network Error", "No Internet Connection", "Cancel");
      }
    });
  }

}
