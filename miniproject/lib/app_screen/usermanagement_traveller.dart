
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserManagement{
  bool isLoggedIn() {
    if (FirebaseAuth.instance.currentUser() != null) {
      
      return true;
    } else {
      return false;
    }
  }


  Future<void> addData(TravellerData) async{
    SharedPreferences prefs;
    String currentUserId;

prefs = await SharedPreferences.getInstance();
     currentUserId = prefs.getString('id')?? '';
     print('Id:$currentUserId');
      

    //FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
        FirebaseUser user=await FirebaseAuth.instance.currentUser();
                String uid=user.uid.toString();

    if(isLoggedIn()){

      Firestore.instance.collection('Traveller').document(uid).setData(TravellerData)
      /*.then((data) async {
            await prefs.setString('id',uid);})*/
            
            .
      catchError((e){
        print(e); });

    //await prefs.setString('id',uid);

    }else{
      print('You Need to log in');
    }
  }}