import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:news_app/Repository/UserRepository.dart';
import 'package:news_app/View/HomeView.dart';
import 'package:news_app/View/SignupView.dart';

import '../Model/Users.dart';
import 'DrawerView.dart';
import 'ForgetPasswordView.dart';
import 'NavigationBarView.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

//hàm đăng nhập bằng Google
_signInWithGoogle() async {
  GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);

  print(userCredential.user?.displayName);
}

//hàm đăng nhập bằng username và password của firebase
Future<User?> loginUsingEmailPassword(
    {required String email,
    required String password,
    required BuildContext context}) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;
  try {
    UserCredential userCredential =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    user = userCredential.user;
    UserRepository.saveUser(Users(
        name: user!.displayName.toString(),
        email: email,
        password: password,
        birth: DateTime(2024),
        phone: "",
        gender: true));
  } on FirebaseAuthException catch (e) {
    if (e.code == "không tồn tại") {
      print("Không tìm thấy user");
    }
  }
  return user;
}

class _LoginViewState extends State<LoginView> {
  bool _obscureText = true;
  final TextEditingController _accountNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _accountNameError = '';
  String _accountPasswordError = '';
  //hàm kiểm tra tài khoản
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

  //hàm kiểm tra email
  void validateEmail() {
    setState(() {
      final email = _accountNameController.text.trim();
      if (email.isEmpty) {
        _accountNameError = 'Email không được bỏ trống';
      } else if (!_isValidEmail(email)) {
        _accountNameError = 'Email không hợp lệ';
      } else {
        _accountNameError = '';
      }
    });
  }

  bool _isValidEmail(String email) {
    // Biểu thức chính quy để kiểm tra định dạng email
    const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    final regex = RegExp(pattern);
    return regex.hasMatch(email);
  }

  //hàm kiểm tra password
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

  @override
  void dispose() {
    _accountNameController.dispose();
    super.dispose();
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
                    "Đăng nhập",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
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
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Tài khoản",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: size(context, 7),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          controller: _accountNameController,
                          onChanged: (_) => validateEmail(),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: "Nhập email",
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
                      Padding(
                        padding: EdgeInsets.only(top: size(context, 5)),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Mật khẩu",
                            style: TextStyle(
                                fontSize: size(context, 7),
                                fontWeight: FontWeight.bold),
                          ),
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
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: size(context, 5)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ForgetPasswordView()));
                              },
                              child: Text(
                                "Quên mật khẩu",
                                style: TextStyle(
                                    fontSize: size(context, 6),
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: size(context, 5)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.blue.shade100)),
                        onPressed: () async {
                          validateAccountName();
                          validatePassword();
                          var user = await loginUsingEmailPassword(
                              email: _accountNameController.text,
                              password: _passwordController.text,
                              context: context);
                          print(user);
                          if (user != null) {
                            print("Email là : " + _accountNameController.text);
                            //Gọi hàm đăng nhập thành công
                            _showSuccessDialog(context);
                          } else {
                            print("User or Password is not Correct !!");
                            //Gọi hàm đăng nhập thất bại
                            _showFailedDialog(context);
                          }
                          ;
                        },
                        child: Text(
                          "Đăng nhập",
                          style: TextStyle(
                              color: Colors.black, fontSize: size(context, 8)),
                        )),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: size(context, 10)),
                child: InkWell(
                  onTap: () {
                    _signInWithGoogle().then((userCredential) {
                      print("đăng nhập thành công");
                      _showSuccessDialog(context);
                    }).catchError((error) {
                      _showFailedDialog(context);
                      print('Sign in with Google error: $error');
                    });
                  },
                  child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: size(context, 10)),
                        child: Text(
                          "Đăng nhập bằng Google",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: size(context, 9),
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                ),
              ),
              SizedBox(
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      "Bạn chưa có tài khoản? ",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const SignupView()));
                      },
                      child: const Text(
                        "Đăng ký",
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNav(idx: 2),
      drawer: const DrawerView(),
    );
  }

//hàm show thông báo đăng nhập thành công
  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              const Icon(
                Icons.check_circle,
                color: Colors.green,
              ),
              const SizedBox(width: 5),
              Text(
                'Đăng nhập thành công',
                style: TextStyle(fontSize: size(context, 9)),
              ),
            ],
          ),
          content: const Text(
            'Chúc mừng! Bạn đã đăng nhập thành công.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pop(context);
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const HomeView()));
              },
              child: const Text('Đóng'),
            ),
          ],
        );
      },
    );
  }

  int baseScreenSize = 375;

  double size(BuildContext context, int baseSize) {
    final screenSize = MediaQuery.of(context).size.height;
    return baseSize * (screenSize / baseScreenSize);
  }
//hàm show thông báo đăng nhập thất bại

  void _showFailedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              const Icon(
                Icons.close_outlined,
                color: Colors.red,
              ),
              Text(
                'Đăng nhập thất bại',
                style: TextStyle(fontSize: size(context, 9)),
              ),
            ],
          ),
          content: const Text(
            'Tên tài khoản hoặc mật khẩu không đúng !! Vui lòng đăng nhập lại',
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
