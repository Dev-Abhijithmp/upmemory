import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:upmemory/authentication/checkAuthentication.dart';
import 'package:upmemory/screens/Loadingpage.dart';
import 'package:upmemory/screens/SplashScreen.dart';
import 'package:upmemory/screens/addmemory/textandImageProvider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ChangeNotifierProvider(
          create: (_) => TextAndImageProvider(),
          builder: (BuildContext context, w) {
            return FutureBuilder(
              future: initialize(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasError == true) {
                  return LoadingPage();
                } else if (snapshot.hasData) {
                  return CheckAuthentication();
                } else {
                  return SplashScreen();
                }
              },
            );
          },
        ));
  }
}

Future<bool> initialize() async {
  await Future.delayed(Duration(seconds: 4));
  await Firebase.initializeApp();
  return true;
}
