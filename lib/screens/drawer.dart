import 'package:flutter/material.dart';
import 'package:upmemory/authentication/authenticate.dart';
import 'package:upmemory/themeColorIcons/theme.dart';

Drawer drawer() => Drawer(
      child: ListView(
        children: [
          profile(),
          SizedBox(
            height: 40,
          ),
          changePassword(),
          SizedBox(
            height: 20,
          ),
          signoutButton(),
        ],
      ),
    );
Widget signoutButton() {
  return InkWell(
    onTap: () {
      signout();
    },
    child: Container(
      margin: EdgeInsets.all(10),
      height: 40,
      decoration: BoxDecoration(
        color: ColorsS.loginGradientEnd,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: Text("Sign out"),
      ),
    ),
  );
}

Widget changePassword() {
  return InkWell(
    onTap: () {},
    child: Container(
      margin: EdgeInsets.all(10),
      height: 40,
      decoration: BoxDecoration(
        color: ColorsS.loginGradientEnd,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: Text("Change password"),
      ),
    ),
  );
}

Widget profile() {
  return Column(
    children: [
      SizedBox(
        height: 20,
      ),
      CircleAvatar(
        radius: 40,
      ),
      SizedBox(
        height: 10,
      ),
      Text("User Name"),
    ],
  );
}
