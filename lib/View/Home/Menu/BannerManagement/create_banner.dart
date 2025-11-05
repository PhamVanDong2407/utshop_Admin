// lib/Screen/Banner/CreateBanner.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utshopadmin/Controller/Home/Menu/BannerManagement/create_banner_controller.dart';
import 'package:utshopadmin/Global/app_color.dart';

class CreateBanner extends StatelessWidget {
  const CreateBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateBannerController());

    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        foregroundColor: AppColor.white,
        backgroundColor: AppColor.primary,
        elevation: 0,
        title: const Text("Thêm mới banner", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 24),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Chọn ảnh
            Obx(() => GestureDetector(
                  onTap: controller.pickImage,
                  child: Container(
                    height: 220,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: controller.isImageValid.value ? Colors.grey.shade300 : Colors.red, width: 2),
                    ),
                    child: controller.selectedImage.value == null
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add_photo_alternate_outlined, size: 60, color: Colors.grey[600]),
                              const SizedBox(height: 12),
                              Text("Chọn ảnh banner", style: TextStyle(fontSize: 16, color: Colors.grey[700])),
                              if (!controller.isImageValid.value)
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text("Vui lòng chọn ảnh!", style: TextStyle(color: Colors.red, fontSize: 12)),
                                ),
                            ],
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: Image.file(controller.selectedImage.value!, fit: BoxFit.cover),
                          ),
                  ),
                )),

            const SizedBox(height: 30),

            // Nút thêm
            Obx(() => SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.isUploading.value ? null : controller.createBanner,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 4,
                    ),
                    child: controller.isUploading.value
                        ? const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
                              SizedBox(width: 12),
                              Text("Đang tải lên...", style: TextStyle(fontSize: 16)),
                            ],
                          )
                        : const Text("Thêm banner", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}