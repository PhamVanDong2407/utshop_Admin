// Models/RevenueStats.dart (ĐÃ SỬA LỖI ÉP KIỂU)

// 1. Model cho 2 thẻ KPI
class KpiStats {
  final double totalRevenue;
  final int totalOrders;

  KpiStats({required this.totalRevenue, required this.totalOrders});

  factory KpiStats.fromJson(Map<String, dynamic> json) {
    return KpiStats(
      // SỬA: Chuyển đổi an toàn từ String (hoặc num) sang double
      totalRevenue: double.tryParse(json['totalRevenue']?.toString() ?? '0') ?? 0.0,
      
      // SỬA: Chuyển đổi an toàn từ String (hoặc num) sang int
      totalOrders: int.tryParse(json['totalOrders']?.toString() ?? '0') ?? 0,
    );
  }
}

// 2. Model cho 1 điểm dữ liệu trên biểu đồ
class ChartDataPoint {
  final String label;
  final double value;

  ChartDataPoint({required this.label, required this.value});

  factory ChartDataPoint.fromJson(Map<String, dynamic> json) {
    return ChartDataPoint(
      label: json['label'],
      
      // SỬA: Chuyển đổi an toàn từ String (hoặc num) sang double
      value: double.tryParse(json['value']?.toString() ?? '0') ?? 0.0,
    );
  }
}

// 3. Model tổng hợp
class RevenueStats {
  final KpiStats kpi;
  final List<ChartDataPoint> chartData;

  RevenueStats({required this.kpi, required this.chartData});

  factory RevenueStats.fromJson(Map<String, dynamic> json) {
    var kpiData = KpiStats.fromJson(json['kpi']);
    var chartList = (json['chartData'] as List)
        .map((item) => ChartDataPoint.fromJson(item))
        .toList();
        
    return RevenueStats(
      kpi: kpiData,
      chartData: chartList,
    );
  }
}