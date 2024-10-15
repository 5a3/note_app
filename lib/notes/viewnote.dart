import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Auth/login.dart';
import 'package:flutter_app/Categories/Add.dart';
import 'package:flutter_app/notes/addnote.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../componets/carditem.dart';
import '../componets/customlisttile.dart';

class viewnote extends StatefulWidget {
  QueryDocumentSnapshot? note;
  viewnote({
    super.key,
    this.note,
  });
  static String id = 'viewnote';

  @override
  State<viewnote> createState() => _viewnoteState();
}

class _viewnoteState extends State<viewnote> {
  final searchcontroller = TextEditingController();

  Stream<QuerySnapshot> GetNotes(String textsearch) {
    if (textsearch == '') {
      var note = FirebaseFirestore.instance
          .collection('Categories')
          .doc(widget.note!.id)
          .collection('notes')
          .orderBy('timestamp', descending: true);
      var data = note.snapshots();
      return data;
    } else {
      var note = FirebaseFirestore.instance
          .collection('Categories')
          .doc(widget.note!.id)
          .collection('notes')
          .orderBy('timestamp', descending: true)
          .where('title', isEqualTo: '${textsearch}');
      var data = note.snapshots();
      return data;
    }
  }

  QueryDocumentSnapshot? noteflotion;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddNote(noteid: widget.note!.id),
                  ));
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
          title: Text('${widget.note!['name']}'),
        ),
        body: Column(mainAxisSize: MainAxisSize.min, children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onChanged: (value) {
                  setState(() {});
                  searchcontroller.text = value;
                },
                textDirection: TextDirection.rtl,
                decoration: InputDecoration(
                    suffixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الحقل مطلوب';
                  }
                },
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: StreamBuilder<QuerySnapshot>(
              stream: GetNotes(searchcontroller.text),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('خطا: ${snapshot.error}'));
                }
                //var note = snapshot.data!.docs;

                if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int i) {
                      var note = snapshot.data!.docs;

                      return customlisttile(
                        id: widget.note!.id,
                        // note: note[i],
                        num: int.tryParse('${i}'),
                      );
                    },
                  );
                  // return card_item(
                  //     data: note[i], id: note[i].id, name: note[i]['title']);
                }

                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ]));
  }
}
