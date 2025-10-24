import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utshopadmin/Model/Vouchers.dart';
import 'package:utshopadmin/Service/api_caller.dart';

class EditVoucherController extends GetxController {
  RxBool isEditing = false.obs;
  Vouchers vouchers = Vouchers();
  late String uuid;

  TextEditingController codeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController discountValueController = TextEditingController();
  TextEditingController minOrderValueController = TextEditingController();
  TextEditingController maxDiscountAmountController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController usageLimitController = TextEditingController();
  TextEditingController currentUsageController = TextEditingController();

  RxInt discountType =
      0.obs; // 0: %, 1: VNĐ hoặc tùy vào backend (bạn có discount_type trong JSON)
  RxBool isActive = false.obs;

  @override
  void onInit() {
    super.onInit();
    uuid = Get.arguments['uuid'];
    getDetailsVouchers();
  }

  Future<void> getDetailsVouchers() async {
    try {
      isEditing.value = true;
      var response = await APICaller.getInstance().get('v1/voucher/$uuid');

      if (response != null && response['data'] != null) {
        debugPrint("Voucher detail response: $response");

        var voucherData = response['data'];
        vouchers = Vouchers.fromJson(voucherData);

        // Gán dữ liệu vào controller
        codeController.text = vouchers.code ?? '';
        descriptionController.text = vouchers.description ?? '';
        discountValueController.text = vouchers.discountValue ?? '';
        minOrderValueController.text = vouchers.minOrderValue ?? '';
        maxDiscountAmountController.text = vouchers.maxDiscountAmount ?? '';
        startDateController.text = vouchers.startDate?.split('T').first ?? '';
        endDateController.text = vouchers.endDate?.split('T').first ?? '';
        usageLimitController.text =
            vouchers.usageLimitPerVoucher?.toString() ?? '';
        currentUsageController.text =
            vouchers.currentUsageCount?.toString() ?? '';
        discountType.value = vouchers.discountType ?? 0;
        isActive.value = vouchers.isActive == 1;
      } else {
        debugPrint('Response or data is null');
      }
    } catch (e) {
      debugPrint('Error fetching voucher details: $e');
    } finally {
      isEditing.value = false;
    }
  }

  Future<void> updateVoucher() async {
    try {
      Map<String, dynamic> body = {
        "code": codeController.text.trim(),
        "description": descriptionController.text.trim(),
        "discount_type": discountType.value,
        "discount_value": discountValueController.text.trim(),
        "min_order_value": minOrderValueController.text.trim(),
        "max_discount_amount": maxDiscountAmountController.text.trim(),
        "start_date": startDateController.text.trim(),
        "end_date": endDateController.text.trim(),
        "usage_limit_per_voucher":
            int.tryParse(usageLimitController.text.trim()) ?? 0,
        "is_active": isActive.value ? 1 : 0,
      };

      debugPrint("PUT body: $body");

      var response = await APICaller.getInstance().put(
        "v1/voucher/$uuid",
        body: body,
      );

      if (response != null && response['code'] == 200) {
        Get.back();
        Get.snackbar(
          "Thành công",
          "Cập nhật mã giảm giá thành công",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      debugPrint("Error updating voucher: $e");
    }
  }

  void toggleEdit() {
    isEditing.value = !isEditing.value;
  }

  void cancelEdit() {
    isEditing.value = false;
  }

  @override
  void onClose() {
    codeController.dispose();
    descriptionController.dispose();
    discountValueController.dispose();
    minOrderValueController.dispose();
    maxDiscountAmountController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    usageLimitController.dispose();
    currentUsageController.dispose();
    super.onClose();
  }
}
