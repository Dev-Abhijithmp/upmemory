import 'package:flutter/material.dart';
import 'package:upmemory/color/colors.dart';
import 'package:upmemory/screens/widgets.dart';
class Homepage extends StatelessWidget {
  const Homepage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        backgroundColor:BackgroundColor,
        foregroundColor: foregroundColor,
        title: Text("Upmemory",style: TextStyle(color:foregroundColor),),
        actions: [
          Text("17/02/2022",style: TextStyle(color: foregroundColor),)
        ],
        
      ),
      drawerScrimColor: Colors.yellow,
      
      drawer: Drawer(
        
      ),
      
      backgroundColor:BackgroundColor,
      body: Column(
        children:  [
          Voiceitem(context),
          
        ],
      ),
    );
  }
}
