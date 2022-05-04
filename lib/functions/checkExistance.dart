import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';

Future<bool> isDocexist(String uid) async {
  var doc = await FirebaseFirestore.instance
      .collection("memories")
      .doc('memories')
      .collection(uid)
      .doc(formatDate(DateTime.now(), [dd, '-', mm, '-', yyyy]).toString())
      .get();

  print(
      "formated date: ${formatDate(DateTime.now(), [dd, '-', mm, '-', yyyy])}");
  if (doc.exists) {
    return true;
  } else {
    return false;
  }
}
