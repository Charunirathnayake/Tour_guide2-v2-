import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:miniproject/app_screen/filters.dart';
import 'package:miniproject/app_screen/messages.dart';
import 'package:miniproject/app_screen/search.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:miniproject/app_screen/searchboxTraveller.dart';
import 'package:miniproject/map_screen/Traveller/getmap.dart';
import 'package:miniproject/map_screen/map_traveller.dart';
import 'package:miniproject/post_upload/post_home.dart';


class BottomNavBar_traveller extends StatefulWidget {
  @override
  _BottomNavBarState_traveller createState() => _BottomNavBarState_traveller();
}

class _BottomNavBarState_traveller extends State<BottomNavBar_traveller> {
  
  GlobalKey _bottomNavigationKey = GlobalKey();

  int pageindex = 0;

  final Searchboxtraveller _searchboxtraveller= Searchboxtraveller();
  final Messages _messages=Messages();
  final FilterList _filterList=FilterList();
  final PostHome _posts=PostHome();
  final GetMap _map= GetMap();

  Widget _showpage=Searchbox();
  Widget _pagechooser(int page){
    switch(page){
      case 0:
      return _searchboxtraveller;
      break;

      case 1:
      return _messages;
      break;

      case 2:
      return _filterList;
      break;
      case 3:
      return _posts;

      case 4:
      return _map;
      break;




    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: pageindex,
          height: 50.0,
          items: <Widget>[
            Icon(FontAwesomeIcons.bookOpen, size: 30),
            Icon(Icons.email, size: 30),
            Icon(Icons.filter_list, size: 30),
            Icon(Icons.stars,size:30),
            Icon(Icons.location_on, size: 30),
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