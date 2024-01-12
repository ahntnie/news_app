import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  // Đặt lại mật khẩu
  void resetPassword(String email) {
    FirebaseAuth.instance
        .sendPasswordResetEmail(email: _email.text)
        .then((value) {
      // Đặt lại mật khẩu thành công
      print('Đã gửi email đặt lại mật khẩu');
    }).catchError((error) {
      // Xảy ra lỗi khi đặt lại mật khẩu
      print('Lỗi: $error');
    });
  }

  final TextEditingController _email = TextEditingController();
  String _emailError = '';
  void validateEmail() {
    setState(() {
      final email = _email.text.trim();
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
          width: MediaQuery.of(context).size.width / 1.8,
          height: 50,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Quên mật khẩu",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
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
                      border:
                          Border.all(color: Colors.blue.shade200, width: 2.0),
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2.4,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10, top: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Nhập Email của tài khoản",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 10,
                              right: 10,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              height: 60,
                              child: TextField(
                                controller: _email,
                                onChanged: (_) => validateEmail(),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: _emailError.isEmpty
                                      ? 'Nhập email của bạn....'
                                      : " ",
                                  labelStyle: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  errorText: _emailError.isNotEmpty
                                      ? _emailError
                                      : null,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.blue.shade100)),
                        onPressed: () {
                          validateEmail();
                          if (_emailError.isEmpty) {
                            _showSuccessDialog(context);
                            resetPassword(_email.text);
                          } else {
                            _showFailedDialog(context);
                          }
                        },
                        child: const Text(
                          "Gửi email",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        )),
                  ),
                ],
              ),
            )),
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
                'Hoàn tất',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
          content: const Text(
            'Vui lòng kiểm tra email của bạn',
            style: TextStyle(fontSize: 20),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  Navigator.of(context).pop();
                });
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
              Text('Thất bại'),
            ],
          ),
          content: const Text(
            'Vui lòng nhập đúng thông tin',
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
