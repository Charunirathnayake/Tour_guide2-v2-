import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth{
  final _firebaseAuth=FirebaseAuth.instance;
  Future<bool> signInWithEmail(String email, String password) async {
    try {
      AuthResult result = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      if (user != null) {
        
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
Future<void> logOut () async{
try{
await _firebaseAuth.signOut();
}
catch(e){
print("Error Logging Out");
}
}


}
