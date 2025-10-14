import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utshopadmin/Global/app_color.dart';
import 'package:utshopadmin/Route/app_page.dart';

class OrderManagement extends StatelessWidget {
  const OrderManagement({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        foregroundColor: AppColor.white,
        backgroundColor: AppColor.primary,
        elevation: 0,
        title: const Text(
          "Quản lý đơn hàng",
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
          GestureDetector(
            onTap: () {
              Get.toNamed(Routes.detailOrder);
            },
            child: Padding(
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
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Đơn hàng ",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "#12",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.green.shade700,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "Chờ xác nhận",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.orange.shade700,
                            ),
                          ),
                        ],
                      ),

                      Divider(color: Colors.grey, thickness: 1),

                      Row(
                        children: [
                          Text(
                            "Khách hàng: ",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade700,
                            ),
                          ),
                          Text(
                            "Nguyễn Văn A",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),

                      Row(
                        children: [
                          Text(
                            "Tên sản phẩm: ",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade700,
                            ),
                          ),
                          Text(
                            "Áo Yonex Lee Dan",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),

                      Divider(color: Colors.grey, thickness: 1),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Tổng tiền: ",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "500,000đ",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.blue.shade700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
