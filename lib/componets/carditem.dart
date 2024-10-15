import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Categories/edit.dart';
import 'package:flutter_app/admin/all.dart';
import '../notes/viewnote.dart';
import '../home/item.dart';

class card_item extends StatelessWidget {
  card_item({
    required this.name,
    this.id,
    super.key,
    this.data,
  });
  String name;
  dynamic id;
  var data;
  var numb;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onLongPress: () {
      //   showDialog(
      //     context: context,
      //     builder: (context) {
      //       return AlertDialog(
      //         icon: Align(
      //             alignment: Alignment.topLeft,
      //             child: Icon(
      //               Icons.warning,
      //               color: Color.fromARGB(255, 245, 29, 13),
      //             )),
      //         content: Text(
      //           "هل تريد حذف قسم ${name}",
      //           style: TextStyle(fontWeight: FontWeight.bold),
      //         ),
      //         actions: [
      //           TextButton(
      //             onPressed: () async {
      //               try {
      //                 showDialog(
      //                   context: context,
      //                   builder: (context) => Center(
      //                     child: CircularProgressIndicator(),
      //                   ),
      //                 );
      //                 await FirebaseFirestore.instance
      //                     .collection('Categories')
      //                     .doc(id)
      //                     .delete();
      //                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //                     backgroundColor: Colors.red,
      //                     content: Text('تم حذف قسم ${name}')));

      //                 Navigator.pop(context);
      //                 Navigator.pop(context);
      //               } catch (e) {
      //                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //                     backgroundColor: Colors.red,
      //                     content: Text('هناك خطاء ماء ${e}')));
      //               }
      //             },
      //             child: Text('حذف'),
      //           ),
      //           TextButton(
      //             onPressed: () {
      //               // updateItem(item);
      //               Navigator.pop(context);
      //             },
      //             child: Text('الغاء'),
      //           ),
      //         ],
      //       );
      //     },
      //   );
      // },
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => all(
            namecategory: name,
          ),
        ));
      },
      child: Card(
        child: Container(
            // color: Colors.grey,
            child: Column(
          children: [
            Container(
              child: Expanded(
                flex: 8,
                child: Image.asset(
                  'assets/images/F1.jpg',
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Text(
                '${name}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.5),
              ),
            ),
            // Expanded(
            //     flex: 5,
            //     child: IconButton(
            //       onPressed: () {
            //         Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //               builder: (context) => EditCategory(
            //                 cat: data,
            //               ),
            //             ));
            //       },
            //       icon: Icon(
            //         Icons.edit,
            //         color: Colors.green,
            //         size: 17,
            //       ),
            //     ))
          ],
        )),
      ),
    );
  }
}
