

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loader_search_bar/loader_search_bar.dart';
import 'package:miniproject/app_screen/interface.dart';
import 'package:miniproject/messages/TravellermsgUI.dart';
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
Future getposts() async{
  var firestore=Firestore.instance;
 QuerySnapshot qn= await firestore.collection("profiledata").where("city",isEqualTo: query).getDocuments();
 return qn.documents;
}
  final distric = [
    Firestore.instance
        .collection("profiledata")
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) => print('${f.data['city']}'));
    }).toString()
  ];

  final recent = ['Kandy', 'Galle'];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          //print("Hello");
          query = "";
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
    return FutureBuilder(
      future: getposts(),
      builder:(context, snapshot){
if(snapshot.connectionState==ConnectionState.waiting){
  return Center(
    child:Text("Loading")
  );
}
else{
 return ListView.builder(
    itemCount: snapshot.data.length,
    itemBuilder: (context,index){
      return Card(
        
                  elevation: 10.0,
                  child: Column(children: <Widget>[
                    Container(
                      height: 250.0,
                      width: 280.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                            image: NetworkImage(
                              snapshot.data[index].data["Image"],
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
                                snapshot.data[index].data["name"],
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
                              snapshot.data[index].data["passion"]),
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
                            Text(snapshot.data[index].data["city"])
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
                                snapshot.data[index].data["phonenumber"]),
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
                            Text(snapshot.data[index].data["email"])
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
                  ])
      );
      
  });
}

    })
    /*
    Container(
      child:Text("bvcxcvb")
    )*/;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggesionsList = query.isEmpty
        ? recent
        : distric.where((p) => p.startsWith(query)).toList();
    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            showResults(context);
          },
          leading: Icon(Icons.location_city),
          title: RichText(
            text: TextSpan(
                text: suggesionsList[index].substring(0, query.length),
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                      text: suggesionsList[index].substring(query.length),
                      style: TextStyle(color: Colors.grey))
                ]),
          ),
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
                                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TravellermsgUi(peerId:profiledata.documents[i].data['email'])));
             
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


class Detailpage extends StatefulWidget{
  final DocumentSnapshot post;
  Detailpage({this.post});
  @override
  State<StatefulWidget> createState() {
    
    return Detailpage_State();
  }

}

class Detailpage_State extends State<Detailpage>{
  @override
  Widget build(BuildContext context) {
    
    return null;
  }

}