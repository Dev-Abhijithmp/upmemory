import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:upmemory/screens/addmemory/recoredview.dart';
import 'package:upmemory/screens/addmemory/textandImageProvider.dart';
import 'package:upmemory/screens/addmemory/voicerecord/recoredlist.dart';

class RecorderHomeView extends StatefulWidget {
  const RecorderHomeView({
    Key? key,
  }) : super(key: key);

  @override
  _RecorderHomeViewState createState() => _RecorderHomeViewState();
}

class _RecorderHomeViewState extends State<RecorderHomeView> {
  late Directory appDirectory;
  List<String> records = [];

  @override
  void initState() {
    super.initState();
    getApplicationDocumentsDirectory().then((value) {
      appDirectory = value;
      // appDirectory.list().listen((onData) {
      //   if (onData.path.contains('.aac')) records.add(onData.path);
      // }).onDone(() {
      //   records = records.reversed.toList();
      //   setState(() {});
      // });
      setState(() {});
    });
  }

  @override
  void dispose() {
    appDirectory.delete();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: RecordListView(
              records: records,
            ),
          ),
          Expanded(
            flex: 1,
            child: RecorderView(
              onSaved: _onRecordComplete,
            ),
          ),
        ],
      ),
    );
  }

  _onRecordComplete() {
    records.clear();
    appDirectory.list().listen((onData) {
      if (onData.path.contains('.aac')) {
        Provider.of<TextAndImageProvider>(context, listen: false)
            .memoryVoicePath
            .add(onData.path);
        records.add(onData.path);
      }
      ;
    }).onDone(() {
      records.sort();
      records = records.reversed.toList();
      setState(() {});
    });
  }
}
