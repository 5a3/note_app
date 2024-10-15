import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_app/componets/custombutton.dart';
import 'package:flutter_app/componets/customtextformfiled.dart';

class EditCategory extends StatefulWidget {
  EditCategory({super.key, this.cat});
  static String id = 'EditCategory';
  QueryDocumentSnapshot? cat;

  @override
  State<EditCategory> createState() => _EditCategoryState();
}

class _EditCategoryState extends State<EditCategory> {
  @override
  void initState() {
    super.initState();
    Categore_Name.text = widget.cat!['name'];
  }

  GlobalKey<FormState> formkey = new GlobalKey<FormState>();
  TextEditingController Categore_Name = new TextEditingController();
  CollectionReference Categories =
      FirebaseFirestore.instance.collection('Categories');
  Future<dynamic> EditCategory() async {
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

        var res = await Categories.doc(widget.cat!.id)
            .set(body, SetOptions(merge: true));
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green,
            content: Text(' تم تعديل قسم ${Categore_Name.text} بنجاح')));
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
        title: Text('تعديل ${widget.cat!['name']}'),
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
                      'تعديل',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      EditCategory();
                    })
              ],
            )),
      ),
    );
  }
}
