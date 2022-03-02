import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RowContainer extends StatelessWidget {
  const RowContainer({Key? key, required this.name, required this.value})
      : super(key: key);
  final String name;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: Container(
      child: Column(
        children: [Text("${name}"), Text("${value}")],
      ),
      // constraints: BoxConstraints(minHeight: 100, minWidth: 300, maxWidth: 150),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(5.0), boxShadow: [
        BoxShadow(
          color: Colors.white60,
          offset: Offset(0.1, 0.1), //(x,y)
          blurRadius: 1,
        )
      ]),
      margin: EdgeInsets.fromLTRB(0, 10, 40, 10),
      width: 120,
    ));
  }
}
