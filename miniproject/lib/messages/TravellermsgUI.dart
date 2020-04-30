import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TravellermsgUi extends StatelessWidget {
  final String peerId;

  TravellermsgUi({Key key,@required this.peerId}):super(key:key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tour Guide',
          style: TextStyle(fontSize: 20.0),
        ),
        backgroundColor: Color(0xffBA680B),
      ),
      body: MsgUI(peerId: peerId,),
    );
  }
}

class MsgUI extends StatefulWidget {

 final String peerId;

 


  MsgUI({Key key,@required this.peerId}):super(key:key); 
  @override
  State<StatefulWidget> createState() {
    return MsgUI_State(peerId:peerId);
  }
}

class MsgUI_State extends State<MsgUI> {
String peerId;
String uid;

var listMessage;
bool isLoading;
final FocusNode focusNode = new FocusNode();





  MsgUI_State({Key key,@required this.peerId});


  String groupChatId;
   SharedPreferences prefs;
@override
  void initState() {
    super.initState();
  

    groupChatId = '';

    isLoading=false;

    readLocal();
  }

 readLocal() async {
FirebaseUser user=await FirebaseAuth.instance.currentUser();
var uid;
if(user!=null){
uid=user.uid;
print(uid);
}

   /* prefs = await SharedPreferences.getInstance();
    uid = prefs.getString('id') ?? '';*/
    
    if (uid.hashCode <= peerId.hashCode) {
      groupChatId = '$uid-$peerId';
    } else {
      groupChatId = '$peerId-$uid';
    }

    Firestore.instance.collection('Traveller').document(uid).updateData({'chattingWith': peerId});

    setState(() {});
  }



Future getmsg() async{
  var firestore=Firestore.instance;
 QuerySnapshot mg= await firestore.collection("messages_traveller").getDocuments();
 return mg.documents;
}


  // msg controller define
  TextEditingController _msgController = TextEditingController();
  final ScrollController listScrollController = new ScrollController();

//when click submit button
  /*void Handlesubmit(String text) {

      if(_msgController!=null){

        DocumentReference documentReference=Firestore.instance.collection('messages_traveller').document();
        documentReference.setData({
          'mgid':documentReference.documentID,
          'msg':_msgController.text
        }).then((results)=>_msgController.clear()).catchError((e){
          print(e);
        });
 
      }

     }
*/

 /*  Widget buildListMessage() {
    return Flexible(
      child: groupChatId == ''
          ? Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(themeColor)))
          : StreamBuilder(
              stream: Firestore.instance
                  .collection('messages')
                  .document(groupChatId)
                  .collection(groupChatId)
                  .orderBy('timestamp', descending: true)
                  .limit(20)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                      child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(themeColor)));
                } else {
                  listMessage = snapshot.data.documents;
                  return ListView.builder(
                    padding: EdgeInsets.all(10.0),
                    itemBuilder: (context, index) => buildItem(index, snapshot.data.documents[index]),
                    itemCount: snapshot.data.documents.length,
                    reverse: true,
                    controller: listScrollController,
                  );
                }
              },
            ),
    );
  }
*/



//msg textfield
 /* Widget _textComposerWidget() {
    return IconTheme(
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: <Widget>[
              Flexible(
                child: TextField(
                  focusNode: focusNode,
                  onSubmitted: Handlesubmit,
                  controller: _msgController,
                  decoration: InputDecoration.collapsed(
                      hintText: "Send Your message with Contact number"),
                ),
              ),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () => Handlesubmit(_msgController.text)))
            ],
          )),
      data: IconThemeData(color: Color(0xffBA680B)),
    );
  }*/


