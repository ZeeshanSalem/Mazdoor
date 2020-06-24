import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:client_mazdoor/Services/user_services.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:client_mazdoor/Gvariable.dart' as global ;


class SideMenu extends StatefulWidget {

  
  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {

  File _profileImage;

   String userImageUrl ;

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

      if(task.isComplete){
        var url = imageUrl.toString();
        UserServices().updateProfilePic(url);
        setState(() {
          global.userImage = url;
        });
      }
      //UserServices().addProfileImage(userImageUrl);
      // //userImageUrl = await (await task.onComplete).ref.getDownloadURL();
      // setState(() {
      //   userImageUrl = imageUrl.toString();
      // });
      //this.userImageUrl = imageUrl.toString();
     
    }

  @override
  Drawer build(BuildContext context) {
    return Drawer(
      child: ListView(
        //padding: EdgeInsets.zero,
        children:<Widget>[

          ClipPath(
              child: Container(
                width: double.infinity,
                height: 220,
                color: Colors.green[200],
                child: Align(
                  alignment: Alignment.lerp(Alignment.topCenter, Alignment.bottomCenter, 0.2),
                  child: Stack(
                    children:<Widget>[
                      CircleAvatar(
                        radius: 100,
                        backgroundColor: Colors.green[300],
                        child: ClipOval(
                          child: SizedBox(
                            width: 180.0,
                            height: 180.0,
                            child : global.userImage == "" ? 
                            _profileImage != null ? Image.file(
                              _profileImage,
                              fit: BoxFit.fill,
                            ) : Icon(Icons.person, color: Colors.black,size: 50,) : Image.network(global.userImage, fit: BoxFit.fill,),

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
                                getImage().then((value) => uploadPic());
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
          // DrawerHeader(
          //   child: Text("data"),)
          // UserAccountsDrawerHeader(

          //   currentAccountPicture: CircleAvatar(
          //     child: Text("Z"),
          //   ),
          //   accountName: Text("Zeeshan Saleem",style: TextStyle(fontSize: 25.0,color: Colors.white),), 
          //   accountEmail: Text("zeeshansaleem729@gmail.com")
          //   ),

            
            ListTile(
              leading: Icon(Icons.timer, size: 25,),
              title: Text("Your Works", style: TextStyle( fontSize: 20.0),),
              onTap: () => {},
            ),

            ListTile(
              leading: Icon(Icons.notifications, size: 25,),
              title: Text("Notification", style: TextStyle( fontSize: 20.0),),
              onTap: () => {},
            ),

            ListTile(
              leading: Icon(Icons.payment, size: 25,),
              title: Text("Payment", style: TextStyle( fontSize: 20.0),),
              onTap: () => {},
            ),

            ListTile(
              leading: Icon(Icons.help, size: 25,),
              title: Text("Sign Out", style: TextStyle( fontSize: 20.0),),
              onTap: () => {
                UserServices().signOut(),
                
                Navigator.of(context).pushNamedAndRemoveUntil('/SignIn', (Route<dynamic> route)=> false) 
              },
            ),

            ListTile(
              leading: Icon(Icons.settings, size: 25,),
              title: Text("Settings", style: TextStyle( fontSize: 20.0),),
              onTap: () => {},
            ),
        ]
      ),
      
      
    );
  }
}

class MyClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 20);
    path.quadraticBezierTo(
    size.width / 2, 
    size.height,
    size.width,
    size.height - 20,
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