class LoginModel {
  String? message;
  String? status;
  UserData? data;

  LoginModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }
}

class UserData {
  String? token;
  String? username;
  String? email;

  UserData.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    username = json['username'];
    email = json['email'];
  }
}
