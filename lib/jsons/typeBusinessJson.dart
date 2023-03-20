class typeBusinessJson {
  List<TypeBusiness>? typeBusiness;
  String? message;

  typeBusinessJson({this.typeBusiness, this.message});

  typeBusinessJson.fromJson(Map<String, dynamic> json) {
    if (json['typeBusiness'] != null) {
      typeBusiness = <TypeBusiness>[];
      json['typeBusiness'].forEach((v) {
        typeBusiness!.add(new TypeBusiness.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.typeBusiness != null) {
      data['typeBusiness'] = this.typeBusiness!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class TypeBusiness {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;

  TypeBusiness({this.id, this.name, this.createdAt, this.updatedAt});

  TypeBusiness.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
