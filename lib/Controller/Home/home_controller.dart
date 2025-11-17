import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:utshopadmin/Global/constant.dart';
import 'package:utshopadmin/Model/Dashboard.dart';
import 'package:utshopadmin/Service/api_caller.dart';
import 'package:utshopadmin/Util/util.dart';

class HomeController extends GetxController {
  final zoomDrawerController = ZoomDrawerController();
  RxString name = ''.obs;
  RxString email = ''.obs;
  RxString avatar = ''.obs;
  final String baseUrl = Constant.BASE_URL_IMAGE;

  var isLoading = true.obs;
  var stats = Rx<DashboardStats?>(null);

  // Helper format tiền
  final currencyFormatter = NumberFormat.currency(locale: 'vi_VN', symbol: 'đ');
  // Helper format số (1000 -> 1K, 1200000 -> 1.2Tr)
  final compactFormatter = NumberFormat.compact(locale: 'vi_VN');
  // Helper format số (1250 -> 1,250)
  final decimalFormatter = NumberFormat.decimalPattern('vi_VN');

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

    fetchDashboardStats();
  }

  Future<void> fetchDashboardStats() async {
    try {
      isLoading(true);
      final response = await APICaller.getInstance().get("v1/dashboard/stats");

      if (response != null && response['code'] == 200) {
        stats.value = DashboardStats.fromJson(response['data']);
      } else {
        Utils.showSnackBar(
          title: "Lỗi",
          message: response?['message'] ?? "Không thể tải thống kê.",
        );
      }
    } catch (e) {
      debugPrint("Error fetching dashboard stats: $e");
    } finally {
      isLoading(false);
    }
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
