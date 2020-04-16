import 'package:cloud_firestore/cloud_firestore.dart';

class CrudMethodsheritage{
  /*String image,city,email,phonenumber,name,passion;
  profiledata(this.image,this.city,this.email,this.name,this.passion,this.phonenumber);*/

  getData() async{
    return await Firestore.instance.collection('profiledata').where("heritageGuide",isEqualTo: true).getDocuments();

  }
}