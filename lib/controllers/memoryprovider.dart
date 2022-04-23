import 'package:flutter/material.dart';
import 'package:upmemory/models/datacontrollers.dart';

class Memoryprovider extends ChangeNotifier {
  Memoryprovider(this.data) {}
  Future pausesound() async {}
  final List<Memorydata>? data;

  bool _recording = false;
  bool get recording => _recording;
  bool _isPlaying = false;
  bool get isPlaying => _isPlaying;
}
