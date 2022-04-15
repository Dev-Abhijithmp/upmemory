import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:upmemory/color/colors.dart';
import 'package:upmemory/screens/widgets.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 221, 238, 0),
        title: Text(
          "Upmemory",
          style: TextStyle(color: foregroundColor),
        ),
        actions: [
          Text(
            "17/02/2022",
            style: TextStyle(color: foregroundColor),
          )
        ],
      ),
      drawerScrimColor: Colors.yellow,
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MemoryItem(),
          MemoryItem(),
        ],
      ),
    );
  }
}
