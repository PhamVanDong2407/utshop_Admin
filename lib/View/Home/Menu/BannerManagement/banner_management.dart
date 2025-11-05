import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utshopadmin/Controller/Home/Menu/BannerManagement/banner_management_controller.dart';
import 'package:utshopadmin/Global/app_color.dart';
import 'package:utshopadmin/Model/Banner.dart';
import 'package:utshopadmin/Route/app_page.dart';

class BannerManagement extends StatelessWidget {
  BannerManagement({super.key});

  final controller = Get.put(BannerManagementController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        foregroundColor: AppColor.white,
        backgroundColor: AppColor.primary,
        elevation: 0,
        title: const Text(
          "Quản lý banner",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 24),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        final banners = controller.bannerList;

        if (banners.isEmpty) {
          return const Center(
            child: Text(
              "Chưa có banner nào.\nHãy nhấn nút + để thêm.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: controller.refreshData,
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 20, bottom: 90),
            itemCount: banners.length,
            itemBuilder: (context, index) {
              final Banners banner = banners[index];
              final bool isActive = banner.isActive ?? false;

              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(50),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Image.network(
                            banner.imageUrl ?? '',
                            height: 180,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Container(
                                height: 180,
                                color: Colors.grey[200],
                                child: Center(
                                  child: CircularProgressIndicator(
                                    value:
                                        loadingProgress.expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes!
                                            : null,
                                  ),
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height: 180,
                                color: Colors.grey[100],
                                child: const Center(
                                  child: Icon(
                                    Icons.broken_image,
                                    color: Colors.grey,
                                    size: 50,
                                  ),
                                ),
                              );
                            },
                          ),
                          if (!isActive)
                            Positioned(
                              top: 8,
                              left: 8,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black.withAlpha(80),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Text(
                                  "ĐANG ẨN",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),

                      // Nút thao tác
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // Nút Ẩn/Hiện banner
                            TextButton.icon(
                              icon: Icon(
                                isActive
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color:
                                    isActive ? Colors.grey : AppColor.primary,
                              ),
                              label: Text(
                                isActive ? "Ẩn" : "Hiện",
                                style: TextStyle(
                                  color:
                                      isActive ? Colors.grey : AppColor.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: () async {
                                if (isActive) {
                                  await controller.hideBanner(
                                    banner.uuid ?? '',
                                  );
                                } else {
                                  await controller.showBanner(
                                    banner.uuid ?? '',
                                  );
                                }
                              },
                            ),

                            // Nút Xóa banner
                            TextButton.icon(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              label: const Text(
                                "Xóa",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: () async {
                                await controller.removeBanner(
                                  banner.uuid ?? '',
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.toNamed(Routes.createBanner);
        },
        backgroundColor: AppColor.primary,
        foregroundColor: AppColor.white,
        label: const Text(
          'Thêm mới',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        icon: const Icon(Icons.add),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 8,
      ),
    );
  }
}
