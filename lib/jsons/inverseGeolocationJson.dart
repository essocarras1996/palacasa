class inverseGeolocationJson {
  String? point;
  Province? province;
  Province? municipality;
  Province? town;
  int? address;
  Street? street;
  Street? firstStreet;

  inverseGeolocationJson(
      {this.point,
        this.province,
        this.municipality,
        this.town,
        this.address,
        this.street,
        this.firstStreet});

  inverseGeolocationJson.fromJson(Map<String, dynamic> json) {
    point = json['point'];
    province = json['province'] != null
        ? new Province.fromJson(json['province'])
        : null;
    municipality = json['municipality'] != null
        ? new Province.fromJson(json['municipality'])
        : null;
    town = json['town'] != null ? new Province.fromJson(json['town']) : null;
    address = json['address'];
    street =
    json['street'] != null ? new Street.fromJson(json['street']) : null;
    firstStreet = json['first_street'] != null
        ? new Street.fromJson(json['first_street'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['point'] = this.point;
    if (this.province != null) {
      data['province'] = this.province!.toJson();
    }
    if (this.municipality != null) {
      data['municipality'] = this.municipality!.toJson();
    }
    if (this.town != null) {
      data['town'] = this.town!.toJson();
    }
    data['address'] = this.address;
    if (this.street != null) {
      data['street'] = this.street!.toJson();
    }
    if (this.firstStreet != null) {
      data['first_street'] = this.firstStreet!.toJson();
    }
    return data;
  }
}

class Province {
  int? id;
  String? name;

  Province({this.id, this.name});

  Province.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Street {
  String? name;

  Street({this.name});

  Street.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}
