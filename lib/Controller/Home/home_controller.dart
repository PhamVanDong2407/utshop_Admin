import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:utshopadmin/Global/constant.dart';
import 'package:utshopadmin/Util/util.dart';

class HomeController extends GetxController {
  final zoomDrawerController = ZoomDrawerController();
  RxString name = ''.obs;
  RxString email = ''.obs;
  RxString avatar = ''.obs;
  final String baseUrl = Constant.BASE_URL_IMAGE;

  @override
  void onInit() async {
    super.onInit();
    Utils.getStringValueWithKey(Constant.NAME).then((value) {
      name.value = value ?? '';
    });
    Utils.getStringValueWithKey(Constant.AVATAR).then((value) {
      avatar.value = value ?? '';
    });
    Utils.getStringValueWithKey(Constant.EMAIL).then((value) {
      email.value = value ?? '';
    });
  }

  updateName(String name) {
    this.name.value = name;
  }

  updateEmail(String email) {
    this.email.value = email;
  }

  updateAvatar(String avatar) {
    this.avatar.value = avatar;
  }

  void toggleDrawer() {
    zoomDrawerController.toggle?.call();
  }
}
