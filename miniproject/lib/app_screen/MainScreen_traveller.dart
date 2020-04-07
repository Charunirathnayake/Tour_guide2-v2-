import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:miniproject/app_screen/Login_traveller.dart';
import 'package:miniproject/app_screen/cur_nav_bar_traveller.dart';
import 'package:miniproject/app_screen/home.dart';

class MainScreen_traveller extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
  
    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (context,AsyncSnapshot<FirebaseUser> snapshot){
        if(snapshot.connectionState==ConnectionState.waiting)
        return Home() ;
        if(!snapshot.hasData||snapshot.data==null)
        return LoginInterface_traveller();
      return BottomNavBar_traveller();
      }
    );
  }

}
