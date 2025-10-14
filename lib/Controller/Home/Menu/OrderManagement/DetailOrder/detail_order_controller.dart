import 'package:get/get.dart';

class DetailOrderController extends GetxController {
    var selectedAction = Rxn<String>();

     void handleUpdate() {
    if (selectedAction.value == null) {
      return;
    }
    Get.snackbar("Thành công", "Đã gửi yêu cầu cập nhật cho đơn hàng.");
  }
}