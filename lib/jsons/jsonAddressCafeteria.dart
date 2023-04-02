class jsonAddressCafeteria {
  List<Address>? address;
  String? message;

  jsonAddressCafeteria({this.address, this.message});

  jsonAddressCafeteria.fromJson(Map<String, dynamic> json) {
    if (json['address'] != null) {
      address = <Address>[];
      json['address'].forEach((v) {
        address!.add(new Address.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.address != null) {
      data['address'] = this.address!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Address {
  int? id;
  int? addressCafeteriaId;
  String? street;
  double? longituded;
  double? latituded;
  int? idMunicipality;

  Address(
      {this.id,
        this.addressCafeteriaId,
        this.street,
        this.longituded,
        this.latituded,
        this.idMunicipality});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    addressCafeteriaId = json['address_cafeteria_id'];
    street = json['street'];
    longituded = json['longituded'];
    latituded = json['latituded'];
    idMunicipality = json['id_municipality'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['address_cafeteria_id'] = this.addressCafeteriaId;
    data['street'] = this.street;
    data['longituded'] = this.longituded;
    data['latituded'] = this.latituded;
    data['id_municipality'] = this.idMunicipality;
    return data;
  }
}
