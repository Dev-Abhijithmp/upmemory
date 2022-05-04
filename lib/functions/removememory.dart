import 'package:cloud_firestore/cloud_firestore.dart';

//it's  function for deleteing firebase document when user trigger remove buttton ande check the time is expired
//if not it will delete document
Future<Map<String, String>> removememory(String uid, String docid) async {
  try {
    DateTime _datetime = DateTime.now();
    DocumentSnapshot<Map<String, dynamic>> data = await FirebaseFirestore
        .instance
        .collection('memories')
        .doc('memories')
        .collection(uid)
        .doc(docid)
        .get();
    var _docdate = data['memoryDate'] as Timestamp;
    var _docdate2 = _docdate.toDate();

    var difference = _datetime.difference(_docdate2);
    print("difference: $difference");
    if (difference > Duration(days: 1)) {
      return {'status': "can't delete after 24 hours"};
    } else {
      await FirebaseFirestore.instance
          .collection('memories')
          .doc('memories')
          .collection(uid)
          .doc(docid)
          .delete();
      print('removed memory');
      return {'status': 'success'};
    }
  } on FirebaseException catch (e) {
    return {'status': e.message.toString()};
  }
}
