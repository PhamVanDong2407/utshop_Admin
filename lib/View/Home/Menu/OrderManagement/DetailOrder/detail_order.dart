import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utshopadmin/Controller/Home/Menu/OrderManagement/DetailOrder/detail_order_controller.dart';
import 'package:utshopadmin/Global/app_color.dart';
import 'package:utshopadmin/Model/DetailOrder.dart';

class DetailOrder extends StatelessWidget {
  DetailOrder({super.key});

  final controller = Get.put(DetailOrderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        foregroundColor: AppColor.white,
        backgroundColor: AppColor.primary,
        elevation: 0,
        title: const Text(
          "Chi tiết đơn hàng",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 24),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(color: AppColor.primary),
          );
        }
        if (controller.orderDetail.value == null) {
          return Center(
            child: Text(
              "Không thể tải chi tiết đơn hàng.",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        final order = controller.orderDetail.value!;
        final fullAddress = [
          order.address,
          order.district,
          order.province,
        ].where((s) => s != null && s.isNotEmpty).join(', ');

        return SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              // --- HỘP 1: THÔNG TIN ĐƠN HÀNG ---
              _buildInfoCard(
                title: "Thông tin đơn hàng",
                children: [
                  _buildInfoRow("Mã đơn hàng:", "#${order.orderCode ?? 'N/A'}"),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Text("Ngày đặt hàng:"),
                      Spacer(),
                      Row(
                        children: [
                          Text(
                            controller.getFormattedDate(order.createdAt),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(width: 6),
                          Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 6),
                          Text(
                            controller.getFormattedTime(order.createdAt),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  _buildInfoRow(
                    "Trạng thái:",
                    controller.getStatusText(order.status),
                    valueColor: controller.getStatusColor(order.status),
                  ),
                  SizedBox(height: 8),
                  _buildInfoRow(
                    "Phương thức thanh toán:",
                    order.paymentMethod?.toUpperCase() ?? 'N/A',
                  ),
                ],
              ),

              SizedBox(height: 16),

              // --- HỘP 2: ĐỊA CHỈ GIAO HÀNG ---
              _buildInfoCard(
                title: "Thông tin khách hàng",
                children: [
                  _buildInfoRow(
                    "Tên khách hàng:",
                    order.recipientName ?? 'N/A',
                  ),
                  SizedBox(height: 8),
                  _buildInfoRow("Số điện thoại", order.phone ?? 'N/A'),
                  SizedBox(height: 8),
                  _buildInfoRow(
                    "Địa chỉ:",
                    fullAddress.isNotEmpty ? fullAddress : 'N/A',
                    isAddress: true,
                  ),
                ],
              ),

              SizedBox(height: 16),

              // --- HỘP 3: DANH SÁCH SẢN PHẨM ---
              _buildInfoCard(
                title: "Danh sách sản phẩm",
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: order.items?.length ?? 0,
                    itemBuilder: (context, index) {
                      final item = order.items![index];
                      return _buildOrderItem(item);
                    },
                  ),
                ],
              ),

              SizedBox(height: 16),

              // --- HỘP 4: CHI TIẾT THANH TOÁN ---
              _buildInfoCard(
                title: "Chi tiết thanh toán",
                children: [
                  _buildInfoRow(
                    "Tổng tiền hàng:",
                    controller.formatCurrency(order.subtotal),
                  ),
                  SizedBox(height: 8),
                  _buildInfoRow(
                    "Phí vận chuyển:",
                    controller.formatCurrency(order.shippingFee),
                  ),
                  SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text("Giảm giá"),
                          SizedBox(width: 4),
                          Text(
                            "(${order.voucherCode ?? 'Không có'}):",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Text(
                        "-${controller.formatCurrency(order.discount)}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Divider(color: Colors.grey, height: 1),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Text(
                        "Tổng thanh toán:",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Spacer(),
                      Text(
                        controller.formatCurrency(order.totalAmount),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColor.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              // --- HỘP 5: CẬP NHẬT TRẠNG THÁI ---
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 40),
                child: Container(
                  width: double.infinity,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Hành động",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Divider(color: Colors.grey, height: 1),
                        const SizedBox(height: 16),

                        // Dropdown chọn hành động
                        Obx(
                          () => DropdownButtonFormField<String>(
                            isExpanded: true,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey.shade50,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                ),
                              ),
                            ),
                            hint: const Text('Chọn hành động...'),
                            value: controller.selectedAction.value,

                            items:
                                controller.availableActions.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                            onChanged: (String? newValue) {
                              controller.selectedAction.value = newValue;
                            },
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Nút Cập nhật
                        Obx(
                          () => SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed:
                                  (controller.selectedAction.value == null ||
                                          controller.isUpdating.value)
                                      ? null
                                      : controller.handleUpdate,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColor.primary,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                disabledBackgroundColor: Colors.grey.shade400,
                              ),
                              child:
                                  controller.isUpdating.value
                                      ? SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 3,
                                        ),
                                      )
                                      : const Text(
                                        'Cập nhật',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
      // Xóa bottomNavigationBar cũ
    );
  }

  // --- WIDGET HELPER ---
  Widget _buildInfoCard({
    required String title,
    required List<Widget> children,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(50),
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Divider(color: Colors.grey, height: 1),
              SizedBox(height: 16),
              ...children,
            ],
          ),
        ),
      ),
    );
  }

  /// Widget Row thông tin (Tên: Giá trị)
  Widget _buildInfoRow(
    String label,
    String value, {
    Color? valueColor,
    bool isAddress = false,
  }) {
    return Row(
      crossAxisAlignment:
          isAddress ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        Text("$label:"),
        SizedBox(width: 10),
        Expanded(
          flex: 2,
          child: Text(
            value,
            textAlign: TextAlign.right,
            softWrap: true,
            overflow: TextOverflow.visible,
            style: TextStyle(
              fontSize: isAddress ? 15 : 16,
              fontWeight: FontWeight.bold,
              color: valueColor ?? Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  /// Widget cho từng sản phẩm trong danh sách
  Widget _buildOrderItem(Items item) {
    // <<< Dùng Model Items của bạn
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hình ảnh
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child:
                  (item.mainImageUrl != null && item.mainImageUrl!.isNotEmpty)
                      ? Image.network(
                        item.mainImageUrl!,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (context, error, stackTrace) =>
                                const Icon(Icons.image, color: Colors.grey),
                      )
                      : const Icon(Icons.image, color: Colors.grey),
            ),
          ),
          const SizedBox(width: 15),
          // Thông tin
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.productName ?? 'Sản phẩm',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  'Số lượng: ${item.quantity ?? 0}',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColor.grey,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Phân loại: ${controller.getVariantText(item)}',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColor.grey,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Giá: ${controller.formatCurrency(item.price)}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColor.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
