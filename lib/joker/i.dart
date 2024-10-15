import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class aaaaa extends StatefulWidget {
  aaaaa({super.key, this.object});
  var object;

  @override
  State<aaaaa> createState() => _aaaaaState();
}

class _aaaaaState extends State<aaaaa> {
  Stream<QuerySnapshot> GetNotes(String textsearch) {
    if (textsearch == '') {
      var note = FirebaseFirestore.instance
          .collection('Categories')
          .doc(widget.object)
          .collection('notes')
          .orderBy('timestamp', descending: true);
      var data = note.snapshots();
      return data;
    } else {
      var note = FirebaseFirestore.instance
          .collection('Categories')
          .doc(widget.object)
          .collection('notes')
          .orderBy('timestamp', descending: true)
          .where('title', isEqualTo: '${textsearch}');
      var data = note.snapshots();
      return data;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
      stream: GetNotes(''),
      builder: (context, snapshot) {
        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (BuildContext context, int i) {
            var move = snapshot.data!.docs[i];
            return Container(
                height: 150,
                width: 170,
                decoration: BoxDecoration(
                    border: Border.all(color: Color.fromARGB(255, 58, 58, 58)),
                    color: Color.fromARGB(255, 0, 0, 0),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Expanded(
                      flex: 8,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(9),
                            topRight: Radius.circular(9),
                            bottomRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10)),
                        child: Image.asset(
                          width: 170,
                          '${move['url']}',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 3,
                        child: Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                '${move['title']}',
                                style: TextStyle(color: Colors.white),
                              ),
                            )))
                  ],
                ));
          },
        );
      },
    ));
  }
}
