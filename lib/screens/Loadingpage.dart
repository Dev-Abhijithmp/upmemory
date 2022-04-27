import 'package:flutter/material.dart';
import 'package:upmemory/themeColorIcons/theme.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CircularProgressIndicator(
        color: ColorsS.loginGradientEnd,
      ),
    );
  }
}
