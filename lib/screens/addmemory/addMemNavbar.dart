import 'package:flutter/material.dart';
import 'package:upmemory/screens/addmemory/addImage.dart';
import 'package:upmemory/screens/addmemory/addText.dart';
import 'package:upmemory/screens/addmemory/addVoice.dart';
import 'package:upmemory/screens/widgets.dart';
import 'package:upmemory/themeColorIcons/colors.dart';
import 'package:upmemory/themeColorIcons/iconss.dart';
import 'package:upmemory/themeColorIcons/theme.dart';

class MemNavBar extends StatefulWidget {
  final String buttonText;
  MemNavBar({Key? key, required this.buttonText}) : super(key: key);

  @override
  State<MemNavBar> createState() => _MemNavBarState();
}

class _MemNavBarState extends State<MemNavBar> {
  List<Widget> pages = [AddText(), AddVoice(), AddImage()];
  int _selectedIndex = 0;
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
      body: pages[_selectedIndex],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
            indicatorColor: ColorsS.loginGradientEnd.withOpacity(0.8)),
        child: NavigationBar(
          backgroundColor: Colors.white,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          height: 60,
          selectedIndex: _selectedIndex,
          onDestinationSelected: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          destinations: [
            NavigationDestination(
                // selectedIcon: Icon(
                //   MyFlutterApp.doc_text_1,
                //   color: ColorsS.loginGradientEnd,
                // ),
                icon: Icon(MyFlutterApp.doc_text_1),
                label: "Text"),
            NavigationDestination(
                // selectedIcon: Icon(
                //   MyFlutterApp.keyboard_voice,
                //   color: ColorsS.loginGradientEnd,
                // ),
                icon: Icon(MyFlutterApp.keyboard_voice),
                label: "Voice"),
            NavigationDestination(
              // selectedIcon: Icon(
              //   MyFlutterApp.images,
              //   color: ColorsS.loginGradientEnd,
              // ),
              icon: Icon(MyFlutterApp.images),
              label: "image",
            )
          ],
        ),
      ),
      floatingActionButton: InkWell(
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return alertDialog(context);
              });
        },
        child: Container(
          height: 40,
          width: 110,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: ColorsS.loginGradientStart.withOpacity(.1),
                  offset: Offset(3, 4))
            ],
            color: ColorsS.loginGradientStart,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              widget.buttonText,
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
