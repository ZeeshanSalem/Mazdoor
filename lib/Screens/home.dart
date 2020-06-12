import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> events = [
    "Construction",
    "Plumber",
    "Electrician",
    "Carpentry",
    "Mechanic",
    "Welding",
    "Sweeper",
    "Chef"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.access_alarm),
        automaticallyImplyLeading: true,
        title: Text("MAZDOOR",
        style: TextStyle(fontSize: 40.0, fontFamily: "Signatra", )),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          )
        ),
        actions: <Widget>[
          Icon(Icons.accessibility),
          
        ],
        bottom: PreferredSize(
          child: Icon(Icons.account_balance),
          preferredSize: Size.fromHeight(50.0),
        ),
      ),
      body: WillPopScope(
        onWillPop: _onBackPressed,
          child: Container(
          margin: const EdgeInsets.only(top: 20.0),
          child: GridView(
            physics: BouncingScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2 ),
            children: events.map((title){
              return GestureDetector(
                child: Card(
                  shadowColor: Theme.of(context).primaryColor,
                  margin: const EdgeInsets.all(10.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 10.0,
                  child: getCardByTitle(title),
                ),
                onTap: (){
                   switch (title) {
                     case 'Construction':
                       //Navigator.pushNamed(context, '/Construction');
                       break;
                     case 'Plumber':
                      //Navigator.pushNamed(context, '/Plumber');
                      break;
                     case 'Electrician':
                      //Navigator.pushNamed(context, '/Electrician');
                      break;
                    case 'Carpentry':
                      //Navigator.pushNamed(context, '/Carpentry');
                      break;
                    case 'Mechanic':
                      //Navigator.pushNamed(context, '/Mechanic');
                      break;
                    case 'Welding':
                      //Navigator.pushNamed(context, '/Welding');
                      break;
                    case 'Sweeper':
                      //Navigator.pushNamed(context, '/Sweeper');
                      break;
                    case 'Chef':
                      //Navigator.pushNamed(context, '/Chef');
                      break;





                     default:
                   }
                  //Action
                },
              );
            }).toList(),
          ),

        ),
      ),


    
    bottomNavigationBar: BottomNavigationBar(
      selectedIconTheme: IconThemeData(
        color: Theme.of(context).accentColor,
        opacity: 1.0,
        size: 32.0,
      ),
      unselectedIconTheme: IconThemeData(
        color: Colors.black,
        opacity: 1.0,
        size: 28.0,
      ),
      backgroundColor: Theme.of(context).primaryColor,
             items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            title: Text('Business'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            title: Text('School'),
          ),
        ],
    ),

    //   bottomNavigationBar: CupertinoTabBar(
    //     items: [
    //       BottomNavigationBarItem(icon: Icon(Icons.home)),
    //       BottomNavigationBarItem(icon: Icon(Icons.home)),
    //     ]
    // )
    );
  }

    Column getCardByTitle(String title){
    String img;
    if(title == "Construction")
      img = "assets/images/Construction.jpg";
    else if( title == "Plumber")
      img = "assets/images/Plumber.jpg";
    else if( title == "Electrician")
      img = "assets/images/Electrician.jpg";
    else if( title == "Carpentry")
      img = "assets/images/Carpentry.jpg";
    else if( title == "Mechanic")
      img = "assets/images/Mechanic.jpg";
    else if( title == "Welding")
      img = "assets/images/Welder.jpg";
    else if( title == "Sweeper")
      img = "assets/images/Sweeper.jpg";
     else if ( title == "Chef")
      img = "assets/images/Chef.jpg";

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(
          child: Container(
            child: Stack(
              children: <Widget>[
                Image.asset(
                  img,
                  width: 300.0,
                  height: 100.0, 
                )
              ],
            ),
          ),
        ),
        Text(title,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold, 
        ),
        textAlign: TextAlign.center,
        ),
      ],
    );

  }

  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text(" Are You Sure ?"),
          content: Text("You are going to exist the application !!"),
          actions: <Widget>[
            FlatButton(
              onPressed: (){
                Navigator.of(context).pop(false);
              }, 
              child: Text('NO')),
              FlatButton(
              onPressed: (){
                Navigator.of(context).pop(true);
              }, 
              child: Text('YES'))
          ],
        );
      }
      );
  }
}