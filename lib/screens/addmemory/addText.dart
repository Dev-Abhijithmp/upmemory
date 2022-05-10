import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:upmemory/screens/addmemory/textandImageProvider.dart';
import 'package:upmemory/themeColorIcons/theme.dart';

class AddText extends StatelessWidget {
  const AddText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _screensize = MediaQuery.of(context).size;
    var provider = Provider.of<TextAndImageProvider>(context);
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            height: _screensize.height * 0.3,
            child: TextField(
              controller: provider.textEditingController,
              maxLines: 20,
              decoration: InputDecoration(
                border: out(),
                disabledBorder: out(),
                focusedErrorBorder: out(),
                errorBorder: out(),
                enabledBorder: out(),
                focusedBorder: out(),
                hintText: 'Enter text',
              ),
            ),
          ),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith(
                    (states) => ColorsS.loginGradientEnd)),
            onPressed: () {
              provider.addText();
              provider.textEditingController.clear();
            },
            child: Text('save'),
          ),
          Expanded(
              child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Text(
                  provider.memoryText[index],
                  style: TextStyle(fontSize: 15),
                ),
              );
            },
            itemCount: provider.memoryText.length,
          ))
        ],
      ),
    );
  }
}

OutlineInputBorder out() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(
      color: Colors.black,
      width: 2,
    ),
  );
}
