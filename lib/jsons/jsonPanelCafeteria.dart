class jsonPanelCafeteria {
  List<Cafeterias>? cafeterias;
  List<TypeBusiness>? typeBusiness;
  String? message;

  jsonPanelCafeteria({this.cafeterias, this.typeBusiness, this.message});

  jsonPanelCafeteria.fromJson(Map<String, dynamic> json) {
    if (json['cafeterias'] != null) {
      cafeterias = <Cafeterias>[];
      json['cafeterias'].forEach((v) {
        cafeterias!.add(new Cafeterias.fromJson(v));
      });
    }
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
    if (this.cafeterias != null) {
      data['cafeterias'] = this.cafeterias!.map((v) => v.toJson()).toList();
    }
    if (this.typeBusiness != null) {
      data['typeBusiness'] = this.typeBusiness!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Cafeterias {
  int? id;
  int? idTypeBusiness;
  String? name;
  String? description;
  String? logo;
  String? photo;
  String? horarioStart;
  String? horarioEnd;
  String? reserva;
  String? freeDelivery;
  String? tiempoEntrega;
  String? isOpen;
  String? disponible;
  String? facebook;
  String? instagram;
  String? whatsapp;
  String? createdAt;
  String? updatedAt;

  Cafeterias(
      {this.id,
        this.idTypeBusiness,
        this.name,
        this.description,
        this.logo,
        this.photo,
        this.horarioStart,
        this.horarioEnd,
        this.reserva,
        this.freeDelivery,
        this.tiempoEntrega,
        this.isOpen,
        this.disponible,
        this.facebook,
        this.instagram,
        this.whatsapp,
        this.createdAt,
        this.updatedAt});

  Cafeterias.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idTypeBusiness = json['id_typeBusiness'];
    name = json['name'];
    description = json['description'];
    logo = json['logo'];
    photo = json['photo'];
    horarioStart = json['horarioStart'];
    horarioEnd = json['horarioEnd'];
    reserva = json['reserva'];
    freeDelivery = json['free_delivery'];
    tiempoEntrega = json['tiempo_entrega'];
    isOpen = json['is_open'];
    disponible = json['disponible'];
    facebook = json['facebook'];
    instagram = json['instagram'];
    whatsapp = json['whatsapp'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_typeBusiness'] = this.idTypeBusiness;
    data['name'] = this.name;
    data['description'] = this.description;
    data['logo'] = this.logo;
    data['photo'] = this.photo;
    data['horarioStart'] = this.horarioStart;
    data['horarioEnd'] = this.horarioEnd;
    data['reserva'] = this.reserva;
    data['free_delivery'] = this.freeDelivery;
    data['tiempo_entrega'] = this.tiempoEntrega;
    data['is_open'] = this.isOpen;
    data['disponible'] = this.disponible;
    data['facebook'] = this.facebook;
    data['instagram'] = this.instagram;
    data['whatsapp'] = this.whatsapp;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
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
