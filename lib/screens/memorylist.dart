import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:upmemory/color/colors.dart';
import 'package:upmemory/color/theme.dart';
import 'package:upmemory/screens/widgets.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: ColorsS.primaryGradient,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.elliptical(150, 7),
              bottomRight: Radius.elliptical(150, 7)),
        ),
        title: Text(
          "Memories",
          style: TextStyle(color: foregroundColor),
        ),
        actions: [],
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
