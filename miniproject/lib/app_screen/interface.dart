import 'package:flutter/material.dart';
import 'package:miniproject/app_screen/Login.dart';
import 'package:miniproject/app_screen/Login_traveller.dart';
import 'package:miniproject/app_screen/MainScreen_guide.dart';
import 'package:miniproject/app_screen/guideprofile.dart';
import 'package:miniproject/app_screen/messages.dart';
import 'package:miniproject/app_screen/messages.dart' as prefix0;
import 'package:miniproject/app_screen/search.dart';
import 'guideprofile.dart';
import 'signup.dart';

//create appbar
class Content extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Choosepage(),
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Searchbox()));
              })
        ],
        title: Text(
          'Tour Guide',
          style: TextStyle(fontSize: 20.0),
        ),
        backgroundColor: Color(0xffBA680B),
      ),
    );
  }
}

//choose the registration guide or traveller
class Choosepage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Choosepage_state();
  }
}

class Choosepage_state extends State<Choosepage> {
  int mytype;

  String type;
  void _handletype(int value) {
    setState(() {
      mytype = value;
      switch (value) {
        case 1:
          type = 'Guide';
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => (MainScreen_Guide())));

          break;
        case 2:
          type = 'Traveller';
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => (LoginInterface_traveller()),
              ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(right: 25.0, left: 25.0, top: 30),
        child: Container(
          padding: EdgeInsets.only(top:100.0,bottom: 100.0,left: 66.0,right: 50.0),
          child: Column(children: <Widget>[
            Column(
              children: <Widget>[
            Row(
                  children: <Widget>[
                    Text(
                      'Guide',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
                    ),
                    SizedBox(width: 30.0,),
                    Radio(
                      value: 1,
                      groupValue: mytype,
                      onChanged: _handletype,
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Row(
                  children: <Widget>[
                    Text(
                      'Traveller',
                      style:
                          TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                    ),
                    Radio(
                      value: 2,
                      groupValue: mytype,
                      onChanged: _handletype,
                    )
                  ],
                )
              ],
            )
          ]),
        ));
  }

  /*int _selected = 0;
  void onchanged(int value) {
    setState(() {
      _selected = value;
      //TODO LIST(provide the logic to go another page)
    });
  }

//create radio buttons for selections.
  List<Widget> makeradio() {
    List<Widget> list = new List<Widget>();
    list.add(Padding(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                'Guide',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
              SizedBox(
                height: 50.0,
                width: 25.0,
              ),
              Radio(
                value:1 ,
                groupValue: _selected,
                onChanged: (int value) {
                  onchanged(value);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => (LoginInterface())));
                },
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Text(
                'Travellar',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              Radio(
                value: 0,
                groupValue: _selected,
                onChanged: (int value) {
                  onchanged(value);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => (LoginInterface_traveller()),
                      ));
                },
              )
            ],
          )
        ],
      ),
      padding: EdgeInsets.all(50.0),
    ));
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 100.0, left: 60.0),
      child: Center(
        child: Column(children: makeradio()),
      ),
    );
  }*/

}
