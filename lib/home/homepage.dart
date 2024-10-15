import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Auth/login.dart';
import 'package:flutter_app/Categories/Add.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../componets/carditem.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static String id = 'HomePage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<QueryDocumentSnapshot> list = [];
  Stream<QuerySnapshot> GetCategories() {
    CollectionReference Categories =
        FirebaseFirestore.instance.collection('Categories');

    var data = Categories.where('userid',
            isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();

    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddCategory.id);
            }),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {
                  GoogleSignIn googleSignIn = GoogleSignIn();
                  googleSignIn.disconnect();
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(Login.id, (route) => false);
                },
                icon: Icon(Icons.logout))
          ],
          title: Text('الصفحة الرئيسة'),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: GetCategories(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('خطا: ${snapshot.error}'));
            }

            if (snapshot.hasData) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int i) {
                  var cat = snapshot.data!.docs;

                  return card_item(
                      data: cat[i], id: cat[i].id, name: cat[i]['name']);
                },
              );
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}
