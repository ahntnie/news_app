import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:flutter/widgets.dart';
import 'package:news_app/Repository/UserRepository.dart';
import 'package:news_app/View/LoginView.dart';
import 'package:news_app/View/NavigationBarView.dart';

import '../Model/User.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  bool isShowName = false;
  bool isShowEmail = false;
  bool isShowPass = false;
  bool isShowPhoneNum = false;
  bool isShowGender = false;
  bool isShowBirth = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController birth = TextEditingController();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  String nameError = '';
  String emailError = '';
  String passwordError = '';
  String phoneError = '';
  String birthError = '';

  Future<void> _signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
    UserRepository.user = Users(
        name: "",
        email: "",
        password: "",
        birth: DateTime.now(),
        phone: "",
        gender: true);
    UserRepository.saveUser(UserRepository.user);
    print('Đã đăng xuất');
  }

  bool _isValidEmail(String email) {
    // Biểu thức chính quy để kiểm tra định dạng email
    const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    final regex = RegExp(pattern);
    return regex.hasMatch(email);
  }

  bool _isValidPhone(String phone) {
    // Biểu thức chính quy để kiểm tra định dạng số điện thoại
    const pattern =
        r'^(0|\+84)(\s|\.)?((3[2-9])|(5[689])|(7[06-9])|(8[1-689])|(9[0-46-9]))(\d)(\s|\.)?(\d{3})(\s|\.)?(\d{3})$';
    final regex = RegExp(pattern);
    return regex.hasMatch(phone);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: const BottomNav(idx: 2),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              Row(
                children: [
                  Column(children: [
                    const CircleAvatar(
                      backgroundImage: AssetImage(""),
                      minRadius: 45,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Thay đổi ảnh",
                        style: TextStyle(color: Colors.blue),
                      ),
                    )
                  ]),
                  Column(
                    children: [
                      const Text(
                        "userName",
                        style: TextStyle(color: Colors.black),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          //
                          _signOut();
                          // Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginView()));
                        },
                        child: const Text(
                          "Đăng xuất",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const Text(
                "Thông tin tài khoản",
                textAlign: TextAlign.left,
              ),
              ListTile(
                trailing: IconButton(
                  onPressed: () {
                    setState(() {
                      isShowName = !isShowName;
                    });
                  },
                  icon: isShowName
                      ? const Icon(Icons.close)
                      : const Icon(Icons.edit),
                ),
                leading: const Text('Họ tên'),
              ),
              Visibility(
                visible: isShowName,
                replacement: TextField(
                    controller: name,
                    readOnly: true,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[400],
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(15)))),
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[200]),
                  child: Column(
                    children: [
                      const Text("Nhập họ tên"),
                      TextField(
                          controller: name,
                          decoration: InputDecoration(
                              errorText:
                                  nameError.isNotEmpty ? nameError : null,
                              filled: true,
                              fillColor: Colors.grey[350],
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(15)))),
                      ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            final accountName = name.text.trim();
                            if (accountName.isEmpty) {
                              nameError = 'Tên tài khoản không được bỏ trống';
                            } else if (accountName.length < 8) {
                              nameError = 'Tên tài khoản phải tối đa 8 kí tự';
                            } else {
                              nameError = '';
                              isShowName = !isShowName;
                            }
                          });
                        },
                        child: const Text("Lưu thay đổi"),
                      )
                    ],
                  ),
                ),
              ),
              ListTile(
                trailing: IconButton(
                  onPressed: () {
                    setState(() {
                      isShowEmail = !isShowEmail;
                    });
                  },
                  icon: isShowEmail
                      ? const Icon(Icons.close)
                      : const Icon(Icons.edit),
                ),
                leading: const Text('Email'),
              ),
              Visibility(
                visible: isShowEmail,
                replacement: TextField(
                    controller: email,
                    readOnly: true,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[400],
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(15)))),
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[200]),
                  child: Column(
                    children: [
                      const Text("Nhập Email"),
                      TextField(
                          controller: email,
                          decoration: InputDecoration(
                              errorText:
                                  emailError.isNotEmpty ? emailError : null,
                              filled: true,
                              fillColor: Colors.grey[350],
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(15)))),
                      ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              final accountEmail = email.text.trim();
                              if (accountEmail.isEmpty) {
                                emailError = 'Email không được bỏ trống';
                              } else if (!_isValidEmail(accountEmail)) {
                                emailError = 'Email không hợp lệ';
                              } else {
                                emailError = '';
                                isShowEmail = !isShowEmail;
                              }
                            });
                          },
                          child: const Text("Lưu thay đổi"))
                    ],
                  ),
                ),
              ),
              const ListTile(
                leading: Text('Mật khẩu'),
              ),
              TextField(
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isShowPass = !isShowPass;
                        });
                      },
                      icon: Icon(
                        isShowPass ? Icons.visibility : Icons.visibility_off,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.grey[400],
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(15))),
                obscureText: isShowPass,
                obscuringCharacter: '*',
                readOnly: true,
              ),
              const Text("Thông tin cá nhân"),
              ListTile(
                trailing: IconButton(
                  onPressed: () {
                    setState(() {
                      isShowPhoneNum = !isShowPhoneNum;
                    });
                  },
                  icon: isShowPhoneNum
                      ? const Icon(Icons.close)
                      : const Icon(Icons.edit),
                ),
                leading: const Text('Số điện thoại'),
              ),
              Visibility(
                visible: isShowPhoneNum,
                replacement: TextField(
                    controller: phone,
                    readOnly: true,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[400],
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(15)))),
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[200]),
                  child: Column(
                    children: [
                      const Text("Nhập số điện thoại"),
                      TextField(
                          controller: phone,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[350],
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(15)))),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            final accountPhone = phone.text.trim();
                            if (accountPhone.isEmpty) {
                              phoneError = 'Số điện thoại không được bỏ trống';
                            } else if (!_isValidPhone(accountPhone)) {
                              phoneError = 'Số điện thoại không hợp lệ';
                            } else {
                              phoneError = '';
                              isShowPhoneNum = !isShowPhoneNum;
                            }
                          });
                        },
                        child: const Text("Lưu thay đổi"),
                      )
                    ],
                  ),
                ),
              ),
              ListTile(
                trailing: IconButton(
                  onPressed: () {
                    setState(() {
                      isShowGender = !isShowGender;
                    });
                  },
                  icon: isShowGender
                      ? const Icon(Icons.close)
                      : const Icon(Icons.edit),
                ),
                leading: const Text('Giới tính'),
              ),
              Visibility(
                visible: isShowGender,
                replacement: TextField(
                    controller: gender,
                    readOnly: true,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[400],
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(15)))),
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[200]),
                  child: Column(
                    children: [
                      const Text("Nhập giới tính"),
                      TextField(
                          controller: gender,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[350],
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(15)))),
                      ElevatedButton(
                          onPressed: () {
                            setState(() {});
                          },
                          child: const Text("Lưu thay đổi"))
                    ],
                  ),
                ),
              ),
              ListTile(
                trailing: IconButton(
                  onPressed: () {
                    setState(() {
                      isShowBirth = !isShowBirth;
                    });
                  },
                  icon: isShowBirth
                      ? const Icon(Icons.close)
                      : const Icon(Icons.edit),
                ),
                leading: const Text('Ngày sinh'),
              ),
              Visibility(
                visible: isShowBirth,
                replacement: TextField(
                    controller: birth,
                    readOnly: true,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[400],
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(15)))),
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[200]),
                  child: Column(
                    children: [
                      const Text("Nhập ngày sinh"),
                      TextField(
                        controller: birth,
                        decoration: InputDecoration(
                            errorText:
                                birthError.isNotEmpty ? birthError : null,
                            filled: true,
                            fillColor: Colors.grey[350],
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(15))),
                        readOnly: true,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1950),
                              lastDate: DateTime(2100));
                          if (pickedDate != null) {
                            String formattedDate =
                                DateFormat('dd/MM/yyyy').format(pickedDate);
                            setState(() {
                              birth.text = formattedDate;
                            });
                          } else {}
                        },
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              final accountBirthday = birth.text.trim();
                              if (accountBirthday.isEmpty) {
                                birthError = 'Vui lòng chọn ngày sinh';
                              } else {
                                birthError = '';
                                isShowBirth = !isShowBirth;
                              }
                            });
                          },
                          child: const Text("Lưu thay đổi"))
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
