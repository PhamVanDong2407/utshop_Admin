import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utshopadmin/Controller/Home/Menu/Revenue%20Management/revenue_management_controller.dart';
import 'package:utshopadmin/Global/app_color.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';

class ReveuneManagement extends StatelessWidget {
  ReveuneManagement({super.key});

  final controller = Get.put(RevenueManagementController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f7fa),
      appBar: AppBar(
        foregroundColor: AppColor.white,
        backgroundColor: AppColor.primary,
        elevation: 1,
        title: const Text(
          "Quản lý doanh thu",
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

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildPeriodSelector(),
                const SizedBox(height: 8),
                Center(
                  child: Text(
                    controller.dateRange.value,
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  ),
                ),
                const SizedBox(height: 24),
                _buildKpiCards(), // KPI cards
                const SizedBox(height: 24),
                _buildRevenueChart(), // Biểu đồ
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildPeriodSelector() {
    final periods = ['Theo Tuần', 'Theo Tháng', 'Theo Năm'];
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.withAlpha(38),
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(periods.length, (index) {
          bool isSelected = controller.selectedPeriodIndex.value == index;
          return Expanded(
            child: GestureDetector(
              onTap: () {
                controller.onPeriodChanged(index);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? AppColor.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(25.0),
                  boxShadow:
                      isSelected
                          ? [
                            BoxShadow(
                              color: AppColor.primary.withAlpha(77),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ]
                          : [],
                ),
                child: Text(
                  periods[index],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black87,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildKpiCards() {
    // Lấy data từ controller, nếu null thì = 0
    final kpi = controller.kpiStats.value;
    final revenue = kpi?.totalRevenue ?? 0.0;
    final orders = kpi?.totalOrders ?? 0;

    return Row(
      children: [
        Expanded(
          child: _buildKpiCard(
            title: 'Tổng Doanh Thu',
            value: controller.currencyFormatter.format(revenue),
            icon: Icons.monetization_on_outlined,
            color: Colors.green,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildKpiCard(
            title: 'Tổng Đơn Hàng',
            value: NumberFormat.decimalPattern('vi_VN').format(orders),
            icon: Icons.receipt_long_outlined,
            color: Colors.orange,
          ),
        ),
      ],
    );
  }

  Widget _buildKpiCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border(left: BorderSide(color: color, width: 5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(50),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 32, color: color),
          const SizedBox(height: 12),
          Text(title, style: TextStyle(color: Colors.grey[600], fontSize: 14)),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildRevenueChart() {
    final gradient = LinearGradient(
      colors: [AppColor.primary, AppColor.primary.withAlpha(128)],
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
    );

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(50),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Biểu đồ doanh thu (Triệu đồng)',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 300,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: controller.maxY.value,
                barTouchData: BarTouchData(
                  enabled: true,
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipColor: (_) => Colors.black87,
                    tooltipPadding: const EdgeInsets.all(8),
                    tooltipMargin: 8,
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      return BarTooltipItem(
                        // Làm tròn 2 số thập phân
                        '${rod.toY.toStringAsFixed(2)} Tr',
                        const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      );
                    },
                  ),
                ),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        String text = '';
                        // Lấy label từ controller
                        if (index >= 0 &&
                            index < controller.chartLabels.length) {
                          text = controller.chartLabels[index];
                        }

                        // Chỉ hiển thị 1 số label nếu là "Theo Tháng"
                        if (controller.selectedPeriodIndex.value == 1) {
                          // Theo Tháng
                          if ((index + 1) % 5 != 0 && index != 0) {
                            // Chỉ show 1, 5, 10...
                            text = '';
                          }
                        }

                        return SideTitleWidget(
                          axisSide: meta.axisSide,
                          space: 8.0,
                          child: Text(
                            text,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        );
                      },
                      reservedSize: 30,
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: (value, meta) {
                        // Hiển thị các mốc 10 triệu
                        if (value % (controller.maxY.value / 6) == 0) {
                          return Text(
                            '${value.toInt()} Tr',
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                          );
                        }
                        return const Text('');
                      },
                    ),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                borderData: FlBorderData(show: false),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: controller.maxY.value / 6, // Chia lưới
                  getDrawingHorizontalLine:
                      (value) => const FlLine(
                        color: Color(0xffe7e8ec),
                        strokeWidth: 1,
                      ),
                ),
                barGroups: List.generate(controller.chartData.length, (index) {
                  return BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        toY: controller.chartData[index].value,
                        gradient: gradient,
                        width:
                            (controller.selectedPeriodIndex.value == 1)
                                ? 5
                                : 22, // Cột nhỏ hơn cho "Tháng"
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(6),
                          topRight: Radius.circular(6),
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
