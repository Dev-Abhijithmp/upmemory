import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class RecordListView extends StatefulWidget {
  final List<dynamic> records;
  final bool isNetwork;
  const RecordListView({
    Key? key,
    required this.records,
    required this.isNetwork,
  }) : super(key: key);

  @override
  _RecordListViewState createState() => _RecordListViewState();
}

class _RecordListViewState extends State<RecordListView> {
  late int _totalDuration;
  late int _currentDuration;
  double _completedPercentage = 0.0;
  bool _isPlaying = false;
  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return widget.records.isEmpty
        ? Center(child: Text('No records yet'))
        : ListView.builder(
            itemCount: widget.records.length,
            shrinkWrap: true,
            reverse: true,
            itemBuilder: (BuildContext context, int i) {
              return ExpansionTile(
                title: Text('New recoding ${widget.records.length - i}'),
                subtitle: widget.isNetwork
                    ? Text('')
                    : Text(_getDateFromFilePatah(
                        filePath: widget.records.elementAt(i))),
                onExpansionChanged: ((newState) {
                  if (newState) {
                    setState(() {
                      _selectedIndex = i;
                    });
                  }
                }),
                children: [
                  Container(
                    height: 100,
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LinearProgressIndicator(
                          minHeight: 5,
                          backgroundColor: Colors.black,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.green),
                          value: _selectedIndex == i ? _completedPercentage : 0,
                        ),
                        widget.isNetwork == false
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(
                                    icon: _selectedIndex == i
                                        ? _isPlaying
                                            ? Icon(Icons.pause)
                                            : Icon(Icons.play_arrow)
                                        : Icon(Icons.play_arrow),
                                    onPressed: () => _onPlay(
                                        filePath: widget.records
                                            .elementAt(i)
                                            .toString(),
                                        index: i,
                                        isNetwork: widget.isNetwork),
                                  ),
                                  IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: () {
                                        delete(widget.records[i].toString());
                                      }),
                                ],
                              )
                            : IconButton(
                                icon: _selectedIndex == i
                                    ? _isPlaying
                                        ? Icon(Icons.pause)
                                        : Icon(Icons.play_arrow)
                                    : Icon(Icons.play_arrow),
                                onPressed: () => _onPlay(
                                    filePath:
                                        widget.records.elementAt(i).toString(),
                                    index: i,
                                    isNetwork: widget.isNetwork),
                              ),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
  }

  Future<void> _onPlay(
      {required String filePath,
      required int index,
      required bool isNetwork}) async {
    AudioPlayer audioPlayer = AudioPlayer();

    if (!_isPlaying) {
      if (isNetwork) {
        audioPlayer.play(filePath, isLocal: false);
      } else {
        audioPlayer.play(filePath, isLocal: true);
      }

      setState(() {
        _selectedIndex = index;
        _completedPercentage = 0.0;
        _isPlaying = true;
      });

      audioPlayer.onPlayerCompletion.listen((_) {
        setState(() {
          _isPlaying = false;
          _completedPercentage = 0.0;
        });
      });
      audioPlayer.onDurationChanged.listen((duration) {
        setState(() {
          _totalDuration = duration.inMicroseconds;
        });
      });

      audioPlayer.onAudioPositionChanged.listen((duration) {
        setState(() {
          _currentDuration = duration.inMicroseconds;
          _completedPercentage =
              _currentDuration.toDouble() / _totalDuration.toDouble();
        });
      });
    }
  }

  Future<void> delete(String path) async {
    File file = File(path);
    await file.delete();
    widget.records.remove(path);
    setState(() {});
  }

  String _getDateFromFilePatah({required String filePath}) {
    String fromEpoch = filePath.substring(
        filePath.lastIndexOf('/') + 1, filePath.lastIndexOf('.'));

    DateTime recordedDate =
        DateTime.fromMillisecondsSinceEpoch(int.parse(fromEpoch));
    int year = recordedDate.year;
    int month = recordedDate.month;
    int day = recordedDate.day;

    return ('$day-$month-$year');
  }
}
