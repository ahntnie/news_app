import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:news_app/View/DrawerView.dart';
import 'package:news_app/View/ForgetPasswordView.dart';
import 'package:news_app/View/HomeView.dart';
import 'package:news_app/View/NavigationBarView.dart';
import 'package:news_app/View/SignupView.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

Future<User?> signInWithGoogle() async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  GoogleSignInAccount? googleSignInAccount;

  try {
    googleSignInAccount =
        await googleSignIn.signIn().catchError((onError) => null);
  } catch (e) {
    print("Không đăng nhập được!!!");
  }

  if (googleSignInAccount != null) {
    final GoogleSignInAuthentication googleAuth =
        await googleSignInAccount!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    try {
      final UserCredential authResult =
          await auth.signInWithCredential(credential);
      final User? user = authResult.user;
      String? userName = user!.displayName;
      print('Tên Gmail của người dùng: $userName');
      return user;
    } on FirebaseAuthException catch (e) {
    } catch (e) {
      // ...
    }
  }
  return null;
}

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
  } on FirebaseAuthException catch (e) {
    if (e.code == "user-not-found") {
      print("No user found that email");
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
                            // ignore: use_build_context_synchronously
                            _showSuccessDialog(context);
                          } else {
                            print("User or Password is not Correct !!");
                            // ignore: use_build_context_synchronously
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
                    signInWithGoogle().then((userCredential) {
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
                'Đăng nhập thành công',
              ),
            ],
          ),
          content: const Text(
            'Chúc mừng! Bạn đã đăng nhập thành công.',
            style: TextStyle(fontSize: 20),
          ),
          actions: [
            TextButton(
              onPressed: () {
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
                style: TextStyle(fontSize: size(context, 10)),
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
