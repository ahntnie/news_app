import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
          width: MediaQuery.of(context).size.width / 1.8,
          height: 50,
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
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(top: 70, left: 20, right: 20),
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
                  height: MediaQuery.of(context).size.height / 2.4,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, top: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Tài khoản",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, bottom: 15),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            height: 60,
                            child: TextField(
                              controller: _accountNameController,
                              onChanged: (_) => validateAccountName(),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: "Nhập tên tài khoản",
                                labelStyle: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                                contentPadding:
                                    const EdgeInsets.only(left: 20, bottom: 10),
                                errorText: _accountNameError.isNotEmpty
                                    ? _accountNameError
                                    : null,
                              ),
                            ),
                          ),
                        ),
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Mật khẩu",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            height: 60,
                            child: TextField(
                              obscureText: _obscureText,
                              controller: _passwordController,
                              onChanged: (_) => validatePassword(),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: "Nhập mật khẩu",
                                labelStyle: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
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
                                contentPadding:
                                    const EdgeInsets.only(left: 20, bottom: 10),
                                errorText: _accountPasswordError.isNotEmpty
                                    ? _accountPasswordError
                                    : null,
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 10, left: 160),
                          child: InkWell(
                            child: Text(
                              "Quên mật khẩu",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 180),
                  child: ElevatedButton(
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
                          _showSuccessDialog(context);
                        } else {
                          print("User or Password is not Correct !!");
                          _showFailedDialog(context);
                        }
                        ;
                      },
                      child: const Text(
                        "Đăng nhập",
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          side: MaterialStateProperty.all<BorderSide>(
                              const BorderSide(color: Colors.grey, width: 2)),
                          minimumSize: MaterialStateProperty.all<Size>(
                              const Size(double.infinity, 60)),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white)),
                      onPressed: () {
                        signInWithGoogle().then((userCredential) {
                          print("đăng nhập thành công");
                          _showSuccessDialog(context);
                        }).catchError((error) {
                          _showFailedDialog(context);
                          print('Sign in with Google error: $error');
                        });
                        ;
                      },
                      child: const Text(
                        "Đăng nhập bằng Google",
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      )),
                ),
                SizedBox(
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Bạn chưa có tài khoản ?",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const SignupView()));
                        },
                        child: const Text(
                          "Đăng ký",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.red,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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
                style: TextStyle(fontSize: 20),
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
                Navigator.pop(context);
              },
              child: const Text('Đóng'),
            ),
          ],
        );
      },
    );
  }

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
              Text('Đăng nhập thất bại'),
            ],
          ),
          content: const Text(
            'Tên tài khoản hoặc mật khẩu không đúng !! Vui lòng đăng nhập lại',
            style: TextStyle(fontSize: 20),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Đóng'),
            ),
          ],
        );
      },
    );
  }
}