  //new 1
  void onSendMessage(String content) {
    // type: 0 = text, 1 = image, 2 = sticker
    if (content.trim() != '') {
      _msgController.clear();

      var documentReference = Firestore.instance
          .collection('messages')
          .document(groupChatId)
          .collection(groupChatId)
          .document(DateTime.now().millisecondsSinceEpoch.toString());

      Firestore.instance.runTransaction((transaction) async {
        await transaction.set(
          documentReference,
          {
            'idFrom':uid,
            'idTo': peerId,
            'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
            'content': content,
          },
        );
      });
      listScrollController.animateTo(0.0, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    } else {
      Fluttertoast.showToast(msg: 'Nothing to send');
    }
  }



  //new2
  
 Widget buildItem(int index, DocumentSnapshot document) {
    if (document['idFrom'] == uid) {
      // Right (my message)
      return 
              // Text
               Container(
                  child: Text(
                    document['content'],
                    style: TextStyle(color: Colors.blue),
                  ),
                  padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                  width: 200.0,
                  decoration: BoxDecoration(color: Colors.brown, borderRadius: BorderRadius.circular(8.0)),
                  margin: EdgeInsets.only(bottom: isLastMessageRight(index) ? 20.0 : 10.0, right: 10.0),
                );
    } 
    
    
    else {
      // Left (peer message)
      return Container(
        child: Column(
          children: <Widget>[
         
                Container(
                        child: Text(
                          document['content'],
                          style: TextStyle(color: Colors.white),
                        ),
                        padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                        width: 200.0,
                        decoration: BoxDecoration(color: Colors.brown, borderRadius: BorderRadius.circular(8.0)),
                        margin: EdgeInsets.only(left: 10.0),
                      ),
                     

            

            //colum

            // Time
            isLastMessageLeft(index)
                ? Container(
                    child: Text(
                      DateFormat('dd MMM kk:mm')
                          .format(DateTime.fromMillisecondsSinceEpoch(int.parse(document['timestamp']))),
                      style: TextStyle(color: Colors.deepOrange, fontSize: 12.0, fontStyle: FontStyle.italic),
                    ),
                    margin: EdgeInsets.only(left: 50.0, top: 5.0, bottom: 5.0),
                  )
                : Container()
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
        margin: EdgeInsets.only(bottom: 10.0),
      );
    }
  }

bool isLastMessageLeft(int index) {
    if ((index > 0 && listMessage != null && listMessage[index - 1]['idFrom'] == uid) || index == 0) {
      return true;
    } else {
      return false;
    }
  }

  bool isLastMessageRight(int index) {
    if ((index > 0 && listMessage != null && listMessage[index - 1]['idFrom'] != uid) || index == 0) {
      return true;
    } else {
      return false;
    }
  }


 Future<bool> onBackPress() {
      
    return  Firestore.instance.collection('Traveller').document(uid).updateData({'chattingWith': null});
      Navigator.pop(context);
    

    
  }



  @override
  Widget build(BuildContext context) {
    return 

WillPopScope(
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              // List of messages
              buildListMessage(),

              

              // Input content
              buildInput(),
            ],
          ),

          // Loading
          buildLoading()
        ],
      ),
      onWillPop: onBackPress,
    );
  

    }


    Widget buildLoading() {
    return Positioned(
      child: isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color(0xffBA680B))),
              ),
              color: Colors.white.withOpacity(0.8),
            )
          : Container(),
    );
  }


Widget buildInput() {
    return Container(
      child: Row(
        children: <Widget>[
          
     

          // Edit text
          Flexible(
            child: Container(
              child: TextField(
                style: TextStyle(color: Colors.black, fontSize: 15.0),
                controller: _msgController,
                decoration: InputDecoration.collapsed(
                  hintText: 'Type your message...',
                  hintStyle: TextStyle(color: Colors.greenAccent),
                ),
                focusNode: focusNode,
              ),
            ),
          ),

          // Button send message
          Material(
            child: new Container(
              margin: new EdgeInsets.symmetric(horizontal: 8.0),
              child: new IconButton(
                icon: new Icon(Icons.send),
                onPressed: () => onSendMessage(_msgController.text),
                color: Colors.amberAccent,
              ),
            ),
            color: Colors.white,
          ),
        ],
      ),



      
      width: double.infinity,
      height: 50.0,
      decoration: new BoxDecoration(
          border: new Border(top: new BorderSide(color: Colors.blue, width: 0.5)), color: Colors.white),
    );
  }



  Widget buildListMessage() {
    return Flexible(
      child: groupChatId == ''
          ? Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color(0xffBA680B))))
          : StreamBuilder(
              stream: Firestore.instance
                  .collection('messages')
                  .document(groupChatId)
                  .collection(groupChatId)
                  .orderBy('timestamp', descending: true)
                  .limit(20)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                      child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color(0xffBA680B))));
                } else {
                  listMessage = snapshot.data.documents;
                  return ListView.builder(
                    padding: EdgeInsets.all(10.0),
                    itemBuilder: (context, index) => buildItem(index, snapshot.data.documents[index]),
                    itemCount: snapshot.data.documents.length,
                    reverse: true,
                    controller: listScrollController,
                  );
                }
              },
            ),
    );
  }

}
    
  //old one  
    /*Column(
children: <Widget>[
  Flexible(child:

  FutureBuilder(
  future: getmsg(),
  builder:(context,snapshot){
  if(snapshot.connectionState==ConnectionState.waiting){
    return Center(
child: Text("Loading"),
    );
  }else
return ListView.builder(
  padding: EdgeInsets.all(8.0),
  reverse: true,
  itemCount: snapshot.data.length,
  itemBuilder: (context,index){
  return Padding(
    padding: const EdgeInsets.all(1.0),
    child: Container(
      height: 70.0,
      child: Card(
        
      
        elevation: 10.0,
       child: Text(snapshot.data[index].data["msg"]
       ,style: TextStyle(fontSize:15.0),),
      ),
    ),
  );
});

}
 ),

   ),

   Divider(height:1.0),
   Container(
     child:_textComposerWidget()
   )
],
    );*/
    
  
  
