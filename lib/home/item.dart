import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class item extends StatefulWidget {
  const item({super.key});
  static String id = 'item';

  @override
  State<item> createState() => _itemState();
}

class _itemState extends State<item> {
  @override
  Widget build(BuildContext context) {
    var item = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(title: Text('${item}')),
    );
  }
}
