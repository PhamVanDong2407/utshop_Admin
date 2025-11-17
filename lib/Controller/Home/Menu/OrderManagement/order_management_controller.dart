import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:utshopadmin/Global/constant.dart';
import 'package:utshopadmin/Model/Order.dart';
import 'package:utshopadmin/Service/api_caller.dart';
import 'package:utshopadmin/Util/util.dart';

class OrderManagementController extends GetxController {
  var isLoading = true.obs;
  var orderList = <ListOrderProduct>[].obs;

  // Map dữ liệu (dùng cho helper)
  final Map<int, String> sizeMap = {0: 'M', 1: 'L', 2: 'XL'};
  final Map<int, String> colorNameMap = {0: 'Trắng', 1: 'Đỏ', 2: 'Đen'};

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    try {
      isLoading(true);
      orderList.clear();

      final response = await APICaller.getInstance().get("v1/order/admin-list");

      if (response != null && response['code'] == 200) {
        final List<dynamic> data = response['data'];
        final String baseUrl = Constant.BASE_URL_IMAGE;

        orderList.value =
            data.map((json) {
              final path = json['main_image_url'];
              if (path != null && path.isNotEmpty == true) {
                json['main_image_url'] =
                    path!.startsWith('http')
                        ? path
                        : path.startsWith('resources/')
                        ? '$baseUrl$path'
                        : '$baseUrl/$path';
              }

              json['total_amount'] = json['total_amount']?.toString() ?? '0';

              return ListOrderProduct.fromJson(json);
            }).toList();
      } else {
        Utils.showSnackBar(
          title: "Lỗi",
          message: response?['message'] ?? "Không thể tải danh sách đơn hàng.",
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      debugPrint("Error fetching admin orders: $e");
      Utils.showSnackBar(
        title: "Lỗi",
        message: "Đã có lỗi xảy ra: $e",
        backgroundColor: Colors.red,
      );
    } finally {
      isLoading(false);
    }
  }

  String getStatusText(String? status) {
    switch (status) {
      case 'pending':
        return 'Chờ xử lý';
      case 'awaiting_payment':
        return 'Chờ thanh toán';
      case 'paid':
        return 'Đã thanh toán';
      case 'shipping':
        return 'Đang giao';
      case 'delivered':
        return 'Đã giao';
      case 'cancelled':
        return 'Đã hủy';
      case 'refunded':
        return 'Đã hoàn tiền';
      default:
        return 'Không rõ';
    }
  }

  Color getStatusColor(String? status) {
    switch (status) {
      case 'pending':
      case 'awaiting_payment':
        return Colors.orange.shade700;
      case 'paid':
      case 'shipping':
        return Colors.blue.shade700;
      case 'delivered':
        return Colors.green.shade700;
      case 'cancelled':
      case 'refunded':
        return Colors.red.shade700;
      default:
        return Colors.grey.shade700;
    }
  }

  String formatCurrency(String? amountStr) {
    if (amountStr == null) return "0 ₫";
    final double amountValue = double.tryParse(amountStr) ?? 0.0;
    final formatter = NumberFormat.currency(
      locale: 'vi_VN',
      symbol: '₫',
      decimalDigits: 0,
    );
    return formatter.format(amountValue);
  }
}
