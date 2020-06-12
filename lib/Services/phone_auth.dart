// import 'package:client_mazdoor/Screens/home.dart';
// import 'package:client_mazdoor/Screens/sign_In.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class Phone_Auth{
   
//   Future<void> verifyPhone(BuildContext context,String phoneNo, String verificationId,String smsCode) async{
//     final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId){
//       verificationId = verId;
//     };
//     final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]){
//       verificationId = verId;
//       smsCodeDialoge(context, smsCode, verificationId).then((value){
//         print('Signed In');
//       });
//     };
//     final PhoneVerificationCompleted verifiedSuccess = (AuthCredential auth){
//       print('verified');
//     };
//     final PhoneVerificationFailed verifyFailed = (AuthException e) {
//       print('${e.message}');
//     };
//     await FirebaseAuth.instance.verifyPhoneNumber(
//       phoneNumber: phoneNo,
//       timeout: const Duration(seconds: 5),
//       verificationCompleted: verifiedSuccess,
//       verificationFailed: verifyFailed,
//       codeSent: smsCodeSent,
//       codeAutoRetrievalTimeout: autoRetrieve,
//     );
//   }
//   Future<bool> smsCodeDialoge(BuildContext context, String smsCode,String verificationId){
//     return showDialog(context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return new AlertDialog(
//           title: Text('Enter OTP'),
//           content: TextField(
//             onChanged: (value)  {
//               smsCode  = value;
//             },
//           ),
//           contentPadding: EdgeInsets.all(10.0),
//           actions: <Widget>[
//             new FlatButton(
//                 onPressed: (){
//                   FirebaseAuth.instance.currentUser().then((user){
//                     if(user != null){
//                       Navigator.of(context).pop();
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => HomeScreen()),
//                       );

//                     }
//                     else{
//                       Navigator.of(context).pop();
//                       signIn(context,smsCode,verificationId);
//                     }

//                   }
//                   );
//                 },
//                 child: Text('Done', style: TextStyle( color: Colors.blue),))
//           ],
//         );
//       },
//     );
//   }

//   Future<void> signIn(BuildContext context,String smsCode,String verificationId) async {
//     final AuthCredential credential = PhoneAuthProvider.getCredential(
//       verificationId: verificationId,
//       smsCode: smsCode,
//     );
//      await FirebaseAuth.instance.signInWithCredential(credential)
//         .then((user){
//        Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => SignIn()),
//                       );

//       //Navigator.of(context).pushReplacementNamed('/loginpage');
//     }).catchError((e){
//       print(e);
//     });
//   }
// }