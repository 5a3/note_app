import 'package:flutter/material.dart';

class custombutton extends StatelessWidget {
  custombutton({
    required this.title,
    this.myfunc,
    super.key,
  });
  String? title;
  Function? myfunc;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: MaterialButton(
          minWidth: 200,
          height: 45,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          child: Text(
            '${title}',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w600, fontSize: 23),
          ),
          color: Colors.blueAccent,
          onPressed: () {
            myfunc;
          }),
    );
  }
}
