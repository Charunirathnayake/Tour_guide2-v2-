import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider_guide {
  final FirebaseAuth _auth_guide = FirebaseAuth.instance;

//googlesignin
  Future<bool>googlesignin() async{
    try{
      GoogleSignIn googleSignIn=GoogleSignIn();
      GoogleSignInAccount account= await googleSignIn.signIn();
      if(account==null)
      return false;
     AuthResult res_guide=await _auth_guide.signInWithCredential(GoogleAuthProvider.getCredential(idToken: (await account.authentication).idToken, 
      accessToken: (await account.authentication).accessToken));
if(res_guide.user==null)
return false;
return true;
    }
    catch(e){
print('Error Logging With Google');
return false;
    }
  }
}
