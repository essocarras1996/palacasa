class businessAdminJson {
  Cafeterias? cafeterias;
  List<TypeBusiness>? typeBusiness;
  String? message;

  businessAdminJson({this.cafeterias, this.typeBusiness, this.message});

  businessAdminJson.fromJson(Map<String, dynamic> json) {
    cafeterias = json['cafeterias'] != null
        ? new Cafeterias.fromJson(json['cafeterias'])
        : null;
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
      data['cafeterias'] = this.cafeterias!.toJson();
    }
    if (this.typeBusiness != null) {
      data['typeBusiness'] = this.typeBusiness!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Cafeterias {
  int? currentPage;
  List<Data>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  Null? nextPageUrl;
  String? path;
  int? perPage;
  Null? prevPageUrl;
  int? to;
  int? total;

  Cafeterias(
      {this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.links,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total});

  Cafeterias.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class Data {
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

  Data(
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

  Data.fromJson(Map<String, dynamic> json) {
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

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['label'] = this.label;
    data['active'] = this.active;
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
