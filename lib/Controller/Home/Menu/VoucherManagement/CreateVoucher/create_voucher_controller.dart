import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utshopadmin/Service/api_caller.dart';

class CreateVoucherController extends GetxController {
  // Các TextEditingController
  final codeController = TextEditingController();
  final discountController = TextEditingController(); // Nhập số tiền hoặc số %
  final maxDiscountController = TextEditingController(); // Nhập giảm tối đa (cho loại %)
  final descriptionController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final minOrderValueController = TextEditingController();
  final usageLimitController = TextEditingController();

  RxBool isLoading = false.obs;

  // 1: Giảm theo % (Percent)
  // 2: Giảm theo tiền mặt (Fixed Amount)
  RxInt discountType = 1.obs;

  Future<void> createVoucher() async {
    try {
      isLoading.value = true;

      // Xử lý logic max_discount_amount
      // - Nếu là giảm theo % (type 1): Lấy giá trị từ ô maxDiscountController
      // - Nếu là giảm theo tiền (type 2): max_discount chính là số tiền giảm luôn (hoặc để 0)
      String maxDiscount = "0";
      if (discountType.value == 1) {
        maxDiscount = maxDiscountController.text.trim();
        if (maxDiscount.isEmpty) maxDiscount = "0";
      } else {
        maxDiscount = discountController.text.trim();
      }

      final body = {
        "code": codeController.text.trim(),
        "description": descriptionController.text.trim(),
        "discount_type": discountType.value, // Truyền loại giảm giá user chọn
        "discount_value": discountController.text.trim(),
        "min_order_value": minOrderValueController.text.trim(),
        "max_discount_amount": maxDiscount, 
        "start_date": startDateController.text.trim(),
        "end_date": endDateController.text.trim(),
        "usage_limit_per_voucher": int.tryParse(usageLimitController.text.trim()) ?? 0,
        "usage_limit_per_user": 1,
        "is_active": 1,
      };

      final response = await APICaller.getInstance().post(
        "v1/voucher",
        body: body,
      );

      if (response != null && response['code'] == 200) {
        Get.back(); // Đóng màn hình
        Get.snackbar(
          "Thành công",
          "Tạo mã giảm giá thành công",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
        );
      }
    } catch (e) {
      debugPrint("Create voucher error: $e");
      Get.snackbar(
        "Lỗi",
        "Có lỗi xảy ra: $e",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    codeController.dispose();
    discountController.dispose();
    maxDiscountController.dispose();
    descriptionController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    minOrderValueController.dispose();
    usageLimitController.dispose();
    super.onClose();
  }
}