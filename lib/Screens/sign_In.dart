import 'package:avatar_glow/avatar_glow.dart';
import 'package:client_mazdoor/Animation_method/delay_animation.dart';

import 'package:client_mazdoor/Screens/enter_number.dart';

import 'package:client_mazdoor/Services/user_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';


class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> with SingleTickerProviderStateMixin {
  final int delayedAmount = 500;
  double _scale;
  AnimationController _controller;
  FacebookLogin fbLogin = new FacebookLogin();
  FirebaseAuth auth = FirebaseAuth.instance;
  //String userPhone = sharedUserData.get("userPhoneNumber");
  String phoneNo;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener((){
       setState((){});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
    
    return Scaffold(
      
      backgroundColor: Colors.green[200],
      body: Center(
        widthFactor: MediaQuery.of(context).size.width,
        heightFactor: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[

            SizedBox( height : 10),
            AvatarGlow(
              child: CircleAvatar(
                backgroundColor: Theme.of(context).accentColor,
                radius: 100.0,
                child: Text("MAZDOOR",
                style:TextStyle(
                  color: Colors.white,
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Signatra"),
                  ),
              ), 
              endRadius:150,
              duration: Duration(seconds: 2),
              glowColor: Colors.black,
              repeat: true,
              repeatPauseDuration: Duration(seconds: 1),
              startDelay: Duration( seconds: 1),
              ),

              SizedBox( height: 30),

              DelayedAnimation(
                child: Text("Hi, I am Here ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                  color: Theme.of(context).accentColor,
                  fontFamily: "Signatra"
                ),),
                delay: delayedAmount + 1000,
                ),

                SizedBox( height: 10),

                 DelayedAnimation(
                child: Text("Save Your Time For Future",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40.0,
                  color: Theme.of(context).accentColor,
                  fontFamily: "Signatra"
                ),),
                delay: delayedAmount + 2000,),

                SizedBox( height: 20),

                DelayedAnimation(
                  child: ButtonTheme(
                      minWidth: 270.0,
                      height: 40,
                      child: RaisedButton(
                      color:Theme.of(context).accentColor,
                      textColor: Colors.white,
                      child: Text("Sign up with phone",
                      style: TextStyle(
                        fontSize: 20.0
                      ),),
                      onPressed: (){
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EnterNumber()),
                      );
                      },
                    ),
                  ),
                    delay: delayedAmount + 3000,),
                
                SizedBox( height: 20),

                DelayedAnimation(
                  child: FacebookSignInButton(
                    onPressed: (){
                      UserServices().initiateFacebookLogin(context);
                      //loginWithFb(context);
                      // //_loginWithFb(context);
                      //  if(userPhone == null){
                        
                    //}
                      
                      
                    },
                    borderRadius: 10.0,
                  ),
                    delay: delayedAmount + 3000,),

          ],
          )
      ),
      
    );
  }

  // showDialog(
  //                         context: context,
  //                         barrierDismissible: true,
  //                         builder: (BuildContext context){
  //                           return AlertDialog(
  //                             title: Text("Enter Mobile Number."),
  //                             titleTextStyle: TextStyle( color: Colors.blueAccent),
  //                             titlePadding: EdgeInsets.all(10.0),
  //                             content: Container(
  //                               child: Column(
  //                               children: <Widget>[
  //                                 Text("we need Your phone number for making connection with labor"),
  //                                 TextField(
  //                                   onChanged: (val){
  //                                     phoneNo = val;
  //                                   },
  //                                 )
  //                               ],
  //                             )),
  //                             actions: <Widget>[
  //                               FlatButton(
  //                                 onPressed: (){
  //                                   setState(() {
  //                                     userPhoneNumber = phoneNo;
  //                                   });
  //                                   UserServices().addPhoneNumbertoFirestoreCollection();
  //                                 }, 
  //                                 child: Text("Done"))
  //                             ],
  //                           );
  //                         });

//   Future<void> _loginWithFb(BuildContext context) async{
//   //FirebaseUser currentUser;
//   final result =  await fbLogin.logIn(["email"]);
//   switch (result.status) {
//     case FacebookLoginStatus.loggedIn:
//       final token =  result.accessToken.token;
//       AuthCredential authCredential = FacebookAuthProvider.getCredential(accessToken: token);
//       AuthResult authResult = await auth.signInWithCredential(authCredential);
//       FirebaseUser user = authResult.user;
//       if( user != null){
//        Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => HomeScreen ()),
//                       );
//       }
//       break;
//     default:
//   }
  
// }
}