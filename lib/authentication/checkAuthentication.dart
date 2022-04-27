import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:upmemory/screens/loginPage.dart';
import 'package:upmemory/screens/homePage.dart';

class CheckAuthentication extends StatelessWidget {
  const CheckAuthentication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.userChanges(),
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.data?.uid != null) {
          return Homepage();
        } else {
          return LoginPage();
        }
      },
    );
  }
}
