class ListOrderProduct {
  String? uuid;
  String? orderCode;
  String? totalAmount;
  String? status;
  String? createdAt;
  String? customerName;
  String? productName;
  String? mainImageUrl;

  ListOrderProduct(
      {this.uuid,
      this.orderCode,
      this.totalAmount,
      this.status,
      this.createdAt,
      this.customerName,
      this.productName,
      this.mainImageUrl});

  ListOrderProduct.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    orderCode = json['order_code'];
    totalAmount = json['total_amount'];
    status = json['status'];
    createdAt = json['created_at'];
    customerName = json['customer_name'];
    productName = json['product_name'];
    mainImageUrl = json['main_image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uuid'] = uuid;
    data['order_code'] = orderCode;
    data['total_amount'] = totalAmount;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['customer_name'] = customerName;
    data['product_name'] = productName;
    data['main_image_url'] = mainImageUrl;
    return data;
  }
}
