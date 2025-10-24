class Vouchers {
  String? uuid;
  String? code;
  String? description;
  int? discountType;
  String? discountValue;
  String? minOrderValue;
  String? maxDiscountAmount;
  String? startDate;
  String? endDate;
  int? usageLimitPerVoucher;
  int? currentUsageCount;
  int? isActive;

  Vouchers(
      {this.uuid,
      this.code,
      this.description,
      this.discountType,
      this.discountValue,
      this.minOrderValue,
      this.maxDiscountAmount,
      this.startDate,
      this.endDate,
      this.usageLimitPerVoucher,
      this.currentUsageCount,
      this.isActive});

  Vouchers.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    code = json['code'];
    description = json['description'];
    discountType = json['discount_type'];
    discountValue = json['discount_value'];
    minOrderValue = json['min_order_value'];
    maxDiscountAmount = json['max_discount_amount'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    usageLimitPerVoucher = json['usage_limit_per_voucher'];
    currentUsageCount = json['current_usage_count'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uuid'] = uuid;
    data['code'] = code;
    data['description'] = description;
    data['discount_type'] = discountType;
    data['discount_value'] = discountValue;
    data['min_order_value'] = minOrderValue;
    data['max_discount_amount'] = maxDiscountAmount;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['usage_limit_per_voucher'] = usageLimitPerVoucher;
    data['current_usage_count'] = currentUsageCount;
    data['is_active'] = isActive;
    return data;
  }
}
