import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:miniproject/app_screen/filters.dart';
import 'package:miniproject/app_screen/guideprofile.dart';
import 'package:miniproject/app_screen/messages.dart';
import 'package:miniproject/app_screen/search.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:miniproject/map_screen/Guide/getmap_guide.dart';
import 'Posts.dart';




class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  
  GlobalKey _bottomNavigationKey = GlobalKey();

  int pageindex = 0;

  final Searchbox _searchbox= Searchbox();
  final Messages _messages=Messages();
  final GetMap_Guide _filterList=GetMap_Guide();
  final Profile _profile=Profile();

  Widget _showpage=Searchbox();
  Widget _pagechooser(int page){
    switch(page){
      case 0:
      return _searchbox;
      break;

      case 1:
      return _messages;
      break;

      case 2:
      return _filterList;
      break;

      case 3:
      return _profile;
      break;




    }
  }

  //display the data
 // QuerySnapshot profiledata;
 // CrudMethods crudobj = CrudMethods();



  @override


  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        automaticallyImplyLeading:false
      ),*/
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: pageindex,
          height: 50.0,
          items: <Widget>[
            Icon(FontAwesomeIcons.bookOpen, size: 30),
            Icon(Icons.email, size: 30),
            Icon(Icons.location_on, size: 30),
            Icon(Icons.person, size: 30),
           // Icon(Icons.perm_identity, size: 30),
          ],
          color: Colors.white,
          buttonBackgroundColor: Colors.white,
          backgroundColor: Color(0xffBA680B),
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (int tappedindex) {
            setState(() {
              _showpage = _pagechooser(tappedindex);
            });
          },
        ),
        body: Container(
          color: Colors.blueAccent,
          child: Center(
            child: _showpage,
          ),
        ));
  }
}