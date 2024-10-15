import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants/constant.dart';
import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:flutter_app/joker/i.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  Stream<QuerySnapshot> GetCategories() {
    CollectionReference Categories =
        FirebaseFirestore.instance.collection('Categories');

    var data = Categories.orderBy('timestamp', descending: true).snapshots();

    return data;
  }

  var textst = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w500,
    color: Color.fromARGB(255, 226, 226, 226),
  );
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      drawer: Drawer(),
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('جوك'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: StreamBuilder(
            stream: GetCategories(),
            builder: (context, snapshot) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "الاحدث",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 226, 226, 226),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                      width: w,
                      height: h / 4,
                      child: AnotherCarousel(
                        dotSize: 4.0,
                        dotSpacing: 15.0,
                        dotColor: Color.fromARGB(255, 195, 0, 23),
                        indicatorBgPadding: 5.0,
                        dotBgColor:
                            Color.fromARGB(255, 195, 0, 23).withOpacity(0.5),
                        borderRadius: true,
                        images: [
                          NetworkImage(
                              'https://cdn-images-1.medium.com/max/2000/1*GqdzzfB_BHorv7V2NV7Jgg.jpeg'),
                          NetworkImage(
                              'https://cdn-images-1.medium.com/max/2000/1*wnIEgP1gNMrK5gZU7QS0-A.jpeg'),
                          ExactAssetImage("assets/images/google.png")
                        ],
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          "أفلام",
                          style: textst,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: h / 5 + 10,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, i) {
                        var obj = snapshot.data!.docs[i];
                        return Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: aaaaa(
                              object: obj,
                            ));
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          "مسلسلات",
                          style: textst,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: h / 5 + 10,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, i) {
                        QueryDocumentSnapshot obj = snapshot.data!.docs[i];
                        return Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: aaaaa(
                              object: obj,
                            ));
                      },
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
