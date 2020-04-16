import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'msgUI.dart';

class Messanging extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
  
    return Messanging_State();
  }

}
 class Messanging_State extends State<Messanging>{

  /* final FirebaseMessaging _firebaseMessaging=FirebaseMessaging();
@override
   final List<Message>messages=[];
void initState(){
  super.initState();
  _firebaseMessaging.configure(
    onMessage: (Map <String,dynamic>message) async {
      print("onMessage:$message");

      final notification=message['notification'];
      setState(() {
        messages.add(Message(body: notification['body'], title: notification['title']));
      });
    },
onLaunch: (Map <String,dynamic>message) async {
      print("onLaunch:$message");
    },
    onResume: (Map <String,dynamic>message) async {
      print("onResume:$message");
    }

  );
}*/

  @override
  Widget build(BuildContext context) {
    
    return Container(
      width: 200,
      height: 200,
      color: Colors.black,
    );
    /*
    ListView(
      children:messages.map(buildMessage).toList()
    );
  }

  Widget buildMessage(Message message){
    return ListTile(
      title: Text(message.title),
      subtitle: Text(message.body),
    );*/
    
  
  }

 }