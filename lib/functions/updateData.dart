import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:upmemory/screens/addmemory/textandImageProvider.dart';

Future<Map<String, String>> updatememory(
    {required List<dynamic> imageurls,
    required List<dynamic> voiceurls,
    required List<dynamic> textdata,
    required int imageindex,
    required int voiceindex,
    required String uid,
    required String docid,
    required List<String> text,
    required List<File> images,
    required List<File> voice,
    required BuildContext context}) async {
  Provider.of<TextAndImageProvider>(context, listen: false).changeLoading();
  try {
    Map<String, List<String>> data = await addimagetostorage(
        id: uid, images: images, imageindex: imageindex);
    Map<String, List<String>> vdata =
        await addVoicetostorage(voiceindex: voiceindex, uid: uid, voice: voice);
    List<String>? voiceurlss = List<String>.from(voiceurls);
    List<String>? textdatas = List<String>.from(textdata);

    List<String>? imageurlss = List<String>.from(imageurls);
    await FirebaseFirestore.instance
        .collection('memories')
        .doc('memories')
        .collection(uid)
        .doc(formatDate(DateTime.now(), [dd, '-', mm, '-', yyyy]).toString())
        .update({
      'memoryText': textdatas + text,
      'memoryVoice': voiceurlss + vdata['status']!,
      'memoryImages': imageurlss + data['status']!,
      'memoryDateupdated': Timestamp.now(),
      'isUpdated':true,
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
    {required List<File> voice,
    required String uid,
    int voiceindex = 0}) async {
  try {
    List<String> url = [];
    for (var i = voiceindex; i < voice.length; i++) {
      await FirebaseStorage.instance
          .ref('voices/$uid' + i.toString() + '.aac')
          .putFile(voice[i]);
      String sample = await FirebaseStorage.instance
          .ref('voices/$uid' + i.toString() + '.aac')
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

Future<Map<String, List<String>>> addimagetostorage(
    {required List<File> images,
    required String id,
    int imageindex = 0}) async {
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
