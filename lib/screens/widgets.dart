import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/route_manager.dart';
import 'package:upmemory/screens/viewMemory.dart';
import 'package:upmemory/themeColorIcons/theme.dart';

//this is single home page ui item

class MemoryItem extends StatelessWidget {
  const MemoryItem({Key? key}) : super(key: key);

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
                  "14/04/2022",
                  style: TextStyle(
                    color: ColorsS.loginGradientEnd,
                  ),
                ),
                _singleImageItem(),
                _singleNotesItem(),
                _singleAudioItem(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                NeumorphicButton(
                  child: Text("Update"),
                ),
                NeumorphicButton(
                  child: Text("Remove"),
                ),
                NeumorphicButton(
                  onPressed: () => Navigator.push(
                      context, MaterialPageRoute(builder: (_) => ViewMemory())),
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

Widget _singleImageItem() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Icon(Icons.image),
      Text("5"),
    ],
  );
}

Widget _singleAudioItem() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Icon(Icons.audio_file),
      Text("6"),
    ],
  );
}

Widget _singleNotesItem() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Icon(Icons.text_fields),
      Text("4"),
    ],
  );
}

AlertDialog alertDialog(BuildContext context) {
  return AlertDialog(
    content: Container(
      height: 200,
      child: Column(
        children: [
          Text("you added 5 images"),
          Text(" added 7 voices"),
          Text("Added 2 notes"),
        ],
      ),
    ),
    actions: [
      ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("cancel")),
      ElevatedButton(
        onPressed: () {},
        child: Text("upload"),
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
