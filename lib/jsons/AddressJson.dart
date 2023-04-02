class AddressJson {
  Addresses? addresses;
  String? message;

  AddressJson({this.addresses, this.message});

  AddressJson.fromJson(Map<String, dynamic> json) {
    addresses = json['addresses'] != null
        ? new Addresses.fromJson(json['addresses'])
        : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.addresses != null) {
      data['addresses'] = this.addresses!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Addresses {
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

  Addresses(
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

  Addresses.fromJson(Map<String, dynamic> json) {
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
  int? id_municipio;
  int? id_select;
  String? street;
  double? longituded;
  double? latituded;
  String? province;
  String? municipality;
  String? alias;
  String? beneficiario;
  String? phone;
  int? defaultAddress;

  Data(
      { this.id,
        this.id_municipio,
        this.id_select,
        this.street,
        this.longituded,
        this.latituded,
        this.province,
        this.municipality,
        this.alias,
        this.beneficiario,
        this.phone,
        this.defaultAddress});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    id_municipio = json['id_municipio'];
    id_select = json['id_select'];
    street = json['street'];
    longituded = json['longituded'];
    latituded = json['latituded'];
    province = json['province'];
    municipality = json['municipality'];
    alias = json['alias'];
    beneficiario = json['beneficiario'];
    phone = json['phone'];
    defaultAddress = json['default_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['street'] = this.street;
    data['longituded'] = this.longituded;
    data['latituded'] = this.latituded;
    data['province'] = this.province;
    data['municipality'] = this.municipality;
    data['alias'] = this.alias;
    data['beneficiario'] = this.beneficiario;
    data['phone'] = this.phone;
    data['default_address'] = this.defaultAddress;
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
