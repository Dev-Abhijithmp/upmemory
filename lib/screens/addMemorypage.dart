import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:upmemory/color/colors.dart';

class AddMemory extends StatelessWidget {
  const AddMemory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.elliptical(150, 7),
              bottomRight: Radius.elliptical(150, 7)),
        ),
        backgroundColor: Colors.blue,
        title: Text(
          "Upmemory",
          style: TextStyle(color: foregroundColor),
        ),
        actions: [],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              addimage(_screenSize.width),
              addtext(_screenSize.width),
              addVoice(_screenSize.width),
            ],
          ),
          addButton(_screenSize.width),
        ],
      ),
    );
  }
}

Widget addVoice(double size) {
  return Neumorphic(
    style: NeumorphicStyle(
      shadowDarkColor: Colors.black,
      color: Colors.blue,
      shape: NeumorphicShape.flat,
      boxShape: NeumorphicBoxShape.circle(),
    ),
    child: Container(
      width: size * 0.20,
      height: size * 0.20,
      child: Center(
        child: Text("voice"),
      ),
    ),
  );
}

Widget addimage(double size) {
  return Neumorphic(
    style: NeumorphicStyle(
      shadowDarkColor: Colors.black,
      color: Colors.blue,
      shape: NeumorphicShape.flat,
      boxShape: NeumorphicBoxShape.circle(),
    ),
    child: Container(
      width: size * 0.20,
      height: size * 0.20,
      child: Center(
        child: Text("image"),
      ),
    ),
  );
}

Widget addtext(double size) {
  return Neumorphic(
    style: NeumorphicStyle(
      shadowDarkColor: Colors.black,
      color: Colors.blue,
      shape: NeumorphicShape.flat,
      boxShape: NeumorphicBoxShape.circle(),
    ),
    child: Container(
      width: size * 0.20,
      height: size * 0.20,
      child: Center(
        child: Text("text"),
      ),
    ),
  );
}

Widget recordButton(double size) {
  return Center(
    child: Neumorphic(
      style: NeumorphicStyle(
        shadowDarkColor: Colors.blue,
        color: Colors.black,
        shape: NeumorphicShape.flat,
        boxShape: NeumorphicBoxShape.circle(),
      ),
      child: Container(
        width: size,
        height: size,
        child: Center(
          child: Icon(
            Icons.audiotrack,
            color: Colors.white,
          ),
        ),
      ),
    ),
  );
}

Widget addButton(double size) {
  return InkWell(
    child: Container(
      width: size * 0.75,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Center(
        child: Text("Upload"),
      ),
    ),
  );
}
