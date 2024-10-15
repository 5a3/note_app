import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_app/Auth/mainpage.dart';
import 'package:flutter_app/Auth/signup.dart';
import 'package:flutter_app/Categories/Add.dart';
import 'package:flutter_app/Categories/edit.dart';
import 'package:flutter_app/home/homepage.dart';
import 'package:flutter_app/home/item.dart';
import 'package:flutter_app/joker/homepage.dart';
import 'package:flutter_app/notes/viewnote.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'Auth/login.dart';
import 'admin/Categories.dart';
import 'firebase_options.dart';
import 'Auth/signup.dart';
import 'joker/i.dart';
// import '../notes/viewnote.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            buttonTheme: ButtonThemeData(buttonColor: Colors.blueAccent),
            textTheme:
                TextTheme(bodyLarge: TextStyle(fontWeight: FontWeight.bold)),
            appBarTheme: AppBarTheme(
                titleTextStyle:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                centerTitle: true,
                backgroundColor: Colors.blueAccent)),
        debugShowCheckedModeBanner: false,
        routes: {
          // SignUp.id: (context) => SignUp(),
          Login.id: (context) => Login(),
          SignUp.id: (context) => SignUp(),
          HomePage.id: (context) => HomePage(),
          AddCategory.id: (context) => AddCategory(),
          item.id: (context) => item(),
          EditCategory.id: (context) => EditCategory(),
          viewnote.id: (context) => viewnote(),
        },
        home: HomePage());
  }
}
