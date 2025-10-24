import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utshopadmin/Model/Vouchers.dart';
import 'package:utshopadmin/Service/api_caller.dart';

class VoucherManagementController extends GetxController {
  RxList<Vouchers> vouchers = <Vouchers>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getListVouchers();
  }

  Future<void> getListVouchers() async {
    try {
      isLoading.value = true;
      var response = await APICaller.getInstance().get('v1/voucher');

      if (response != null && response['data'] != null) {
        List<dynamic> data = response['data'] as List<dynamic>;
        vouchers.value = data.map((item) => Vouchers.fromJson(item)).toList();
      } else {
        vouchers.clear();
      }
    } catch (e) {
      debugPrint('Error fetching vouchers: $e');
      vouchers.clear();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteVoucher(String uuid) async {
    try {
      await APICaller.getInstance().delete('v1/voucher/$uuid');
      vouchers.removeWhere((v) => v.uuid == uuid);
      Get.snackbar(
        "Thành công",
        "Đã xóa mã giảm giá.",
        backgroundColor: Colors.green.shade600,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        "Lỗi",
        "Không thể xóa mã giảm giá.",
        backgroundColor: Colors.red.shade600,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      debugPrint("Delete error: $e");
    }
  }
}
