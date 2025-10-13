import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utshopadmin/Global/app_color.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';

class ReveuneManagement extends StatefulWidget {
  const ReveuneManagement({super.key});

  @override
  State<ReveuneManagement> createState() => _ReveuneManagementState();
}

class _ReveuneManagementState extends State<ReveuneManagement> {
  int _selectedPeriodIndex = 1;

  final currencyFormatter = NumberFormat.currency(locale: 'vi_VN', symbol: 'đ');

  String _getDateRange() {
    final now = DateTime.now();
    switch (_selectedPeriodIndex) {
      case 0:
        final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
        final endOfWeek = startOfWeek.add(const Duration(days: 6));
        return '${DateFormat('dd/MM/yyyy').format(startOfWeek)} - ${DateFormat('dd/MM/yyyy').format(endOfWeek)}';
      case 1:
        return 'Tháng ${now.month}, ${now.year}';
      case 2:
        return 'Năm ${now.year}';
      default:
        return '';
    }
  }

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPeriodSelector(),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  _getDateRange(),
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
              ),
              const SizedBox(height: 24),
              _buildKpiCards(),
              const SizedBox(height: 24),
              _buildRevenueChart(),
            ],
          ),
        ),
      ),
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
          bool isSelected = _selectedPeriodIndex == index;
          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedPeriodIndex = index;
                });
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
    return Row(
      children: [
        Expanded(
          child: _buildKpiCard(
            title: 'Tổng Doanh Thu',
            value: currencyFormatter.format(125750000),
            icon: Icons.monetization_on_outlined,
            color: Colors.green,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildKpiCard(
            title: 'Tổng Đơn Hàng',
            value: '1,280',
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
    final List<double> fakeRevenueData = [20, 30, 25, 40, 45, 35, 50];
    final List<String> labels = ['T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'CN'];
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
                maxY: 60,
                barTouchData: BarTouchData(
                  enabled: true,
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipColor: (_) => Colors.black87,
                    tooltipPadding: const EdgeInsets.all(8),
                    tooltipMargin: 8,
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      return BarTooltipItem(
                        '${rod.toY.toStringAsFixed(0)} Tr',
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
                        return SideTitleWidget(
                          axisSide: meta.axisSide,
                          space: 8.0,
                          child: Text(
                            labels[value.toInt()],
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
                        if (value % 10 == 0) {
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
                  horizontalInterval: 10,
                  getDrawingHorizontalLine:
                      (value) => const FlLine(
                        color: Color(0xffe7e8ec),
                        strokeWidth: 1,
                      ),
                ),
                barGroups: List.generate(fakeRevenueData.length, (index) {
                  return BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        toY: fakeRevenueData[index],
                        gradient: gradient,
                        width: 22,
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
