
class Users {
  final String name;
  final String email;
  final String phone;
  final DateTime birth;
  final String password;
  final bool gender;

  Users(
      {required this.name,
      required this.email,
      required this.password,
      required this.birth,
      required this.phone,
      required this.gender});

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      name: json['name'],
      email: json['email'],
      password: json['password'],
      birth: DateTime.parse(json['birth']),
      phone: json['phone'],
      gender: json['gender'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'birth': birth.toIso8601String(),
      'phone': phone,
      'gender': gender,
    };
  }
}
