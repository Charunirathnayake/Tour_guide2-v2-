
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:miniproject/app_screen/googlesignin_guide.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

//create appbar
class Recover extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tour Guide',
          style: TextStyle(fontSize: 20.0),
        ),
        backgroundColor: Color(0xffBA680B),
        actions: <Widget>[
          Padding(
            child: IconButton(
              icon: Icon(Icons.arrow_back, size: 25.0),
              onPressed: () {},
            ),
            padding: EdgeInsets.only(right: 15.0),
          )
        ],
      ),
      body: New_password(),
    );
  }
}

class New_password extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return New_password_State();
  }
}

class New_password_State extends State<New_password> {
  TextEditingController _email = TextEditingController();
  var _formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    

    return
        ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                SizedBox(
                  height: 20.0,
                ),

//First test
                Text(
                  'Recover Your Password',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                SizedBox(
                  height: 30.0,
                ),

//second test
                Padding(
                  child: Text(
                    'Enter Your E-mail address and we will send you a reset password-link to your E-mail box.',
                    style: TextStyle(fontSize: 17.0),
                  ),
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                ),

                SizedBox(
                  height: 30.0,
                ),

                //entering the mail
                Center(
                  child: Container(
                    height: 40.0,
                    width: 280.0,
                    child: TextFormField(
                      validator: validateEmail,
                      controller: _email,
                      decoration: InputDecoration(
                        errorStyle: TextStyle(
                                  color: Colors.redAccent, fontSize: 15.0),
                          labelText: 'E-mail',
                          labelStyle:
                              TextStyle(fontSize: 15.0, color: Colors.black),
                          hintText: 'nipunsachintha@gmail.com',
                          hintStyle:
                              TextStyle(fontSize: 15.0, color: Colors.grey),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey))),
                    ),
                  ),
                ),

                SizedBox(
                  height: 50.0,
                ),

                Padding(
                  padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  child: RaisedButton(
                      color: Color(0xffBA680B),
                      hoverColor: Color(0xffF5CA99),
                      onPressed: ()async {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            _isLoading = true;
                          });
                          FirebaseAuth.instance
                              .sendPasswordResetEmail(email: _email.text)
                              .then((onValue) {
                            _isLoading = false;
                            dialogResetTrigger(context);
                          });
                        }
                      else{print("heloooo");}}
                      ,
                    
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0),
                        side: BorderSide(color: Color(0xffBA680B)),
                      ),
                      child: Text(
                        'Send new password link',
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      )
                  )
                  ),

                SizedBox(
                  height: 10.0,
                )
              ],
            )
          ],
        )
      
    ;
  }
  Future<bool>dialogResetTrigger(BuildContext context){
    return showDialog(context: context,
    barrierDismissible: false,
    builder: (BuildContext context){
      return Container(
        child:AlertDialog(title: Text("hello"),
        content: Text("hhgddddddddddddddddddddddddddddddddddddddddddddddj"),
        actions: <Widget>[
          FlatButton(onPressed: (){Navigator.of(context).pop();}, child: Text("sdjjj"))
        ],
        )
      );
    }
    );
  }
}
 String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Enter valid password';
    }
    return null;
  }
