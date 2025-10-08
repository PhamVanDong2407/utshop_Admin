import 'package:get/get.dart';
import 'package:utshopadmin/Global/constant.dart';
import 'package:utshopadmin/Route/app_page.dart';
import 'package:utshopadmin/Service/auth.dart';
import 'package:utshopadmin/Util/util.dart';


class SplashController extends GetxController {
  @override
  Future<void> onInit() async {
    super.onInit();
    await Future.delayed(const Duration(seconds: 3));
    String accessToken = await Utils.getStringValueWithKey(
      Constant.ACCESS_TOKEN,
    );
    if (accessToken.isEmpty) {
      Get.offAllNamed(Routes.login);
    } else {
      await Auth.login();           
    }
  }
}
