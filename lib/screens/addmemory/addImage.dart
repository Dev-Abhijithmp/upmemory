import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:upmemory/screens/addmemory/textandImageProvider.dart';

class AddImage extends StatelessWidget {
  const AddImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _screensize = MediaQuery.of(context).size;

    var provider = Provider.of<TextAndImageProvider>(context);
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: _screensize.height * 0.4,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.black,
                width: 2,
              ),
            ),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(10),
                  child: Image.file(
                    provider.images[index],
                    fit: BoxFit.fill,
                  ),
                );
              },
              itemCount: provider.images.length,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () async {
                    await provider.pickImageFromCamera();
                  },
                  child: Text('Camera')),
              ElevatedButton(
                  onPressed: () async {
                    await provider.pickImageFromGallery();
                  },
                  child: Text('Gallery')),
            ],
          ),
        ],
      ),
    );
  }
}
