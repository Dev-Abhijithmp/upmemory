import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:upmemory/authentication/authenticate.dart';
import 'package:upmemory/functions/checkExistance.dart';
import 'package:upmemory/screens/Loadingpage.dart';
import 'package:upmemory/screens/addmemory/addMemNavbar.dart';
import 'package:upmemory/screens/widgets.dart';
import 'package:upmemory/themeColorIcons/colors.dart';
import 'package:upmemory/themeColorIcons/theme.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("user id: ${FirebaseAuth.instance.currentUser!.uid}");

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: ColorsS.primaryGradient,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.elliptical(150, 7),
              bottomRight: Radius.elliptical(150, 7)),
        ),
        title: Text(
          "Memories",
          style: TextStyle(color: foregroundColor),
        ),
        actions: [
          TextButton.icon(
              onPressed: () {
                signout();
              },
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              label: Text(
                "logout",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      // drawer: drawer(),
      backgroundColor: Colors.white,
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("memories")
              .doc('memories')
              .collection(FirebaseAuth.instance.currentUser!.uid.toString())
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              List<DocumentSnapshot>? docs = snapshot.data?.docs;
              return ListView.builder(
                itemCount: docs?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  return MemoryItem(
                    doc: docs![index],
                  );
                },
              );
            } else {
              return LoadingPage();
            }
          }),
      floatingActionButton: NeumorphicFloatingActionButton(
        style: NeumorphicStyle(color: endClr),
        onPressed: () async {
          if (await isDocexist(FirebaseAuth.instance.currentUser!.uid) ==
              true) {
            errorAlert(
                error:
                    "You Cant create new memory today the file already exist!. remove memory to add new memory or update memory",
                title: "error!",
                context: context);
          } else {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => MemNavBar(
                        buttonText: 'upload',
                        memorytext: [],
                        images: [],
                        audios: [])));
          }
        },
        child: Center(
            child: Text(
          "new",
          style: TextStyle(color: Colors.white),
        )),
      ),
    );
  }
}
