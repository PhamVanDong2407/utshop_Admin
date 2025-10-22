class Users {
  String? uuid;
  String? name;
  String? email;
  String? phone;
  int? status;
  int? permissionId;
  String? permissionName;

  Users(
      {this.uuid,
      this.name,
      this.email,
      this.phone,
      this.status,
      this.permissionId,
      this.permissionName});

  Users.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    status = json['status'];
    permissionId = json['permission_id'];
    permissionName = json['permission_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uuid'] = uuid;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['status'] = status;
    data['permission_id'] = permissionId;
    data['permission_name'] = permissionName;
    return data;
  }
}
