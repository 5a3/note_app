import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Auth/authpage.dart';
import 'package:flutter_app/Auth/login.dart';
import 'package:flutter_app/home/homepage.dart';

class MianPage extends StatelessWidget {
  const MianPage({super.key});

  @override
  Widget build(BuildContext context) {
    // print(FirebaseAuth.instance.currentUser!.emailVerified);
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData &&
            FirebaseAuth.instance.currentUser!.emailVerified) {
          return HomePage();
        } else {
          return Login();
        }
      },
    );
  }
}
