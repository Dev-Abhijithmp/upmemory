import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;

Future<Map<String, String?>> signinemail(String email, String password) async {
  try {
    await auth.signInWithEmailAndPassword(email: email, password: password);
    return {"status": "success"};
  } on FirebaseAuthException catch (e) {
    print(e.toString());

    return {"status": e.message};
  }
}

//function for logout
void signout() async {
  auth.signOut();
  print("Signed out");
}

//to register a new user
Future<Map<String, String?>> register(
    {required String email,
    required String password,
    required String name}) async {
  try {
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email, password: password);

    createuserprofile(uid: userCredential.user!.uid, name: name, email: email);
    return {"status": "success"};
  } on FirebaseAuthException catch (e) {
    print(e.toString());
    return {"status": e.message};
  }
}

//resetting password
Future<Map<String, String?>> sendpassreset(String email) async {
  try {
    await auth.sendPasswordResetEmail(email: email);
    return {"status": "success"};
  } on FirebaseException catch (e) {
    print(e.toString());
    return {"status": e.message};
  }
}

//tochange password
void changepass(String email, String oldpass, String newpass) async {
  try {
    await auth.signInWithEmailAndPassword(email: email, password: oldpass);
    await auth.currentUser!.updatePassword(newpass);
  } on FirebaseException catch (e) {
    print(e.message);
  }
}

Future<void> createuserprofile({
  required String name,
  required String uid,
  required String email,
}) async {
  FirebaseFirestore.instance.collection('user').doc(uid).set({
    'id': uid,
    'name': name,
    'email': email,
  });
}
