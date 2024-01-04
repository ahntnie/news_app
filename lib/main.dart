import 'package:flutter/material.dart';
import 'package:news_app/Model/User.dart';
import 'package:news_app/View/HomeView.dart';
import 'package:news_app/View/Screen/NewsScreen_Detail/NewsScreen_Detail.dart';
import 'package:news_app/View/StartView.dart';
import 'package:news_app/View/UserView.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowMaterialGrid: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const NewsDetail());
  }
}
