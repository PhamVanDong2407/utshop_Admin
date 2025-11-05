import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utshopadmin/Model/Banner.dart';
import 'package:utshopadmin/Service/api_caller.dart';
import 'package:utshopadmin/Global/constant.dart';

class BannerManagementController extends GetxController {
  RxList<Banners> bannerList = <Banners>[].obs;

  final String baseUrl = Constant.BASE_URL_IMAGE;

  @override
  void onInit() {
    super.onInit();
    getBannerList();
  }

  Future<void> getBannerList() async {
    try {
      final response = await APICaller.getInstance().get('v1/banner');
      final data = response?['data'] as List<dynamic>?;

      bannerList.value =
          (data ?? []).map((item) {
            final banner = Banners.fromJson(item);
            final path = banner.imageUrl;

            if (path?.isNotEmpty == true) {
              banner.imageUrl =
                  path!.startsWith('http')
                      ? path
                      : path.startsWith('resources/')
                      ? '$baseUrl$path'
                      : '$baseUrl/$path';
            }

            return banner;
          }).toList();
    } catch (e) {
      debugPrint('Error fetching banner list: $e');
      bannerList.clear();
    }
  }

  Future<void> refreshData() async {
    await getBannerList();
  }

  /// Ẩn banner: gửi { uuid, is_active: 0 }
  Future<void> hideBanner(String uuid) async {
    await _updateBannerStatus(uuid, 0, "Đã ẩn banner!");
  }

  /// Hiện banner: gửi { uuid, is_active: 1 }
  Future<void> showBanner(String uuid) async {
    await _updateBannerStatus(uuid, 1, "Đã hiển thị banner!");
  }

  /// Hàm chung
  Future<void> _updateBannerStatus(
    String uuid,
    int isActive,
    String successMsg,
  ) async {
    try {
      final response = await APICaller.getInstance().put(
        'v1/banner/status',
        body: {
          'uuid': uuid,
          'is_active': isActive, // 0 hoặc 1
        },
      );

      if (response?['code'] == 200) {
        await getBannerList();
        Get.snackbar(
          "Thành công",
          successMsg,
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        Get.snackbar(
          "Lỗi",
          response?['message'] ?? "Thao tác thất bại!",
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.red,
        );
      }
    } catch (e) {
      debugPrint('Error updating banner status: $e');
    }
  }

  Future<void> removeBanner(String uuid) async {
    try {
      var response = await APICaller.getInstance().delete('v1/banner/$uuid');
      if (response != null && response['code'] == 200) {
        await getBannerList();
        Get.snackbar(
          "Thành công",
          "Đã xóa banner!",
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        Get.snackbar(
          "Lỗi",
          "Không thể xóa banner!",
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.red,
        );
      }
    } catch (e) {
      debugPrint('❌ Error removing banner: $e');
    }
  }
}
