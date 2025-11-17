// TẠO FILE NÀY: Models/DashboardStats.dart

class DashboardStats {
  final double totalRevenue;
  final int totalOrders;
  final int preparingOrders;
  final int totalProducts;
  final int soldOrders;
  final int shippingOrders;
  final int cancelledOrders;

  DashboardStats({
    required this.totalRevenue,
    required this.totalOrders,
    required this.preparingOrders,
    required this.totalProducts,
    required this.soldOrders,
    required this.shippingOrders,
    required this.cancelledOrders,
  });

  factory DashboardStats.fromJson(Map<String, dynamic> json) {
    return DashboardStats(
      totalRevenue:
          double.tryParse(json['totalRevenue']?.toString() ?? '0') ?? 0.0,
      totalOrders: int.tryParse(json['totalOrders']?.toString() ?? '0') ?? 0,
      preparingOrders:
          int.tryParse(json['preparingOrders']?.toString() ?? '0') ?? 0,
      totalProducts:
          int.tryParse(json['totalProducts']?.toString() ?? '0') ?? 0,
      soldOrders: int.tryParse(json['soldOrders']?.toString() ?? '0') ?? 0,
      shippingOrders:
          int.tryParse(json['shippingOrders']?.toString() ?? '0') ?? 0,
      cancelledOrders:
          int.tryParse(json['cancelledOrders']?.toString() ?? '0') ?? 0,
    );
  }
}
