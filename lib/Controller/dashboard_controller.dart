import 'package:get/get.dart';
import 'package:utshopadmin/Global/constant.dart';
import 'package:utshopadmin/Util/util.dart';


class DashboardController extends GetxController {
  RxInt currentIndex = 0.obs;
  RxString name = ''.obs;
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
  }

  updateName(String name) {
    this.name.value = name;
  }

  updateAvatar(String avatar) {
    this.avatar.value = avatar;
  }

  changePage(int index) {
    currentIndex.value = index;
  }
}
