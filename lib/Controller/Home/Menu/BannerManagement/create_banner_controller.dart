// lib/Controller/Banner/CreateBannerController.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:utshopadmin/Global/app_color.dart';
import 'package:utshopadmin/Service/api_caller.dart';
import 'package:utshopadmin/Util/util.dart';

class CreateBannerController extends GetxController {
  final Rx<File?> selectedImage = Rx<File?>(null);
  final RxBool isUploading = false.obs;
  final RxBool isImageValid = true.obs;
  final ImagePicker _picker = ImagePicker();

  @override
  void onClose() {
    selectedImage.value = null;
    super.onClose();
  }

  /// Chọn ảnh
  Future<void> pickImage() async {
    try {
      final XFile? picked = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 85);
      if (picked != null) {
        selectedImage.value = File(picked.path);
        isImageValid.value = true;
      }
    } catch (e) {
      Utils.showSnackBar(title: "Lỗi", message: "Không thể chọn ảnh: $e");
    }
  }

  /// Kiểm tra ảnh
  bool validateImage() {
    if (selectedImage.value == null) {
      isImageValid.value = false;
      return false;
    }
    isImageValid.value = true;
    return true;
  }

  /// Tạo banner: upload ảnh → lấy URL → tạo banner
  Future<void> createBanner() async {
    if (!validateImage()) return;

    isUploading.value = true;

    try {
      // B1: Upload ảnh qua multiple-upload
      final uploadRes = await APICaller.getInstance().uploadMultipartFiles(
        endpoint: 'v1/file/multiple-upload',
        files: [selectedImage.value!],
      );

      if (uploadRes == null || uploadRes['code'] != 200) {
        Utils.showSnackBar(
          title: "Lỗi",
          message: uploadRes?['message'] ?? "Upload ảnh thất bại!",
        );
        return;
      }

      final List<String> uploadedUrls = List<String>.from(uploadRes['files']);
      final String imageUrl = uploadedUrls.first;

      // B2: Tạo banner với URL
      final response = await APICaller.getInstance().post(
        'v1/banner',
        body: {'image_url': imageUrl},
      );

      if (response != null && response['code'] == 201) {
        Get.back();
        Utils.showSnackBar(title: "Thành công", message: "Thêm banner thành công!", backgroundColor: AppColor.primary);
        // Reset
        selectedImage.value = null;
      } else {
        Utils.showSnackBar(
          title: "Lỗi",
          message: response?['message'] ?? "Tạo banner thất bại!",
        );
      }
    } catch (e) {
      debugPrint("Create banner error: $e");
      Utils.showSnackBar(title: "Lỗi", message: "Kết nối thất bại!");
    } finally {
      isUploading.value = false;
    }
  }
}