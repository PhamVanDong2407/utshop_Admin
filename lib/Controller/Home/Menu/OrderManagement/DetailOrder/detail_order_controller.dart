// Controllers/Home/Menu/OrderManagement/DetailOrder/detail_order_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:utshopadmin/Global/constant.dart';
import 'package:utshopadmin/Model/DetailOrder.dart';
import 'package:utshopadmin/Service/api_caller.dart';
import 'package:utshopadmin/Util/util.dart';

class DetailOrderController extends GetxController {
  var isLoading = true.obs;
  var isUpdating = false.obs;
  var orderDetail = Rx<DetailOrderProdut?>(null);

  late String orderUuid;

  var availableActions =
      <String>[
        'Chờ xử lý', // pending
        'Chờ thanh toán', // awaiting_payment
        'Đã thanh toán', // paid
        'Đang giao', // shipping
        'Đã giao', // delivered
        'Đã hủy', // cancelled
      ].obs;

  // Trạng thái được chọn trong Dropdown
  var selectedAction = Rxn<String>();

  // Map dữ liệu
  final Map<int, String> sizeMap = {0: 'M', 1: 'L', 2: 'XL'};
  final Map<int, String> colorNameMap = {0: 'Trắng', 1: 'Đỏ', 2: 'Đen'};

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      orderUuid = Get.arguments as String;
      fetchOrderDetail();
    } else {
      Get.back();
      Utils.showSnackBar(title: "Lỗi", message: "Không tìm thấy mã đơn hàng.");
    }
  }

  Future<void> fetchOrderDetail() async {
    try {
      isLoading(true);
      final response = await APICaller.getInstance().get(
        "v1/order/admin/$orderUuid",
      );

      if (response != null && response['code'] == 200) {
        Map<String, dynamic> data = response['data'];

        if (data['items'] != null) {
          final String baseUrl = Constant.BASE_URL_IMAGE;
          List<dynamic> itemsList = data['items'] as List;
          for (var itemJson in itemsList) {
            final path = itemJson['main_image_url'];
            if (path != null && path.isNotEmpty == true) {
              itemJson['main_image_url'] =
                  path!.startsWith('http')
                      ? path
                      : path.startsWith('resources/')
                      ? '$baseUrl$path'
                      : '$baseUrl/$path';
            }
          }
        }
        orderDetail.value = DetailOrderProdut.fromJson(data);
        if (orderDetail.value != null) {
          selectedAction.value = getStatusText(orderDetail.value!.status);
        }
      } else {
        Utils.showSnackBar(
          title: "Lỗi",
          message: response?['message'] ?? "Không thể tải chi tiết.",
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      debugPrint("Error fetching order detail: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> handleUpdate() async {
    if (isUpdating.value) return;
    if (selectedAction.value == null) {
      Utils.showSnackBar(title: "Lỗi", message: "Vui lòng chọn một hành động.");
      return;
    }

    String newStatusKey = '';
    switch (selectedAction.value) {
      case 'Chờ xử lý':
        newStatusKey = 'pending';
        break;
      case 'Chờ thanh toán':
        newStatusKey = 'awaiting_payment';
        break;
      case 'Đã thanh toán':
        newStatusKey = 'paid';
        break;
      case 'Đang giao':
        newStatusKey = 'shipping';
        break;
      case 'Đã giao':
        newStatusKey = 'delivered';
        break;
      case 'Đã hủy':
        newStatusKey = 'cancelled';
        break;
      default:
        Utils.showSnackBar(
          title: "Lỗi",
          message: "Hành động không xác định: ${selectedAction.value}",
        );
        return;
    }

    isUpdating.value = true;
    try {
      final body = {"new_status": newStatusKey};
      final response = await APICaller.getInstance().post(
        "v1/order/admin/status/$orderUuid",
        body: body,
      );

      if (response != null && response['code'] == 200) {
        Utils.showSnackBar(
          title: "Thành công",
          message: "Đã cập nhật trạng thái: ${selectedAction.value}",
          backgroundColor: Colors.green,
        );
        fetchOrderDetail();
      } else {
        Utils.showSnackBar(
          title: "Lỗi",
          message: response?['message'] ?? "Cập nhật thất bại.",
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      debugPrint("Error updating status: $e");
    } finally {
      isUpdating.value = false;
    }
  }

  // --- CÁC HÀM HELPER CHO VIEW ---
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

  String getVariantText(Items item) {
    String color = colorNameMap[item.color] ?? 'Màu ${item.color}';
    String size = sizeMap[item.size] ?? 'Size ${item.size}';
    return "$color / $size";
  }

  String getFormattedDate(String? isoString) {
    if (isoString == null) return "--";
    try {
      return DateFormat('dd/MM/yyyy').format(DateTime.parse(isoString));
    } catch (e) {
      return "--";
    }
  }

  String getFormattedTime(String? isoString) {
    if (isoString == null) return "--";
    try {
      return DateFormat('HH:mm').format(DateTime.parse(isoString));
    } catch (e) {
      return "--";
    }
  }
}
