import 'package:cloud_firestore/cloud_firestore.dart';

class CrudMethodsadventure{
  /*String image,city,email,phonenumber,name,passion;
  profiledata(this.image,this.city,this.email,this.name,this.passion,this.phonenumber);*/

  getData() async{
    return await Firestore.instance.collection('profiledata').where("adventureGuide",isEqualTo: true).getDocuments();

  }
}