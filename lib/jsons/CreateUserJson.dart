import 'User.dart';

class createUserJson {
  User? user;
  String? accessToken;
  String? message;

  createUserJson({this.user, this.accessToken, this.message});

  createUserJson.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    accessToken = json['access_token'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['access_token'] = this.accessToken;
    data['message'] = this.message;
    return data;
  }
}