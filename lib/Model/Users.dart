class Users{
  final String name;
  final String email;
  final String phone;
  final DateTime birth;
  final String password;
  final bool gender;

  Users({
    required this.name,
    required this.email,
    required this.password,
    required this.birth,
    required this.phone,
    required this.gender
  });
}
