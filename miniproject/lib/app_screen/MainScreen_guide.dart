import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:miniproject/app_screen/Login.dart';
import 'package:miniproject/app_screen/cur_nav_bar.dart';
import 'package:miniproject/app_screen/home.dart';

class MainScreen_Guide extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
  
    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (context,AsyncSnapshot<FirebaseUser> snapshot){
        if(snapshot.connectionState==ConnectionState.waiting)
        return Home() ;
        if(!snapshot.hasData||snapshot.data==null)
        return LoginInterface();
      return BottomNavBar();
      }
    );
  }

}
