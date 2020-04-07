import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loader_search_bar/loader_search_bar.dart';
import 'package:miniproject/app_screen/interface.dart';
import 'Posts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Searchbox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ContentOfThePage(),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xffBA680B),
          title: Text('Search for your guide'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: Datasearchbox());
              },
            ),
            IconButton(
              icon: Icon(Icons.person_add),
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Content()));
              },
            )
          ],
        ));
  }
}

class Datasearchbox extends SearchDelegate<String> {
  final distric = ['Rathhnapura', 'Kegalle', 'Galle', 'Mathara'];
  final recent = ['kegalle', 'Galle'];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          print("Hello");
          //query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(width: 0.0, height: 0.0);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggesionsList = query.isEmpty ? recent : distric;
    return ListView.builder(
      itemBuilder: (context, index) {
        ListTile(
          leading: Icon(Icons.location_city),
          title: Text(suggesionsList[index]),
        );
      },
      itemCount: suggesionsList.length,
    );
  }
}

class ContentOfThePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ContentOfThePage_state();
  }
}

class ContentOfThePage_state extends State<ContentOfThePage> {
  QuerySnapshot profiledata;
  CrudMethods crudobj = CrudMethods();

 @override
  void initState() {
    crudobj.getData().then((result) {
      setState(() {
        profiledata = result;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _profileList();
  }

  Widget _profileList() {
    if (profiledata != null) {
      // print('pd is:$profiledata');

      return ListView.builder(
        itemCount: profiledata.documents.length,
        itemBuilder: (context, i) {
          return Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: new Card(
                  elevation: 10.0,
                  child: Column(children: <Widget>[
                    Container(
                      height: 250.0,
                      width: 280.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                            image: NetworkImage(
                              "${profiledata.documents[i].data['Image']}",
                            ),
                            fit: BoxFit.cover),
                      
                      ),
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    //desciption of the guide
                    Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            //define the guide name
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "${profiledata.documents[i].data['name']}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              width: 45.0,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.0,
                        ),

                        //Description provided by the guide
                        Container(
                          width: 175.0,
                          child: Text(
                              "${profiledata.documents[i].data['passion']}"),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          children: <Widget>[
                            Icon(Icons.location_on),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text("${profiledata.documents[i].data['city']}")
                          ],
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          children: <Widget>[
                            Icon(Icons.phone),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text(
                                "${profiledata.documents[i].data['phonenumber']}"),
                          ],
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          children: <Widget>[
                            Icon(Icons.mail_outline),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text(" ${profiledata.documents[i].data['email']}")
                          ],
                        ),
                        //button for contact
                        ButtonTheme(
                          height: 40.0,
                          minWidth: 75.0,
                          child: RaisedButton(
                              color: Color(0xffBA680B),
                              hoverColor: Color(0xffF5CA99),
                              onPressed: () {
                                print("Hello");
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40.0),
                                side: BorderSide(color: Color(0xffBA680B)),
                              ),
                              child: Text(
                                'Contact me',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15.0),
                              )),
                        ),
                        SizedBox(
                          height: 10.0,
                        )
                      ],
                    ),
                  ])));
        },
      );
    } else {
      return Text("No Guides Are Available");
    }
  }
}
