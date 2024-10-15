import 'package:flutter/material.dart';

class customtextfiled extends StatelessWidget {
  customtextfiled({
    super.key,
    required this.contrillername,
    required this.type,
    required this.title,
    this.seure,
  });

  final TextEditingController? contrillername;
  var type;
  final String? title;
  bool? seure;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 1),
      child: TextFormField(
        // textAlign: TextAlign.center,
        controller: contrillername,
        keyboardType: type,
        decoration: InputDecoration(
            filled: true,
            fillColor: Color(0xfff1f1f1),
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(15)),
            labelText: '${title}',
            errorStyle: TextStyle(fontSize: 13)),
        validator: (value) {
          if (value!.isEmpty) {
            return 'يرجئ ادخال البيانات';
          }
          if (type == TextInputType.emailAddress) {
            final emailRegex =
                r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$';
            if (!RegExp(emailRegex).hasMatch(value)) {
              return "ادخل الايميل بشكل صحيح";
            }
          }

          return null;
        },
      ),
    );
  }
}
