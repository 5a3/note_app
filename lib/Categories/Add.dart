import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_app/componets/custombutton.dart';
import 'package:flutter_app/componets/customtextformfiled.dart';
import 'package:image_picker/image_picker.dart';

class AddCategory extends StatefulWidget {
  AddCategory({super.key});
  static String id = 'AddCategory';

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  GlobalKey<FormState> formkey = new GlobalKey<FormState>();
  TextEditingController Categore_Name = new TextEditingController();
  CollectionReference Categories =
      FirebaseFirestore.instance.collection('Categories');
  Future<dynamic> AddCategory() async {
    if (formkey.currentState!.validate()) {
      try {
        showDialog(
          context: context,
          builder: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
        Map<String, dynamic> body = {
          'name': '${Categore_Name.text}',
          'email': '${FirebaseAuth.instance.currentUser!.email}',
          'timestamp': FieldValue.serverTimestamp(),
          'userid': FirebaseAuth.instance.currentUser!.uid,
        };

        var res = await Categories.add(body);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green,
            content: Text(' بنجاح ${Categore_Name.text}تم إضافة قسم ')));
        Navigator.pop(context);
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text('حصل خطاء ماء الرجاء اعادة المحاولة ${e}')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('إضافة قسم'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
            key: formkey,
            child: Column(
              children: [
                TextFormField(
                  controller: Categore_Name,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'الحقل مطلوب';
                    } else
                      return null;
                  },
                  decoration: InputDecoration(
                      labelText: 'أدخل أسم القسم',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
                ),
                MaterialButton(
                    color: Colors.blueAccent,
                    child: Text(
                      'إضافة',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      AddCategory();
                    }),
              ],
            )),
      ),
    );
  }
}
