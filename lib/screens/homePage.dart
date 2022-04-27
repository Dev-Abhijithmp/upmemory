import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:upmemory/screens/addmemory/addMemNavbar.dart';
import 'package:upmemory/screens/drawer.dart';
import 'package:upmemory/screens/widgets.dart';
import 'package:upmemory/themeColorIcons/colors.dart';
import 'package:upmemory/themeColorIcons/theme.dart';

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
      drawer: drawer(),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MemoryItem(),
          MemoryItem(),
        ],
      ),
      floatingActionButton: NeumorphicFloatingActionButton(
        style: NeumorphicStyle(color: endClr),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => MemNavBar(buttonText: "upload")));
        },
        child: Center(
            child: Text(
          "new",
          style: TextStyle(color: Colors.white),
        )),
      ),
    );
  }
}
