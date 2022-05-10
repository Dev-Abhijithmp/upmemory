import 'dart:io';

import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:upmemory/functions/updateData.dart';
import 'package:upmemory/functions/uploadData.dart';
import 'package:upmemory/screens/addmemory/addImage.dart';
import 'package:upmemory/screens/addmemory/addText.dart';
import 'package:upmemory/screens/addmemory/textandImageProvider.dart';
import 'package:upmemory/screens/addmemory/voicerecord/recorderhome.dart';
import 'package:upmemory/screens/widgets.dart';
import 'package:upmemory/themeColorIcons/colors.dart';
import 'package:upmemory/themeColorIcons/iconss.dart';
import 'package:upmemory/themeColorIcons/theme.dart';

class MemNavBar extends StatefulWidget {
  final List<dynamic> memorytext;
  final List<dynamic> images;
  final List<dynamic> audios;
  final String buttonText;
  MemNavBar(
      {Key? key,
      required this.buttonText,
      required this.memorytext,
      required this.images,
      required this.audios})
      : super(key: key);

  @override
  State<MemNavBar> createState() => _MemNavBarState();
}

class _MemNavBarState extends State<MemNavBar> {
  List<Widget> pages = [AddText(), RecorderHomeView(), AddImage()];
  int _selectedIndex = 0;
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TextAndImageProvider(),
      builder: (BuildContext context, w) {
        var provider = Provider.of<TextAndImageProvider>(context);
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
                    icon: Stack(children: [
                      Icon(
                        MyFlutterApp.doc_text_1,
                        size: 25,
                      ),
                      Positioned(
                        width: 20,
                        height: 20,
                        child: Consumer<TextAndImageProvider>(
                          builder: (context, value, child) => Text(
                            "${value.memoryText.length}",
                            style: TextStyle(color: ColorsS.loginGradientStart),
                          ),
                        ),
                        top: -2,
                        right: -5,
                      ),
                    ]),
                    label: "Text"),
                NavigationDestination(
                    // selectedIcon: Icon(
                    //   MyFlutterApp.keyboard_voice,
                    //   color: ColorsS.loginGradientEnd,
                    // ),
                    icon: Stack(
                      children: [
                        Icon(
                          MyFlutterApp.keyboard_voice,
                          size: 25,
                        ),
                        Positioned(
                          width: 20,
                          height: 20,
                          child: Consumer<TextAndImageProvider>(
                            builder: (context, value, child) => Text(
                              "${value.memoryVoicePath.length}",
                              style:
                                  TextStyle(color: ColorsS.loginGradientStart),
                            ),
                          ),
                          top: -2,
                          right: -5,
                        ),
                      ],
                    ),
                    label: "Voice"),
                NavigationDestination(
                  // selectedIcon: Icon(
                  //   MyFlutterApp.images,
                  //   color: ColorsS.loginGradientEnd,
                  // ),
                  icon: Stack(
                    children: [
                      Icon(
                        MyFlutterApp.images,
                        size: 25,
                      ),
                      Positioned(
                        width: 20,
                        height: 20,
                        child: Consumer<TextAndImageProvider>(
                          builder: (context, value, child) => Text(
                            "${value.images.length}",
                            style: TextStyle(color: ColorsS.loginGradientStart),
                          ),
                        ),
                        top: -2,
                        right: -5,
                      ),
                    ],
                  ),
                  label: "image",
                )
              ],
            ),
          ),
          floatingActionButton: _isLoading == false
              ? InkWell(
                  onTap: () async {
                    setState(() {
                      _isLoading = true;
                    });
                    List<File> file = await provider.getVoiceFiles();
                    Map<String, String> flag;
                    if (widget.buttonText == 'upload') {
                      flag = await uploadMemory(
                          FirebaseAuth.instance.currentUser!.uid,
                          formatDate(DateTime.now(), [dd, '-', mm, '-', yyyy]),
                          provider.memoryText,
                          provider.images,
                          file,
                          context);
                    } else {
                      List<File> file = await provider.getVoiceFiles();

                      flag = await updatememory(
                          imageurls: widget.images,
                          voiceurls: widget.audios,
                          textdata: widget.memorytext,
                          imageindex: widget.images.length,
                          voiceindex: widget.audios.length,
                          uid: FirebaseAuth.instance.currentUser!.uid,
                          docid: formatDate(
                              DateTime.now(), [dd, '-', mm, '-', yyyy]),
                          text: provider.memoryText,
                          images: provider.images,
                          voice: file,
                          context: context);
                    }
                    setState(() {
                      _isLoading = false;
                    });

                    if (flag['status'] == "success") {
                      Provider.of<TextAndImageProvider>(context, listen: false)
                          .deleteall(provider.getpaths());
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(flag['status'].toString()),
                      ));
                    }
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
                )
              : CircularProgressIndicator(color: ColorsS.loginGradientEnd),
        );
      },
    );
  }
}
