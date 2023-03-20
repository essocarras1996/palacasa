class User {
  String? name;
  String? lastname;
  String? email;
  String? photo;
  String? phone;
  String? birthday;
  String? gender;
  String? id_role;
  String? updatedAt;
  String? createdAt;
  int? id;

  User(
      { this.name,
        this.lastname,
        this.email,
        this.photo,
        this.id_role,
        this.phone,
        this.birthday,
        this.gender,
        this.updatedAt,
        this.createdAt,
        this.id});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    lastname = json['lastname'];
    email = json['email'];
    photo = json['photo'];
    id_role = '${json['id_role']}';
    phone = json['phone'];
    birthday = json['birthday'];
    gender = json['gender'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['photo'] = this.photo;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}