import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utshopadmin/Service/api_caller.dart';

class CreateVoucherController extends GetxController {
  // Các TextEditingController
  final codeController = TextEditingController();
  final discountController = TextEditingController();
  final descriptionController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final minOrderValueController = TextEditingController();
  final usageLimitController = TextEditingController();

  RxBool isLoading = false.obs;

  Future<void> createVoucher() async {
    try {
      isLoading.value = true;

      final body = {
        "code": codeController.text.trim(),
        "description": descriptionController.text.trim(),
        "discount_type": 1, // 1 = %, 2 = VNĐ (tùy hệ thống bạn)
        "discount_value": discountController.text.trim(),
        "min_order_value": minOrderValueController.text.trim(),
        "max_discount_amount": "0",
        "start_date": startDateController.text.trim(),
        "end_date": endDateController.text.trim(),
        "usage_limit_per_voucher": int.parse(usageLimitController.text.trim()),
        "usage_limit_per_user": 1,
        "is_active": 1,
      };

      final response = await APICaller.getInstance().post(
        "v1/voucher",
        body: body,
      );

      if (response['code'] == 200) {
        Get.back();
        Get.snackbar(
          "Thành công",
          "Tạo mã giảm giá thành công",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      debugPrint("Create voucher error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    codeController.dispose();
    discountController.dispose();
    descriptionController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    minOrderValueController.dispose();
    usageLimitController.dispose();
    super.onClose();
  }
}
