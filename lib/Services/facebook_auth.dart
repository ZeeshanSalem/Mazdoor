import 'package:client_mazdoor/Screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class FacebookAuth{

  FacebookLogin fbLogin = new FacebookLogin();
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> loginWithFb(BuildContext context) async{
  //FirebaseUser currentUser;
  final result =  await fbLogin.logIn(["email"]);
  switch (result.status) {
    case FacebookLoginStatus.loggedIn:
      final token =  result.accessToken.token;
      AuthCredential authCredential = FacebookAuthProvider.getCredential(accessToken: token);
      AuthResult authResult = await auth.signInWithCredential(authCredential);
      FirebaseUser user = authResult.user;
      if( user != null){
       Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
      }
      break;
    default:
  }
  
}
}