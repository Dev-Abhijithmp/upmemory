import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:upmemory/functions/removememory.dart';
import 'package:upmemory/functions/uploadData.dart';
import 'package:upmemory/screens/addmemory/addMemNavbar.dart';
import 'package:upmemory/screens/addmemory/textandImageProvider.dart';
import 'package:upmemory/screens/viewMemory.dart';
import 'package:upmemory/themeColorIcons/theme.dart';

//this is single home page ui item
class MemoryItem extends StatelessWidget {
  final DocumentSnapshot? doc;
  const MemoryItem({Key? key, required this.doc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      width: _screenSize.width * 0.90,
      height: _screenSize.height * 0.15,
      child: Neumorphic(
        padding: EdgeInsets.all(15),
        curve: Neumorphic.DEFAULT_CURVE,
        style: NeumorphicStyle(
          border: NeumorphicBorder(
            color: ColorsS.loginGradientEnd,
          ),
          shape: NeumorphicShape.flat,
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  doc!.id,
                  style: TextStyle(
                    color: ColorsS.loginGradientEnd,
                  ),
                ),
                _singleImageItem(
                    imageCount: doc?.get('memoryImages')?.length ?? 0),
                _singleNotesItem(
                    notesCount: doc?.get('memoryText')?.length ?? 0),
                _singleAudioItem(
                    voicecount: doc?.get('memoryVoice')?.length ?? 0),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                NeumorphicButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => MemNavBar(
                                buttonText: "update",
                                images: doc?.get('memoryImages'),
                                audios: doc?.get('memoryVoice'),
                                memorytext: doc?.get('memoryText'))));
                  },
                  child: Text("Update"),
                ),
                NeumorphicButton(
                  onPressed: () async {
                    Map<String, String?> flag = await removememory(
                        FirebaseAuth.instance.currentUser!.uid, doc!.id);
                    if (flag['status'] != 'success') {
                      errorAlert(
                          error: flag['status']!,
                          title: "Error",
                          context: context);
                    }
                  },
                  child: Text("Remove"),
                ),
                NeumorphicButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ViewMemory(
                                doc: doc!,
                              ))),
                  child: Text("View"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

Widget _singleImageItem({required int imageCount}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Icon(Icons.image),
      Text(imageCount.toString()),
    ],
  );
}

Widget _singleAudioItem({required int voicecount}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Icon(Icons.audio_file),
      Text(voicecount.toString()),
    ],
  );
}

Widget _singleNotesItem({required int notesCount}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Icon(Icons.text_fields),
      Text(notesCount.toString()),
    ],
  );
}

AlertDialog alertDialog(BuildContext context, List<File> image,
    List<File> voice, List<String> text) {
  return AlertDialog(
    content: Container(
      height: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(" Added ${image.length} images"),
          Text(" Added ${voice.length} voices"),
          Text("Added ${text.length} notes"),
          Text("do you want upload this memory"),
        ],
      ),
    ),
    actions: [
      ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("cancel")),
      Consumer<TextAndImageProvider>(
        builder: (context, value, child) {
          return ElevatedButton(
            onPressed: () async {
              value.changeLoading();
              await uploadMemory(
                  FirebaseAuth.instance.currentUser!.uid,
                  formatDate(DateTime.now(), [dd, '-', mm, '-', yyyy]),
                  text,
                  image,
                  voice,
                  context);
            },
            child: Text("upload"),
          );
        },
      )
    ],
  );
}

void errorAlert(
    {required String error,
    required String title,
    required BuildContext context}) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(error.toLowerCase()),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("cancel")),
          ],
        );
      });
}
