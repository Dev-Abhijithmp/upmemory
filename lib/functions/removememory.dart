import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//it's  function for deleteing firebase document when user trigger remove buttton ande check the time is expired
//if not it will delete document
Future<Map<String, String>> removememory(String uid, String docid) async {
  try {
    DateTime _datetime = DateTime.now();
    DocumentSnapshot<Map<String, dynamic>> data = await FirebaseFirestore
        .instance
        .collection('memories')
        .doc(uid)
        .collection('memories')
        .doc(docid)
        .get();
    DateTime _docdate = data['date'];
    var difference = _datetime.difference(_docdate);
    if (difference > Duration(days: 1)) {
      return {'status': "can't delete after 24 hours"};
    } else {
      await FirebaseFirestore.instance
          .collection('memories')
          .doc(uid)
          .collection('memories')
          .doc(docid)
          .delete();
      return {'status': 'success'};
    }
  } on FirebaseException catch (e) {
    return {'status': e.message.toString()};
  }
}
