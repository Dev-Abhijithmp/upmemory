import 'package:flutter/material.dart';
import 'package:upmemory/authentication/authenticate.dart';
import 'package:upmemory/themeColorIcons/theme.dart';

Drawer drawer() => Drawer(
      child: ListView(
        children: [
          SizedBox(
            height: 70,
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
      width: 200,
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
