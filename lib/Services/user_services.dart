import 'dart:async';
//import 'Package:cGlobals/Gvariable.dart' as global;
import 'package:client_mazdoor/Gvariable.dart' as global;
import 'package:client_mazdoor/Services/user_id.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserServices{
  SharedPreferences sharedUserData;

  //CurrentUser
  FirebaseUser user;

  Future<String> currentUser() async{
    user = await FirebaseAuth.instance.currentUser();
    return user != null? user.uid : null;
  }

  addPhoneNumbertoFirestoreCollection(BuildContext context) async{
    sharedUserData = await SharedPreferences.getInstance();
    String currentUserId = sharedUserData.get("currentUserId");

    Firestore.instance.collection("Users_Info").document(currentUserId).setData({
      "userPhoneNumber" : global.userPhoneNumber,
      "userId" : global.userId,
      "userName" : global.userName,
      "userImage" : global.userImage,
      
    },
    merge: true,
    ).then((val){
      print("Createdghhchg");
      Navigator.of(context).pushReplacementNamed('/UserLocation');
    });
  }

  //add User location to Firestore
  Future userLocationStore() async{
    sharedUserData = await SharedPreferences.getInstance();
    String currentUserId = await UserID().functionUserId();
    Firestore.instance.collection("Users_Info").document(currentUserId).setData({
      "userLatitude" : global.userLatitude,
      "userLongitude" : global.userLongitude,
    },
    merge: true,
    );
  }

  //uploadProfile Pic
  // addProfileImage(String urlOfImage) async{
  //    String currentUserId = await UserID().functionUserId();
  //    Firestore.instance.collection("Users_Info").document(currentUserId).setData({
  //      "userImage" : userImage,
  //    },
  //    merge: true,
  //    ).then((value) => {
  //      print("Uploaded"),
  //    });
  // }

  //Update Profile PIC
  updateProfilePic(picUrl) async{
    var userInfo = new UserUpdateInfo();
    userInfo.photoUrl = picUrl;
    var auth = await FirebaseAuth.instance.currentUser(); 
    auth.updateProfile(userInfo).then((value){
      FirebaseAuth.instance.currentUser().then((user) {
        Firestore.instance.collection("Users_Info")
        .where('uid', isEqualTo: user.uid)
        .getDocuments()
        .then((doc) {
          Firestore.instance.document("/Users_Info/${doc.documents[0].documentID}")
          .updateData({'userImage' : picUrl}).then((value) {
            print("Updated pic");
          }).catchError((onError){
            print("$onError");
          });
        })
        .catchError((e){
          print("$e");
        });
      })
      .catchError((onError){
        print("$onError");
      });
    }).catchError((onError){
      print("$onError");
    });
  }

  //Sign out
  signOut() {
    FirebaseAuth.instance.signOut();
  }

  // //SignIn
  // signIn(AuthCredential authCreds) {
  //   FirebaseAuth.instance.signInWithCredential(authCreds);
  //   print("I called");
  // }

  // signInWithOTP(smsCode, verId) {
  //   AuthCredential authCreds = PhoneAuthProvider.getCredential(
  //       verificationId: verId, smsCode: smsCode);
  //   signIn(authCreds);
  // }

  // facebook authentication
  final FirebaseAuth auth = FirebaseAuth.instance;
  var facebookLogin = FacebookLogin();

  void initiateFacebookLogin(BuildContext context) async{
    sharedUserData = await SharedPreferences.getInstance();
    facebookLogin = FacebookLogin();

    var facebookLoginResult =  await facebookLogin.logIn(["email"]);

    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.error:
        print("Error => ${facebookLoginResult.errorMessage.toString()}");
        break;
      
      case FacebookLoginStatus.cancelledByUser:
        print("Cancel");
        break;
      
      case FacebookLoginStatus.loggedIn:
        try{
          final token = facebookLoginResult.accessToken.token;
          AuthCredential authCredential = FacebookAuthProvider.getCredential(
            accessToken: token,
          );

          AuthResult authResult = await FirebaseAuth.instance.signInWithCredential(authCredential); 
          user = authResult.user;
          if(authResult.additionalUserInfo.isNewUser){
          sharedUserData.setString("currentUserId", user.uid);
          global.userId= user.uid;
          //addPhoneNumbertoFirestoreCollection(context);
          // Firestore.instance.collection("Users_Info").document(user.uid).setData({
          //   'userId': user.uid,
          //   'userEmail': user.email,
          //   'userName' : user.displayName,
          //   'userPhoneNumber' : user.phoneNumber,
          //   'userImage' : user.photoUrl,
            
          // }).then((value){
            
          //  // sharedUserData.setString("userPhoneNumber", user.phoneNumber);
          //   Navigator.pop(context);
          //   // Navigator.pushAndRemoveUntil(context, 
          //   // MaterialPageRoute(builder: (context) => HomeScreen()),
          //   //  (Route<dynamic> route) => false);
          // });
          Navigator.of(context).pushReplacementNamed('/Registration');
          }
          else{
            Navigator.of(context).pushReplacementNamed('/UserLocation');
          }
          
          
        } catch (e){
          print(" Error in try Catch =>" + e.toString());
        }
        break;

      default:
    }
  } 
}