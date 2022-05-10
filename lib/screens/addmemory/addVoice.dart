import 'package:flutter/material.dart';

class AddVoice extends StatelessWidget {
  const AddVoice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).size.width,
          ),
          ElevatedButton(onPressed: () {}, child: Text("Add to buffer")),
        ],
      ),
    );
  }
}

// Widget _playButtom(context) {
//   return Container(
//     width: MediaQuery.of(context).size.width * 0.1,
//     height: MediaQuery.of(context).size.width * 0.1,
//     child: Icon(Icons.play_arrow),
//     decoration: BoxDecoration(
//       shape: BoxShape.circle,
//       color: Colors.white,
//       border: Border.all(width: 2, color: Colors.black),
//     ),
//   );
// }

// Widget _pauseButton(context) {
//   return Container(
//     width: MediaQuery.of(context).size.width * 0.1,
//     height: MediaQuery.of(context).size.width * 0.1,
//     child: Icon(Icons.pause),
//     decoration: BoxDecoration(
//       shape: BoxShape.circle,
//       color: Colors.white,
//       border: Border.all(width: 2, color: Colors.black),
//     ),
//   );
// }

// Widget _recordButton(context) {
//   return Container(
//     width: MediaQuery.of(context).size.width * 0.1,
//     height: MediaQuery.of(context).size.width * 0.1,
//     child: Icon(Icons.start),
//     decoration: BoxDecoration(
//       shape: BoxShape.circle,
//       color: Colors.white,
//       border: Border.all(width: 2, color: Colors.black),
//     ),
//   );
// }

// Widget _stopButton(context) {
//   return Container(
//     width: MediaQuery.of(context).size.width * 0.1,
//     height: MediaQuery.of(context).size.width * 0.1,
//     child: Icon(Icons.start),
//     decoration: BoxDecoration(
//       shape: BoxShape.circle,
//       color: Colors.white,
//       border: Border.all(width: 2, color: Colors.black),
//     ),
//   );
// }
