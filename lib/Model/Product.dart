class Product {
  Product? product;

  Product({this.product});

  Product.fromJson(Map<String, dynamic> json) {
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (product != null) {
      data['product'] = product!.toJson();
    }
    return data;
  }
}

class Products {
  String? uuid;
  String? categoryUuid;
  String? name;
  String? description;
  String? price;
  int? isPopular;
  List<Images>? images;
  List<Variants>? variants;

  Products({
    this.uuid,
    this.categoryUuid,
    this.name,
    this.description,
    this.price,
    this.isPopular,
    this.images,
    this.variants,
  });

  Products.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    categoryUuid = json['category_uuid'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    isPopular = json['is_popular'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
    if (json['variants'] != null) {
      variants = <Variants>[];
      json['variants'].forEach((v) {
        variants!.add(Variants.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uuid'] = uuid;
    data['category_uuid'] = categoryUuid;
    data['name'] = name;
    data['description'] = description;
    data['price'] = price;
    data['is_popular'] = isPopular;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    if (variants != null) {
      data['variants'] = variants!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Images {
  String? uuid;
  String? productUuid;
  String? url;
  int? isMain;

  Images({this.uuid, this.productUuid, this.url, this.isMain});

  Images.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    productUuid = json['product_uuid'];
    url = json['url'];
    isMain = json['is_main'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uuid'] = uuid;
    data['product_uuid'] = productUuid;
    data['url'] = url;
    data['is_main'] = isMain;
    return data;
  }
}

class Variants {
  String? uuid;
  String? productUuid;
  int? size;
  int? gender;
  int? color;
  int? type;
  int? stock;
  String? price;

  Variants({
    this.uuid,
    this.productUuid,
    this.size,
    this.gender,
    this.color,
    this.type,
    this.stock,
    this.price,
  });

  Variants.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    productUuid = json['product_uuid'];
    size = json['size'];
    gender = json['gender'];
    color = json['color'];
    type = json['type'];
    stock = json['stock'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uuid'] = uuid;
    data['product_uuid'] = productUuid;
    data['size'] = size;
    data['gender'] = gender;
    data['color'] = color;
    data['type'] = type;
    data['stock'] = stock;
    data['price'] = price;
    return data;
  }
}
