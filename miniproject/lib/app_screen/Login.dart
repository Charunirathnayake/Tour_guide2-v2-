import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:miniproject/app_screen/auth_guide.dart';
import 'package:miniproject/app_screen/cur_nav_bar.dart';
import 'package:miniproject/app_screen/googlesignin_guide.dart';
import 'package:miniproject/app_screen/search.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'signup.dart';
import 'recover.dart';
import 'googlesingin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

//sketch of the login page
class LoginInterface extends StatelessWidget {
  /*LoginInterface({@required this.auth});
  final authbase auth;


Future <void> _signInWithGoogle()async{
    try{
      await auth.signInWithGoogle();
    }
    catch(e){
      print(e.toString());
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Loginpage(),
      appBar: AppBar(
        /* actions: <Widget>[
          IconButton(icon: Icon(
            Icons.offline_pin
          ),
           onPressed: onSignout)
        ],*/
        title: Text(
          'Tour Guide',
          style: TextStyle(fontSize: 20.0),
        ),
        backgroundColor: Color(0xffBA680B),
      ),
    );
  }
}

class Loginpage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Loginpage_state();
  }
}

class Loginpage_state extends State<Loginpage> {
  final FirebaseAuth _authguide = FirebaseAuth.instance;


//new additions
FirebaseUser currentUser;
SharedPreferences prefs;



//facebook signin
  Future<FirebaseUser> _signinwithfacebookguide() async {
    var facebookLogin = FacebookLogin();
    var resultguide =
        await facebookLogin.logInWithReadPermissions(['public_profile']);
    debugPrint(resultguide.status.toString());

    if (resultguide.accessToken != null) {
      final authresult = await _authguide
          .signInWithCredential(FacebookAuthProvider.getCredential(
        accessToken: resultguide.accessToken.token,
      ));
      return authresult.user;
    } else {
      throw PlatformException(
        code: 'ERROR ABORTED BY USER',
        message: 'Sign in aborted by user',
      );
    }
  }

  TextEditingController emailcontroler = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  var _formkey = GlobalKey<FormState>();

  //visibility icon
  bool _isHiddenPw = true;
  bool _isHiddenCPw = true;
  void _visiblePw() {
    setState(() {
      _isHiddenPw = !_isHiddenPw;
      _isHiddenCPw = _isHiddenCPw;
    });
  }

  void _visibleCPw() {
    setState(() {
      _isHiddenPw = _isHiddenPw;
      _isHiddenCPw = !_isHiddenCPw;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Container(
        child: ListView(children: <Widget>[
          Text(
            'Join with Tour Guide',
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Text('Login',
              style: TextStyle(
                  color: Color(0xffBA680B),
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0)),
          SizedBox(
            height: 30.0,
          ),

          //Enter E-mail
          Center(
            child: Container(
              height: 40.0,
              width: 280.0,
              child: TextFormField(
                validator: validateEmail,
                controller: emailcontroler,
                decoration: InputDecoration(
                    errorStyle:
                        TextStyle(color: Color(0xffBA680B), fontSize: 15.0),
                    prefixIcon: Icon(Icons.email),
                    labelText: 'E-mail',
                    hintText: 'nikeshi@gmail.com',
                    hintStyle: TextStyle(fontSize: 15.0, color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    )),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
          ),
          SizedBox(
            height: 30.0,
          ),

          //Enter password
          Center(
            child: Container(
              height: 40.0,
              width: 280.0,
              child: TextFormField(
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Enter Your Password';
                  } else {
                    return null;
                  }
                },
                controller: passcontroller,
                obscureText: _isHiddenPw,
                decoration: InputDecoration(
                    errorStyle:
                        TextStyle(color: Color(0xffBA680B), fontSize: 15.0),
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      onPressed: _visiblePw,
                      icon: _isHiddenPw
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility),
                    ),
                    labelText: 'Password',
                    hintText: 'Password',
                    hintStyle: TextStyle(fontSize: 15.0, color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    )),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
          ),
          SizedBox(
            height: 30.0,
          ),

          //Navigate Signup
          Center(
            child: Container(
              child: GestureDetector(
                child: Text(
                  'No Account yet?SignUp here',
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      decorationStyle: TextDecorationStyle.solid,
                      fontSize: 15.0,
                      color: Color(0xff7B4508),
                      fontWeight: FontWeight.bold,
                      decorationThickness: 1.5),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => (Signup()),
                      ));
                },
              ),
            ),
          ),

          SizedBox(
            height: 10.0,
          ),

          //button for login
          Padding(
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            child: RaisedButton(
                color: Color(0xffBA680B),
                hoverColor: Color(0xffF5CA99),
                onPressed: () async {
                  //new addtitions
                   prefs = await SharedPreferences.getInstance();
                   
                  if (emailcontroler.text.isEmpty ||
                      passcontroller.text.isEmpty) {
                    setState(() {
                      _formkey.currentState.reset();
                    });
                    print('Enter your field');
                    return;
                  } else {
                    bool res = await Auth().signInWithEmail(
                        emailcontroler.text, passcontroller.text);

                    if (res == true) {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BottomNavBar( )));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginInterface(),

                          ));
                    }
                  }
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.0),
                  side: BorderSide(color: Color(0xffBA680B)),
                ),
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                )),
          ),

          //Forget password
          Center(
            child: Container(
              child: GestureDetector(
                child: Text(
                  'I forget my password',
                  style: TextStyle(
                      decorationStyle: TextDecorationStyle.solid,
                      fontSize: 15.0,
                      color: Color(0xff7B4508),
                      fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  //TODO:DEFINE ONTAP
                 Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => (Recover()),
                      ));
                },
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),

          //line separator
          Center(
            child: Container(
              child: Text(
                '_______________________OR________________________',
                style: TextStyle(color: Color(0xffBA680B)),
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          //button for google signin
          Padding(
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            child: OutlineButton(
              onPressed: () async {
                bool res_guide = await AuthProvider_guide().googlesignin();
                if (!res_guide) {
                  print('ERROR LOGGING WITH GOOGLE');
                }  
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.0),
                side: BorderSide(color: Colors.white),
              ),
              child: Row(
                children: <Widget>[
                  Image_Google(),
                  SizedBox(
                    width: 5.0,
                  ),
                  Padding(
                    child: Container(
                      child: Text('Continue with Google'),
                    ),
                    padding: EdgeInsets.only(left: 5.0),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),

          //facebook login
          Padding(
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            child: OutlineButton(
              onPressed: _signinwithfacebookguide,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.0),
                side: BorderSide(color: Colors.white),
              ),
              child: Row(
                children: <Widget>[
                  Image_Facebook(),
                  SizedBox(
                    width: 5.0,
                  ),
                  Padding(
                    child: Container(
                      child: Text('Continue with FaceBook'),
                    ),
                    padding: EdgeInsets.only(left: 5.0),
                  )
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}

//Set Image for the button
class Image_Google extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AssetImage assetimage = AssetImage('images/google.png');
    Image image = Image(image: assetimage, height: 15.0, width: 15.0);
    return image;
  }
}

//Set Image for the facebook button
class Image_Facebook extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AssetImage assetimage = AssetImage('images/facebook.png');
    Image image = Image(image: assetimage, height: 20.0, width: 20.0);
    return image;
  }
}

//validate email
String validateEmail(String value) {
  /*Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value)) {
    return 'Enter Valid Email';
  }*/
  if (value.isEmpty) {
    return 'Enter your E mail';
  }
  return null;
}
