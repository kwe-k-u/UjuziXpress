

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ujuzi_xpress/utils/FirebaseDatabase.dart';



class UjuziUser{
  String __username;
  String __id;
  String __mobileNumber;
  String __email;
  DocumentReference _reference;

  String get username => this.__username;
  String get id => this.__id;
  String get number => this.__mobileNumber;
  String get email => this.__email;
  DocumentReference get reference => this._reference;


  UjuziUser({UserCredential credential,String number,String name}){

    if (credential != null) {
    __createUser(credential.user);
      if (credential.additionalUserInfo.isNewUser) {
        if (name != null) updateUserName(name);
        if (number != null) updateNumber(number);

        postUserDetails(this).then((value) {
          setReference(value);
        });
      } else {
        getUserDetails(id).then((value) {
          setReference(value.reference);
        });
      }
    }
  }


  UjuziUser fromMap(Map<String, dynamic> map){
    this.__username = map["username"];
    this.__email = map["email"];
    this.__id = map["id"];
    this.__mobileNumber = map['number'];

    return this;
  }

  void setReference(DocumentReference ref){
    this._reference = ref;
  }

  void updateUserName(String name){
    this.__username = name;
  }

  void updateEmail(String mail){
    this.__email = mail;
  }

  void updateId(String id){
    this.__id = id;
  }

  void updateNumber(String newNumber) {
    this.__mobileNumber = newNumber;
  }




 void __createUser(User user){
   this.__id = user.uid;
   this.__email = user.email;
   this.__username = user.displayName;
   this.__mobileNumber = user.phoneNumber;

 }



  Map<String, dynamic> asMap(){
    return {
      "number" : number,
      "username" : username,
      "email" : email,
      "id" : id
    };



  }



}