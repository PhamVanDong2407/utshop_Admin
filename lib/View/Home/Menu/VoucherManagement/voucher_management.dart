import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utshopadmin/Component/custom_dialog.dart';
import 'package:utshopadmin/Global/app_color.dart';
import 'package:utshopadmin/Route/app_page.dart';

class VoucherManagement extends StatelessWidget {
  const VoucherManagement({super.key});

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
      body: ListView(
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
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
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "SUMMER23",
                          style: TextStyle(
                            color: AppColor.primary,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "Đang hoạt động",
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          "Giảm: ",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          "50.000 ₫",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Giảm 50.000 ₫ cho đơn hàng đầu tiên trên 200.000 ₫",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Divider(color: Colors.grey, thickness: 1),

                    Row(
                      children: [
                        Text(
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
                              "01/06/2024",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              " - ",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "30/06/2024",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Điều kiện: ",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          "Đơn hàng từ 200.000 ₫",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Số lượng: ",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          "100",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Đã sử dụng: ",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          "20",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Divider(color: Colors.grey, thickness: 1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {
                            Get.toNamed(Routes.editVoucher);
                          },
                          icon: Icon(Icons.edit, color: AppColor.primary),
                          tooltip: 'Chỉnh sửa',
                        ),
                        SizedBox(width: 8),
                        IconButton(
                          onPressed: () {
                            CustomDialog.show(
                              context: context,
                              color: Colors.red,
                              title: "Xóa mã giảm giá",
                              content:
                                  "Bạn có chắc muốn xóa mã giảm giá này không?",
                              onPressed: () {},
                            );
                          },
                          icon: Icon(Icons.delete, color: Colors.red),
                          tooltip: 'Xóa',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
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
