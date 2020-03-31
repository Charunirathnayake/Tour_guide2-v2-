

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  
 Future<void> logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print("Error signout");
    }
  }

  //googlesignin
  Future<bool>googlesignin() async{
    try{
      GoogleSignIn googleSignIn=GoogleSignIn();
      GoogleSignInAccount account= await googleSignIn.signIn();
      if(account==null)
      return null;
     AuthResult res=await _auth.signInWithCredential(GoogleAuthProvider.getCredential(idToken: (await account.authentication).idToken, 
      accessToken: (await account.authentication).accessToken));
if(res.user==null)
return false;
return true;
    }
    catch(e){
print('Error Logging With Google');
return false;
    }
  }


}
