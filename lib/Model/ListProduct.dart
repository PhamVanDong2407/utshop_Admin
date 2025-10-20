class ListProduct {
  String? uuid;
  String? name;
  String? price;
  String? mainImage;

  ListProduct({this.uuid, this.name, this.price, this.mainImage});

  ListProduct.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    name = json['name'];
    price = json['price'];
    mainImage = json['main_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uuid'] = uuid;
    data['name'] = name;
    data['price'] = price;
    data['main_image'] = mainImage;
    return data;
  }
}
