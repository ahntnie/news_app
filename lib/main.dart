import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:news_app/Model/User.dart';
import 'package:news_app/View/CategoryNewView.dart';
import 'package:news_app/View/DrawerView.dart';
import 'package:news_app/View/HomeView.dart';
import 'package:news_app/View/StartView.dart';
// import 'package:news_app/View/UserView.dart';
// import 'package:news_app/forgetpassword.dart';
// import 'package:news_app/loginscreen.dart';
// import 'package:news_app/signupscreen.dart';

// import 'View/CategoryView.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const StartView());
  }
}
