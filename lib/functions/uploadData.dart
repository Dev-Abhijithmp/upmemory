import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:upmemory/screens/addmemory/textandImageProvider.dart';

Future<Map<String, String>> uploadMemory(
    String uid,
    String docid,
    List<String> text,
    List<File> images,
    List<File> voice,
    BuildContext context) async {
  Provider.of<TextAndImageProvider>(context, listen: false).changeLoading();
  try {
    Map<String, List<String>> data = await addimagetostorage(images, uid);
    Map<String, List<String>> vdata = await addVoicetostorage(voice, uid);
    List<String>? voiceurls = vdata['status'];

    List<String>? imageurls = data['status'];
    await FirebaseFirestore.instance
        .collection('memories')
        .doc('memories')
        .collection(uid)
        .doc(formatDate(DateTime.now(), [dd, '-', mm, '-', yyyy]).toString())
        .set({
      'memoryText': text,
      'memoryVoice': voiceurls,
      'memoryImages': imageurls,
      'memoryDate': Timestamp.now(),
      'isUpdated': false,
    });
    Provider.of<TextAndImageProvider>(context, listen: false).changeLoading();
    Provider.of<TextAndImageProvider>(context, listen: false)
        .textEditingController
        .clear();
    return {'status': 'success'};
  } catch (e) {
    return {'status': e.toString()};
  }
}

FirebaseStorage firebaseStorage = FirebaseStorage.instance;
Future<Map<String, List<String>>> addVoicetostorage(
    List<File> voice, String uid) async {
  try {
    List<String> url = [];
    for (var i = 0; i < voice.length; i++) {
      await FirebaseStorage.instance
          .ref('voices/$uid' + i.toString() + '.aac')
          .putFile(voice[i]);
      String sample = await FirebaseStorage.instance
          .ref('voices/$uid' + i.toString() + '.aac')
          .getDownloadURL();
      url.add(sample);
    }
    print(url);
    return {'status': url};
  } on FirebaseException catch (e) {
    print(e.message);
    return {
      'status': [e.message.toString()]
    };
  }
}

Future<Map<String, List<String>>> addimagetostorage(
    List<File> images, String id) async {
  try {
    List<String> url = [];
    for (var i = 0; i < images.length; i++) {
      await FirebaseStorage.instance
          .ref('images/$id' + i.toString() + '.jpeg')
          .putFile(images[i]);
      String sample = await FirebaseStorage.instance
          .ref('images/$id' + i.toString() + '.jpeg')
          .getDownloadURL();
      url.add(sample);
    }
    return {'status': url};
  } on FirebaseException catch (e) {
    return {
      'status': [e.message.toString()]
    };
  }
}
