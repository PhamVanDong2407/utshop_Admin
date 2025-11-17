import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:utshopadmin/Model/RevenueStats.dart';
import 'package:utshopadmin/Service/api_caller.dart';
import 'package:utshopadmin/Util/util.dart';

class RevenueManagementController extends GetxController {
  var isLoading = true.obs;

  var selectedPeriodIndex = 1.obs;
  var dateRange = "".obs;

  var kpiStats = Rx<KpiStats?>(null);
  var chartData = <ChartDataPoint>[].obs;

  final currencyFormatter = NumberFormat.currency(locale: 'vi_VN', symbol: 'đ');
  var chartLabels = <String>[].obs;
  var maxY = 100.0.obs; // Max Y-axis

  @override
  void onInit() {
    super.onInit();
    fetchRevenueStats(1);
  }

  /// Gọi khi người dùng nhấn vào Tuần/Tháng/Năm
  void onPeriodChanged(int index) {
    selectedPeriodIndex.value = index;
    fetchRevenueStats(index);
  }

  Future<void> fetchRevenueStats(int index) async {
    try {
      isLoading(true);

      String period = 'month';
      if (index == 0) period = 'week';
      if (index == 2) period = 'year';

      _updateDateRange(index);

      final response = await APICaller.getInstance().get(
        "v1/reveune?period=$period",
      );

      if (response != null && response['code'] == 200) {
        final stats = RevenueStats.fromJson(response['data']);
        kpiStats.value = stats.kpi;
        chartData.value = stats.chartData;

        _updateChartHelpers(period);
      } else {
        Utils.showSnackBar(
          title: "Lỗi",
          message: response?['message'] ?? "Không thể tải dữ liệu.",
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      debugPrint("Error fetching revenue: $e");
    } finally {
      isLoading(false);
    }
  }

  /// Cập nhật dải ngày hiển thị
  void _updateDateRange(int index) {
    final now = DateTime.now();
    switch (index) {
      case 0: // Tuần
        final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
        final endOfWeek = startOfWeek.add(const Duration(days: 6));
        dateRange.value =
            '${DateFormat('dd/MM').format(startOfWeek)} - ${DateFormat('dd/MM/yyyy').format(endOfWeek)}';
        break;
      case 1: // Tháng
        dateRange.value = 'Tháng ${now.month}, ${now.year}';
        break;
      case 2: // Năm
        dateRange.value = 'Năm ${now.year}';
        break;
    }
  }

  /// Cập nhật các thông số cho biểu đồ
  void _updateChartHelpers(String period) {
    if (period == 'week') {
      chartLabels.value = ['T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'CN'];
    } else if (period == 'year') {
      chartLabels.value = [
        'T1',
        'T2',
        'T3',
        'T4',
        'T5',
        'T6',
        'T7',
        'T8',
        'T9',
        'T10',
        'T11',
        'T12',
      ];
    } else {
      // month
      // Lấy 31 ngày (Backend đã xử lý)
      chartLabels.value = List.generate(31, (i) => (i + 1).toString());
    }

    // Tính max Y
    double maxVal = 0;
    if (chartData.isNotEmpty) {
      maxVal = chartData.map((d) => d.value).reduce((a, b) => a > b ? a : b);
    }
    // Làm tròn lên 10 đơn vị
    maxY.value = (maxVal == 0) ? 50 : (maxVal / 10).ceil() * 10.0;
  }
}
