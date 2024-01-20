import 'dart:ffi';
import 'dart:io';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:flutter/widgets.dart';
import 'package:news_app/Model/Users.dart';
import 'package:news_app/Presenter/UserPresenter.dart';
import 'package:news_app/Repository/UserRepository.dart';
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
  String genderError = '';
  String phoneError = '';
  String birthError = '';

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
    UserRepository.user = null;
    print('Đã đăng xuất');
  }

  

  void updateUser() {
    
  }

  // Bỏ kiểm tra Email

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
                leading: const Text(
                    'Email'), // Email sửa lại chỉ cho xem không cho sửa nè
              ),
              TextField(
                  controller: email,
                  readOnly: true,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[400],
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(
                              15)))), // BỎ HẾT ĐỂ LẠI CÁI TEXTFIELD NÀY THÔI
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
                              errorText: phoneError.isNotEmpty
                                  ? phoneError
                                  : null, // bổ sung cái này bữa thiếu từ đây nè
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
                          // Sửa chỗ giới tính này thành Dialog nè
                          onTap: () async {
                            await showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    child: Container(
                                      width: double.infinity,
                                      height: 150,
                                      child: Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Column(
                                          children: [
                                            RadioListTile(
                                              title: Text("Nam"),
                                              value: false,
                                              groupValue: gender,
                                              onChanged: (value) {
                                                setState(() {
                                                  gender.text = "Nam";

                                                  Navigator.pop(context);
                                                });
                                              },
                                            ),
                                            RadioListTile(
                                              title: Text("Nữ"),
                                              value: true,
                                              groupValue: gender,
                                              onChanged: (value) {
                                                setState(() {
                                                  gender.text = "Nữ";
                                                  Navigator.pop(context);
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                });
                          },
                          controller: gender,
                          readOnly: true,
                          decoration: InputDecoration(
                              errorText:
                                  genderError.isNotEmpty ? genderError : null,
                              filled: true,
                              fillColor: Colors.grey[350],
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(15)))),
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              final accountGender = gender.text.trim();
                              if (accountGender.isEmpty) {
                                genderError = 'Vui lòng chọn giới tính';
                              } else {
                                genderError = '';
                                isShowGender = !isShowGender;
                              }
                            }); // Tới đây nhaaaaaaaaaaaaaaaaaaa
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
