import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:upmemory/screens/addmemory/textandImageProvider.dart';

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
                    (states) => Colors.blue.shade600)),
            onPressed: () {
              provider.addText();
              provider.textEditingController.clear();
            },
            child: Text('Add to buffer'),
          ),
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
