class Categories {
  String? uuid;
  String? name;
  String? description;

  Categories({this.uuid, this.name, this.description});

  Categories.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    name = json['name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uuid'] = uuid;
    data['name'] = name;
    data['description'] = description;
    return data;
  }
}
