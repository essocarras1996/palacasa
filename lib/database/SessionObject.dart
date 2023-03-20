
final String tableSesion = 'Sesion';

class SessionObjectFields{
  static final List<String> values = [id, name,lastname,email,phone,photo,id_role,birthday,gender,token];
  static final String id = '_id';
  static final String name = '_name';
  static final String lastname = '_lastname';
  static final String email = '_email';
  static final String phone = '_phone';
  static final String photo = '_photo';
  static final String id_role = '_id_role';
  static final String birthday = '_birthday';
  static final String gender = '_gender';
  static final String token = '_token';


}

class SessionObject{
  final int? id;
  late final String name;
  final String lastname;
  final String email;
  final String phone;
  final String photo;
  final String id_role;
  final String birthday;
  final String gender;
  final String token;


  SessionObject(
      {
        required this.id,
        required this.name,
        required this.lastname,
        required this.email,
        required this.phone,
        required this.photo,
        required this.id_role,
        required this.birthday,
        required this.gender,
        required this.token,

      });

  Map<String,Object?> toJson() => {
    SessionObjectFields.id: id,
    SessionObjectFields.name: name,
    SessionObjectFields.lastname: lastname,
    SessionObjectFields.email: email,
    SessionObjectFields.phone: phone,
    SessionObjectFields.photo: photo,
    SessionObjectFields.id_role: id_role,
    SessionObjectFields.birthday: birthday,
    SessionObjectFields.gender: gender,
    SessionObjectFields.token: token
  };

  static SessionObject fromJson(Map<String,Object?> json) => SessionObject(
    id: json[SessionObjectFields.id] as int?,
    name: json[SessionObjectFields.name] as String,
    lastname: json[SessionObjectFields.lastname] as String,
    email: json[SessionObjectFields.email] as String,
    phone: json[SessionObjectFields.phone] as String,
    photo: json[SessionObjectFields.photo] as String,
    id_role: json[SessionObjectFields.id_role] as String,
    birthday: json[SessionObjectFields.birthday] as String,
    gender: json[SessionObjectFields.gender] as String,
    token: json[SessionObjectFields.token] as String

  );
  SessionObject copy({
    int? id,
    String? name,
    String? lastname,
    String? email,
    String? phone,
    String? photo,
    String? id_role,
    String? birthday,
    String? gender,
    String? token
  })=>SessionObject(
    id: id ?? this.id,
    name: name ?? this.name,
    lastname:  lastname ?? this.lastname,
    email:  email ?? this.email,
    phone:  phone ?? this.phone,
    photo:  photo ?? this.photo,
    id_role:  id_role ?? this.id_role,
    birthday:  birthday ?? this.birthday,
    gender:  gender ?? this.gender,
    token:  token ?? this.token
  );

}