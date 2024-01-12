import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/widgets.dart';
import 'package:news_app/View/NavigationBarView.dart';

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

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController birth = TextEditingController();

  String nameError = '';
  String emailError = '';
  String passwordError = '';
  String phoneError = '';
  String birthError = '';

   bool _isValidEmail(String email) {
    // Biểu thức chính quy để kiểm tra định dạng email
    const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    final regex = RegExp(pattern);
    return regex.hasMatch(email);
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
                      const Text("Nguyễn Văn A"),
                      ElevatedButton(
                        onPressed: () {},
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
                          setState(() {});
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
                            setState(() {});
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
                        onPressed: () {},
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
                          onPressed: () {}, child: const Text("Lưu thay đổi"))
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
                          errorText: birthError.isNotEmpty?birthError:null,
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
