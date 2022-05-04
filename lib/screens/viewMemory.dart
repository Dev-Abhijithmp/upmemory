import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:upmemory/themeColorIcons/colors.dart';

import '../themeColorIcons/theme.dart';

class ViewMemory extends StatefulWidget {
  final DocumentSnapshot doc;
  const ViewMemory({Key? key, required this.doc}) : super(key: key);

  @override
  State<ViewMemory> createState() => _ViewMemoryState();
}

class _ViewMemoryState extends State<ViewMemory> {
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
          "view memory",
          style: TextStyle(color: foregroundColor),
        ),
        actions: [],
      ),
      body: Column(
        children: [
          Expanded(child: ListView()),
          Expanded(child: ListView()),
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [],
            ),
          ),
        ],
      ),
    );
  }
}
