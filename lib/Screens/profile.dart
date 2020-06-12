import 'dart:io';
import 'package:client_mazdoor/Gvariable.dart' as global ;
import 'package:client_mazdoor/Services/user_services.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final _formKey = GlobalKey<FormState>();
  String phoneNumber;
  String name;
  String userImageUrl;
  File _profileImage;
  SharedPreferences sharedUserData ;
  
  Future getImage()  async{
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);
       setState(() {
         _profileImage = image;
       });
    }
    
     Future uploadPic() async{
      String fileName = basename(_profileImage.path);
      StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);
      StorageUploadTask task = firebaseStorageRef.putFile(_profileImage);
      StorageTaskSnapshot storageTaskSnapshot = await task.onComplete;
      var imageUrl = await storageTaskSnapshot.ref.getDownloadURL();
      //UserServices().addProfileImage(userImageUrl);
      // //userImageUrl = await (await task.onComplete).ref.getDownloadURL();
      // setState(() {
      //   userImageUrl = imageUrl.toString();
      // });
      this.userImageUrl = imageUrl.toString();
    }

    _validityState() async {
      sharedUserData = await SharedPreferences.getInstance();
      final form = _formKey.currentState;
      if(form.validate()){
        form.save();
        if (!mounted) return;
        setState(()  {
          
          sharedUserData.setString("userName", name); 
          global.userName = name;
          global.userPhoneNumber = phoneNumber;
        });
      }
    }
  
  @override
  Widget build(BuildContext context) {

    

    return Scaffold(
      appBar: AppBar(
        title: Text("Registration Form",
        style: TextStyle(
          fontFamily: "Signatra",
          fontSize: 40.0,
          fontStyle: FontStyle.normal,
          //fontWeight: FontWeight.bold
         )),
      ),
      body: SingleChildScrollView(
        child: Column(
            children: <Widget>[
            ClipPath(
              child: Container(
                width: double.infinity,
                height: 300,
                color: Colors.green[200],
                child: Align(
                  alignment: Alignment.lerp(Alignment.topCenter, Alignment.bottomCenter, 0.2),
                  child: Stack(
                    children:<Widget>[
                      CircleAvatar(
                        radius: 100,
                        backgroundColor: Colors.green[100],
                        child: ClipOval(
                          child: SizedBox(
                            width:180.0,
                            height: 180.0,
                            child: (_profileImage != null) ? Image.file(
                              _profileImage,
                              fit: BoxFit.fill,
                            ) : Icon(Icons.person, color: Colors.black,size: 50,),

                          )
                        ),
                      ),
                      Positioned(
                        right: 10,
                        bottom: 05,
                        child: ClipOval(
                          child: Material(
                            color: Colors.greenAccent, // button color
                            child: InkWell(
                              splashColor: Colors.green[300], // inkwell color
                              child: SizedBox(width: 56, height: 56, child: Icon(Icons.add_a_photo, size: 30,)),
                              onTap: () {
                                getImage();
                              },
                            ),
                          ),
                          ), 
                      ),
                    ]
                  ),
                ),
              ),
              clipper: MyClipper(),
            ),
            
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Form(
                key: _formKey,
                  child: Column(
                  children: <Widget>[
                    TextFormField(
                      //style: TextStyle(),
                      validator: (val){
                        if(val.trim().length < 5 || val.isEmpty){
                            return " Username is too Short";
                         } else if(val.trim().length > 15){
                            return " Username is too Long";
                         } else {
                            return null;
                         }
                        },
                      onSaved: (val) => {
                        
                        this.name = val,
                      },
                      decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                           borderRadius: BorderRadius.all(Radius.circular(12.0)),
                           borderSide: BorderSide(color: Colors.green[200]),
                           ),
                      focusedBorder: UnderlineInputBorder(
                           borderRadius: BorderRadius.all(Radius.circular(12.0)),
                           borderSide: BorderSide(color: Colors.green),
                          ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      ),
                      labelText: "Username",
                      labelStyle: TextStyle( fontSize: 20.0, color: Colors.black87),
                      hintText: "Please Enter Your Name",
                      hintStyle: TextStyle( color: Colors.grey, fontSize: 15.0),
                      filled: true,
                      fillColor: Colors.green[50],
                      prefixIcon: Icon(Icons.person_pin, color:Colors.green[300], size: 40.0),
                      
                     ),
                    ),

                    SizedBox( height: 10.0),

                    TextFormField(
                      //style: TextStyle(),
                      validator: (val){
                        if(val.trim().length < 11 || val.isEmpty){
                            return " Phone Number is to short";
                         } else if(val.trim().length > 13){
                            return " Phone Number is too Long";
                         } 
                         else {
                            return null;
                         }
                        },
                      onSaved: (val) => this.phoneNumber = val,
                      decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                           borderRadius: BorderRadius.all(Radius.circular(12.0)),
                           borderSide: BorderSide(color: Colors.green[200]),
                           ),
                      focusedBorder: UnderlineInputBorder(
                           borderRadius: BorderRadius.all(Radius.circular(12.0)),
                           borderSide: BorderSide(color: Colors.green),
                          ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      ),
                      labelText: "Phone Number",
                      labelStyle: TextStyle( fontSize: 20.0, color: Colors.black87),
                      hintText: "+923321991684",
                      hintStyle: TextStyle( color: Colors.grey, fontSize: 15.0),
                      filled: true,
                      fillColor: Colors.green[50],
                      prefixIcon: Icon(Icons.phone,color:Colors.green[300], size: 40.0),
                      
                     ),
                    ),

                    SizedBox( height: 20.0),
                    Center(
                      child: ButtonTheme(
                        height: 40.0,
                        minWidth: 200.0,
                        buttonColor: Colors.green[200],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: RaisedButton(
                          onPressed: (){
                            _validityState();
                            uploadPic().then((value) => {
                            setState(() {
                              global.userImage = userImageUrl; 
                            }),
                            print("SetState"),
                            }).then((value) => {
                            UserServices().addPhoneNumbertoFirestoreCollection(context),
                            print("UserServices")
                            });
                            
                          },
                          child: Text("Continue",
                          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                          textColor: Colors.black,
                        )
                        
                      )
                    )

                    
                  ],
                ),
              ),
            ),

          ]
        ),
      )
    );
  }
}

class MyClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height-100);
    path.quadraticBezierTo(
    size.width / 2, 
    size.height,
    size.width,
    size.height - 100
    );
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    
    return false;
  }

}