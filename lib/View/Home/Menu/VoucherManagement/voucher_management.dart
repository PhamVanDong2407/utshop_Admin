import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utshopadmin/Component/custom_dialog.dart';
import 'package:utshopadmin/Controller/Home/Menu/VoucherManagement/voucher_management_controller.dart';
import 'package:utshopadmin/Global/app_color.dart';
import 'package:utshopadmin/Route/app_page.dart';

class VoucherManagement extends StatelessWidget {
  VoucherManagement({super.key});

  final controller = Get.put(VoucherManagementController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        foregroundColor: AppColor.white,
        backgroundColor: AppColor.primary,
        elevation: 0,
        title: const Text(
          "Quản lý mã giảm giá",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 24),
          onPressed: () => Get.back(),
        ),
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return RefreshIndicator(
          onRefresh: controller.getListVouchers,
          color: AppColor.primary,
          child:
              controller.vouchers.isEmpty
                  ? const Center(
                    child: Text(
                      "Không có mã giảm giá nào",
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                  : ListView.builder(
                    padding: const EdgeInsets.only(
                      top: 20,
                      bottom: 100,
                      left: 20,
                      right: 20,
                    ),
                    itemCount: controller.vouchers.length,
                    itemBuilder: (context, index) {
                      final voucher = controller.vouchers[index];

                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(
                            Routes.editVoucher,
                            arguments: {'uuid': controller.vouchers[index].uuid},
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 12),
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
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // --- Mã và trạng thái ---
                                Row(
                                  children: [
                                    Text(
                                      voucher.code ?? "--",
                                      style: TextStyle(
                                        color: AppColor.primary,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      (voucher.isActive ?? 0) == 1
                                          ? "Đang hoạt động"
                                          : "Hết hạn",
                                      style: TextStyle(
                                        color:
                                            (voucher.isActive ?? 0) == 1
                                                ? Colors.green
                                                : Colors.red,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 4),

                                // --- Giảm ---
                                Row(
                                  children: [
                                    const Text(
                                      "Giảm: ",
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      (voucher.discountType ?? 0) == 0
                                          ? "${voucher.discountValue ?? '0'}%"
                                          : "${voucher.discountValue?.replaceAll('.00', '') ?? '0'} ₫",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 4),

                                // --- Mô tả ---
                                Text(
                                  voucher.description ?? "",
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),

                                const Divider(color: Colors.grey, thickness: 1),

                                // --- Hiệu lực ---
                                Row(
                                  children: [
                                    const Text(
                                      "Hiệu lực: ",
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          (voucher.startDate ?? "")
                                              .split("T")
                                              .first,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const Text(" - "),
                                        Text(
                                          (voucher.endDate ?? "")
                                              .split("T")
                                              .first,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                                // --- Điều kiện ---
                                Row(
                                  children: [
                                    const Text(
                                      "Điều kiện: ",
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      "Đơn hàng từ ${voucher.minOrderValue?.replaceAll('.00', '') ?? '0'} ₫",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),

                                // --- Số lượng ---
                                Row(
                                  children: [
                                    const Text(
                                      "Số lượng: ",
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      (voucher.usageLimitPerVoucher ?? 0)
                                          .toString(),
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),

                                // --- Đã sử dụng ---
                                Row(
                                  children: [
                                    const Text(
                                      "Đã sử dụng: ",
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      (voucher.currentUsageCount ?? 0)
                                          .toString(),
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),

                                const Divider(color: Colors.grey, thickness: 1),

                                // --- Nút xóa ---
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const SizedBox(width: 8),
                                    IconButton(
                                      onPressed: () {
                                        CustomDialog.show(
                                          context: context,
                                          color: Colors.red,
                                          title: "Xóa mã giảm giá",
                                          content:
                                              "Bạn có chắc muốn xóa mã giảm giá này không?",
                                          onPressed: () {
                                            controller.deleteVoucher(
                                              voucher.uuid ?? "",
                                            );
                                            Get.back();
                                          },
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      tooltip: 'Xóa',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
        );
      }),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.toNamed(Routes.createVoucher);
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
