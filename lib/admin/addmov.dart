import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class addmov extends StatefulWidget {
  addmov({super.key, this.name});
  var name;

  @override
  State<addmov> createState() => _addmovState();
}

class _addmovState extends State<addmov> {
  File? file;
  var refstorge;
  var url;

  getimage() async {
    ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      file = File(image.path);
      var imagename = path.basename(image.path);
      refstorge = FirebaseStorage.instance.ref(imagename);

      setState(() {});
    } else {
      return;
    }
  }

  GlobalKey<FormState> formkey = new GlobalKey<FormState>();
  TextEditingController title = new TextEditingController();

  Future<dynamic> addmove() async {
    if (formkey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) => Center(
          child: CircularProgressIndicator(),
        ),
      );

      // print('${widget.note!.id}');

      CollectionReference move =
          FirebaseFirestore.instance.collection('${widget.name}');
      if (file != null) {
        await refstorge.putFile(file!);
        url = await refstorge.getDownloadURL();
      } else {
        url =
            'https://toppng.com/uploads/preview/colored-sticky-note-png-11552182116p9e7shymq0.png';
      }

      Map<String, dynamic> body = {
        'url': url,
        'title': '${title.text}',
        // 'text': '${des.text}',
        // 'email': '${FirebaseAuth.instance.currentUser!.email}',
        'timestamp': FieldValue.serverTimestamp(),
        // 'userid': FirebaseAuth.instance.currentUser!.uid,
      };

      try {
        await move.add(body);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green,
            content: Text(' بنجاح ${title.text} تم إضافة الفلم  ')));
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
        title: Text('إضافة فلم'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
            key: formkey,
            child: Column(
              children: [
                TextFormField(
                  controller: title,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'الحقل مطلوب';
                    } else
                      return null;
                  },
                  decoration: InputDecoration(
                      labelText: 'أدخل اسم أو رقم الفلم',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
                ),
                MaterialButton(
                    color: Colors.blueAccent,
                    child: Text(
                      'إضافة صورة',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      getimage();
                    }),
                MaterialButton(
                    color: Colors.blueAccent,
                    child: Text(
                      'حفظ',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      addmove();
                    }),
                if (file != null)
                  Container(
                    height: 200,
                    width: 200,
                    child: Image.file(file!),
                  )
                else
                  Container(
                    child: Text(
                      'يمكنك ارفاق صورة للفلم',
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  )
              ],
            )),
      ),
    );
  }
}
