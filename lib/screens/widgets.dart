import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:upmemory/color/colors.dart';

class MemoryItem extends StatelessWidget {
  const MemoryItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      width: _screenSize.width * 0.95,
      height: _screenSize.height * 0.2,
      child: Neumorphic(
        style: NeumorphicStyle(
          shape: NeumorphicShape.flat,
          color: Color.fromRGBO(255, 221, 238, 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("14/04/2022")],
        ),
      ),
    );
  }
}
