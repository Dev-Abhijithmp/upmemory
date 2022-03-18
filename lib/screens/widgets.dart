import 'package:flutter/material.dart';
import 'package:upmemory/color/colors.dart';

Widget Voiceitem(context) {
  return Row(
    children: [
      Container(
        height: 30,
        margin: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        child: Container(),
      ),
      IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.delete,
            color: deleteiconcolor,
          ))
    ],
  );
}
