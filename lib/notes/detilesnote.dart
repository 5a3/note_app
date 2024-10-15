import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class detilesnote extends StatefulWidget {
  detilesnote({super.key, this.note});
  QueryDocumentSnapshot? note;

  @override
  State<detilesnote> createState() => _detilesnoteState();
}

class _detilesnoteState extends State<detilesnote> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text(widget.note!['title'])),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * .3,
                width: double.infinity,
                child: Image.network(
                  widget.note!['url'],
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: 20, bottom: 10, right: 20, left: 20),
                child: Row(
                  children: [
                    Icon(Icons.bookmark_add_outlined),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'الملاحظه',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                color: Colors.black12,
                thickness: 1.0,
                indent: 20.0,
                endIndent: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 20, bottom: 10, right: 20, left: 20),
                child: Text(
                  widget.note!['text'],
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 14.0,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
