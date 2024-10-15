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

class EditNote extends StatefulWidget {
  EditNote({super.key, this.note, this.idcatname});
  static String id = 'EditNote';
  QueryDocumentSnapshot? note;
  var idcatname;

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  File? file;
  var url;
  getimage() async {
    ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      file = File(image.path);
      var imagename = path.basename(image.path);
      var refstorge = FirebaseStorage.instance.ref(imagename);
      await refstorge.putFile(file!);
      url = await refstorge.getDownloadURL();
      setState(() {});
    } else {
      return;
    }
  }

  @override
  void initState() {
    super.initState();
    title.text = widget.note!['title'];
    des.text = widget.note!['text'];
  }

  GlobalKey<FormState> formkey = new GlobalKey<FormState>();
  TextEditingController title = new TextEditingController();
  TextEditingController des = new TextEditingController();

  Future<dynamic> EditNote() async {
    if (formkey.currentState!.validate()) {
      try {
        showDialog(
          context: context,
          builder: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
        CollectionReference note = FirebaseFirestore.instance
            .collection('Categories')
            .doc(widget.idcatname)
            .collection('notes');
        Map<String, dynamic> body = {
          'url': url ??
              '${'https://toppng.com/uploads/preview/colored-sticky-note-png-11552182116p9e7shymq0.png'}',
          'title': '${title.text}',
          'text': '${des.text}',
          'email': '${FirebaseAuth.instance.currentUser!.email}',
          'timestamp': FieldValue.serverTimestamp(),
          'userid': FirebaseAuth.instance.currentUser!.uid,
        };

        var res =
            await note.doc(widget.note!.id).set(body, SetOptions(merge: true));
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green,
            content: Text(' تم تعديل الملاحظه ${title.text} بنجاح')));
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
        title: Text('تعديل ملاحظه'),
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
                      labelText: 'أدخل عنوان الملاحظه',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: TextFormField(
                    controller: des,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'الحقل مطلوب';
                      } else
                        return null;
                    },
                    decoration: InputDecoration(
                        labelText: 'أدخل الملاحظه',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15))),
                  ),
                ),
                MaterialButton(
                    color: Colors.blueAccent,
                    child: Text(
                      'تغيير الصورة',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      getimage();
                    }),
                MaterialButton(
                    color: Colors.blueAccent,
                    child: Text(
                      'تعديل',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      EditNote();
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
                      'يمكنك تعديل  صورة الملاحظه',
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
