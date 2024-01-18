import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'DrawerView.dart';
import 'HomeView.dart';

import 'package:news_app/Model/User.dart';
import 'package:news_app/Presenter/UserPresenter.dart';
import 'package:news_app/Repository/UserRepository.dart';

import 'LoginView.dart';
import 'NavigationBarView.dart';

class SignupView extends StatefulWidget {
  const SignupView({Key? key}) : super(key: key);

  @override
  _SignupViewState createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final TextEditingController _accountNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repasswordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _accountNameError = '';
  String _accountPasswordError = '';
  String _repasswordError = '';
  String _emailError = '';
  bool _obscureText = true;
  bool _obscureText2 = true;

  void signup() async {
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    } catch (e) {
      // Xử lý lỗi
      print(e.toString());
    }
  }

  void validateAccountName() {
    setState(() {
      final accountName = _accountNameController.text.trim();
      if (accountName.isEmpty) {
        _accountNameError = 'Tên tài khoản không được bỏ trống';
      } else if (accountName.length < 8) {
        _accountNameError = 'Tên tài khoản phải tối đa 8 kí tự';
      } else {
        _accountNameError = '';
      }
    });
  }

  void validaterePassword() {
    setState(() {
      final password = _passwordController.text.trim();
      if (password.isEmpty) {
        _accountPasswordError = 'Mật khẩu không được bỏ trống';
      } else {
        _accountPasswordError = '';
      }
    });
  }

  void validatePassword() {
    setState(() {
      final accountPassword = _passwordController.text.trim();
      if (accountPassword.isEmpty) {
        _accountPasswordError = 'Mật khẩu không được bỏ trống';
      } else if (accountPassword.length < 8 ||
          !accountPassword.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
        _accountPasswordError =
            'Mật khẩu tối đa 8 kí tự và chứa kí tự đặc biệt';
      } else {
        _accountPasswordError = '';
      }
    });
  }

  void validateRepassword() {
    setState(() {
      final repassword = _repasswordController.text.trim();
      if (repassword.isEmpty) {
        _repasswordError = 'Mật khẩu không được bỏ trống';
      } else if (repassword != _passwordController.text) {
        _repasswordError = 'Mật khẩu không khớp';
      } else {
        _repasswordError = '';
      }
    });
  }

  void validateEmail() {
    setState(() {
      final email = _emailController.text.trim();
      if (email.isEmpty) {
        _emailError = 'Email không được bỏ trống';
      } else if (!_isValidEmail(email)) {
        _emailError = 'Email không hợp lệ';
      } else {
        _emailError = '';
      }
    });
  }

  bool _isValidEmail(String email) {
    // Biểu thức chính quy để kiểm tra định dạng email
    const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    final regex = RegExp(pattern);
    return regex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(20),
          ),
          width: MediaQuery.of(context).size.width / 2.2,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Đăng ký",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: size(context, 10), vertical: size(context, 20)),
          child: Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 2.0),
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: size(context, 7),
                      vertical: size(context, 10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Tài khoản",
                          style: TextStyle(
                              fontSize: size(context, 7),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          controller: _accountNameController,
                          onChanged: (_) => validateAccountName(),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: "Nhập tên tài khoản",
                            labelStyle: TextStyle(
                              fontSize: size(context, 6),
                            ),
                            contentPadding: EdgeInsets.only(
                                left: size(context, 6), bottom: 10),
                            errorText: _accountNameError.isNotEmpty
                                ? _accountNameError
                                : null,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size(context, 5),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Mật khẩu",
                          style: TextStyle(
                              fontSize: size(context, 7),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          obscureText: _obscureText,
                          controller: _passwordController,
                          onChanged: (_) => validatePassword(),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: "Nhập mật khẩu",
                            labelStyle: TextStyle(
                              fontSize: size(context, 6),
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              child: Icon(
                                _obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.black,
                              ),
                            ),
                            contentPadding: EdgeInsets.only(
                                left: size(context, 6), bottom: 10),
                            errorText: _accountPasswordError.isNotEmpty
                                ? _accountPasswordError
                                : null,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size(context, 5),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Nhập lại mật khẩu",
                          style: TextStyle(
                              fontSize: size(context, 7),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          obscureText: _obscureText2,
                          controller: _repasswordController,
                          onChanged: (_) => validatePassword(),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: "Nhập lại mật khẩu",
                            labelStyle: TextStyle(
                              fontSize: size(context, 6),
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _obscureText2 = !_obscureText2;
                                });
                              },
                              child: Icon(
                                _obscureText2
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.black,
                              ),
                            ),
                            contentPadding: EdgeInsets.only(
                                left: size(context, 6), bottom: 10),
                            errorText: _repasswordError.isNotEmpty
                                ? _accountPasswordError
                                : null,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size(context, 5),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Email",
                          style: TextStyle(
                              fontSize: size(context, 7),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          controller: _emailController,
                          onChanged: (_) => validateEmail(),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: "Nhập email",
                            labelStyle: TextStyle(
                              fontSize: size(context, 6),
                            ),
                            contentPadding: EdgeInsets.only(
                                left: size(context, 6), bottom: 10),
                            errorText:
                                _emailError.isNotEmpty ? _emailError : null,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: size(context, 5)),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.blue.shade100)),
                  onPressed: () async {
                    validateAccountName();
                    validatePassword();
                    validateRepassword();
                    validateEmail();

                    if (_accountNameError.isEmpty &&
                        _accountPasswordError.isEmpty &&
                        _repasswordError.isEmpty &&
                        _emailError.isEmpty) {
                      signup();
                      UserRepository.setUser(Users(
                          name: _accountNameController.text,
                          password: _passwordController.text,
                          email: _emailController.text,
                          birth: DateTime(0),
                          phone: "",
                          gender: true));
                      _showSuccessDialog(context);
                    } else {
                      _showFailedDialog(context);
                    }
                  },
                  child: const Text(
                    "Đăng ký",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
              ]),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    "Bạn đã có tài khoản? ",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const LoginView()));
                    },
                    child: const Text(
                      "Đăng nhập",
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNav(idx: 2),
      drawer: const DrawerView(),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.green,
              ),
              SizedBox(width: 5),
              Text(
                'Đăng ký thành công',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
          content: const Text(
            'Chúc mừng! Bạn đã đăng ký thành công.',
            style: TextStyle(fontSize: 20),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const LoginView()));
              },
              child: const Text('Đóng'),
            ),
          ],
        );
      },
    );
  }

//thông báo thất bại
  void _showFailedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(
                Icons.close_outlined,
                color: Colors.red,
              ),
              SizedBox(width: 5),
              Text('Đăng ký thất bại'),
            ],
          ),
          content: const Text(
            'Thông tin đăng ký không hợp lệ !! Vui lòng đăng ký lại',
            style: TextStyle(fontSize: 20),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Đóng'),
            ),
          ],
        );
      },
    );
  }
}
