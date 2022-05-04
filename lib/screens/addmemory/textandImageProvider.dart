import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class TextAndImageProvider extends ChangeNotifier {
  final ImagePicker _picker = ImagePicker();
  TextEditingController textEditingController = TextEditingController();
  List<File> images = [];
  List<String> memoryText = [];
  List<String> memoryVoicePath = [];

  List<String> getpaths() {
    getApplicationDocumentsDirectory().then((value) {
      value.list().listen((onData) {
        if (onData.path.contains('.aac')) memoryVoicePath.add(onData.path);
      }).onDone(() {
        memoryVoicePath = memoryVoicePath.reversed.toList();
        notifyListeners();
        print('memory voice path');
        print(memoryVoicePath);
      });
    });
    return memoryVoicePath;
  }

  Future<List<File>> getVoiceFiles() async {
    List<File> files = [];
    await getApplicationDocumentsDirectory().then((value) {
      value.list().listen((onData) {
        if (onData.path.contains('.aac')) memoryVoicePath.add(onData.path);
      }).onDone(() {
        memoryVoicePath = memoryVoicePath.reversed.toList();
        notifyListeners();
        print('memory voice path 000');
        print(memoryVoicePath);
      });
    });

    print('memory voice path 1');
    print(memoryVoicePath);
    for (var item in memoryVoicePath) {
      files.add(File(item));
    }

    print("getting voices from provider");
    print(files.length);
    return files;
  }

  bool loading = false;
  void changeLoading() {
    loading = !loading;
    notifyListeners();
  }

  Future<void> deleteall(List<String> memorypath) async {
    for (var item in memorypath) {
      var file = File(item);
      if (file.existsSync()) {
        file.delete();
      }
    }
    memoryVoicePath.clear();
  }

  Future<Map<String, String>> pickImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    try {
      if (pickedFile != null) {
        final file = XFile(pickedFile.path);
        images.add(File(file.path));
        notifyListeners();
      }
      notifyListeners();
      return {'success': 'Success'};
    } catch (e) {
      return {'error': e.toString()};
    }
  }

  Future<Map<String, String>> pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    try {
      if (pickedFile != null) {
        final file = XFile(pickedFile.path);
        images.add(File(file.path));
        notifyListeners();
      }
      notifyListeners();
      return {'success': 'Success'};
    } catch (e) {
      return {'error': e.toString()};
    }
  }

  Future<Map<String, String>> addText() async {
    try {
      memoryText.add(textEditingController.text);
      notifyListeners();

      notifyListeners();
      return {'success': 'Success'};
    } catch (e) {
      return {'error': e.toString()};
    }
  }
}
