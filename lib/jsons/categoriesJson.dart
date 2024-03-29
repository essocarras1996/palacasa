class categoriesJson {
  List<Categories>? categories;
  List<CafeteriasPopulares>? cafeteriasPopulares;
  String? message;

  categoriesJson({this.categories, this.cafeteriasPopulares, this.message});

  categoriesJson.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
    if (json['cafeterias_populares'] != null) {
      cafeteriasPopulares = <CafeteriasPopulares>[];
      json['cafeterias_populares'].forEach((v) {
        cafeteriasPopulares!.add(new CafeteriasPopulares.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    if (this.cafeteriasPopulares != null) {
      data['cafeterias_populares'] =
          this.cafeteriasPopulares!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Categories {
  int? id;
  String? idType;
  String? name;
  String? image;
  String? createdAt;
  String? updatedAt;

  Categories(
      {this.id,
        this.idType,
        this.name,
        this.image,
        this.createdAt,
        this.updatedAt});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idType = json['id_type'];
    name = json['name'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_type'] = this.idType;
    data['name'] = this.name;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class CafeteriasPopulares {
  int? id;
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

  CafeteriasPopulares(
      {this.id,
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

  CafeteriasPopulares.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
