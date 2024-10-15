import 'package:flutter/material.dart';
import 'package:flutter_app/Auth/login.dart';
import 'package:flutter_app/Auth/signup.dart';

class Authpage extends StatefulWidget {
  const Authpage({super.key});

  @override
  State<Authpage> createState() => _AuthpageState();
}

class _AuthpageState extends State<Authpage> {
  bool showloginpage = true;
  @override
  Widget build(BuildContext context) {
    if (showloginpage) {
      return Login();
    } else {
      return SignUp();
    }
  }
}
