import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:miniproject/app_screen/Filters/Nature.dart';
import 'package:miniproject/app_screen/Login.dart';
import 'package:miniproject/app_screen/birthday.dart';
import 'package:miniproject/app_screen/changepassword.dart';
import 'package:miniproject/app_screen/cur_nav_bar.dart';
import 'package:miniproject/app_screen/cur_nav_bar_traveller.dart';
import 'package:miniproject/app_screen/home.dart';
import 'package:miniproject/app_screen/mainSearch.dart';
import 'package:miniproject/app_screen/search.dart';
import 'package:miniproject/app_screen/interface.dart';
import 'package:miniproject/app_screen/signup.dart';
import 'package:miniproject/app_screen/recover.dart';
import 'package:miniproject/app_screen/guideprofile.dart';
import 'package:miniproject/app_screen/guideprofile2.dart';
import 'package:miniproject/app_screen/guideprofile3.dart';
import 'package:miniproject/app_screen/dispalyprofile.dart';
import 'package:miniproject/app_screen/messageview.dart';
import 'package:miniproject/app_screen/filters.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:miniproject/app_screen/birthday.dart';
import 'package:miniproject/app_screen/passion.dart';
import 'package:miniproject/map_screen/Guide/getmap_guide.dart';
import 'package:miniproject/map_screen/first_screen.dart';
import 'package:miniproject/map_screen/map_traveller.dart';
import 'package:miniproject/messages/TravellermsgUI.dart';
import 'package:miniproject/messages/message.dart';
import 'package:miniproject/post_upload/img_upload.dart';
import 'package:miniproject/post_upload/post_home.dart';
import 'package:miniproject/app_screen/spalshpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'map_screen/Traveller/getmap.dart';




void main(){
  runApp(
   MyApp() 
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{
String currentUserId;
SharedPreferences prefs;

 FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
 final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

      //FirebaseUser firebaseUser = (await firebaseAuth.signInWithCredential(credential)).user;

      /*getStringValuesSF() async {
      prefs = await SharedPreferences.getInstance();
     currentUserId = prefs.getString('id')?? '';
     print('Id:$currentUserId');
      }*/

 
  @override
 void initState() { 
   super.initState();

   registerNotification();
   _saveDevicetoken();
 //  getStringValuesSF();
   
 }
void registerNotification() {
    firebaseMessaging.requestNotificationPermissions();

    firebaseMessaging.configure(onMessage: (Map<String, dynamic> message) {

      print('onMessage: $message');
      return ;
     /* Platform.isAndroid
          ? showNotification(message['notification'])
          : showNotification(message['aps']['alert']);
      return;*/
    }, onResume: (Map<String, dynamic> message) {
      print('onResume: $message');
      return;
    }, onLaunch: (Map<String, dynamic> message) {
      print('onLaunch: $message');
      return;
    });}

_saveDevicetoken() async{
FirebaseUser user=await FirebaseAuth.instance.currentUser();
var email;
if(user!=null){
email=user.email;
print(email);
}

//String uid='charu@gmail.com';
String fcmtoken= await firebaseMessaging.getToken();

print(fcmtoken);

print("hellooo");
if(fcmtoken!=null){
var tokenref=Firestore.instance.collection('profiledata').document(email).collection('token').document(fcmtoken);

var setData = tokenref.setData({'Token':fcmtoken,'createdAt':FieldValue.serverTimestamp()});
await setData;

}



}

 /*   firebaseMessaging.getToken().then((token)  async {

      print('token: $token');
      FirebaseUser user=await FirebaseAuth.instance.currentUser();
var email;
if(user!=null){
currentUserId=user.uid;
print(email);
}


     
        Firestore.instance
          .collection('Traveller')
          .document(currentUserId)
          .updateData({'pushToken': token});
          
    }
    
    ).catchError((err) {
      Fluttertoast.showToast(msg: err.message.toString());
    });
*/

  

  
 



   /*void showNotification(message) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      Platform.isAndroid
          ? 'com.dfa.flutterchatdemo'
          : 'com.duytq.flutterchatdemo',
      'Flutter chat demo',
      'your channel description',
      playSound: true,
      enableVibration: true,
      importance: Importance.Max,
      priority: Priority.High,
    );
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    print(message);
//    print(message['body'].toString());
//    print(json.encode(message));

    await flutterLocalNotificationsPlugin.show(0, message['title'].toString(),
        message['body'].toString(), platformChannelSpecifics,
        payload: json.encode(message));

//    await flutterLocalNotificationsPlugin.show(
//        0, 'plain title', 'plain body', platformChannelSpecifics,
//        payload: 'item x');
  }*/


  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.brown
      ),
      home:Searchbox(),
      debugShowCheckedModeBanner: false,
    )
    ;
  }

}