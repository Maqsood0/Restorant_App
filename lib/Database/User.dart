import 'dart:convert';

User clientFromJson(String str) {
  final jsonData = json.decode(str);
  return User.fromMap(jsonData);
}

String UserToJson(User data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class User {
  String? FullName;
  String Email;
  String Password;

  User(
    this.FullName,
    this.Email,
    this.Password,
  );

  factory User.fromMap(Map<String, dynamic> json) => new User(
        json["Fullname"],
        json["Email"],
        json["Password"],
      );

  Map<String, dynamic> toMap() => {
        "Fullname": FullName,
        "Email": Email,
        "Password": Password,
      };
}
