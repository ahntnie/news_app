class User {
  final String name;
  final String email;
  final String phone;
  final DateTime birth;
  final String password;
  final bool gender;

  User({
    required this.name,
    required this.email,
    required this.password,
    required this.birth,
    required this.phone,
    required this.gender
  });
}
