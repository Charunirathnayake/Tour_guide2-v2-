import 'package:flutter/material.dart';

class Splash extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Container(
        child: SafeArea(child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(
                backgroundColor: Color(0xffBA680B),
              ),
              SizedBox(height: 10.0,),
              Text("Loading",style:TextStyle(
                color:Color(0xffBA680B),fontWeight:FontWeight.w400,
                fontSize:18.0
              ))
            ],
          ),
        )
        ),
      ),
       );
  }

}