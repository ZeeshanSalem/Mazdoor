import 'package:client_mazdoor/Screens/sideMenu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
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
        
        centerTitle: true,
        //automaticallyImplyLeading: true,
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
      
      drawer: SideMenu(),

      backgroundColor: Colors.green[50],
      body: StreamBuilder(
        stream: Firestore.instance.collection("All_Engineering").snapshots(),
        builder: (context, snapshot){
          if (snapshot.hasData) {
            return GridView.builder(
            itemCount: snapshot.data.documents.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2), 
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index){
              DocumentSnapshot allEngineering = snapshot.data.documents[index];
              return GestureDetector(
                child: Card(
                  shadowColor: Theme.of(context).primaryColor,
                  margin: const EdgeInsets.all(10.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  elevation: 5.0,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.network(allEngineering["image"],
                        width: 300.0,height: 100.0,),

                        Text(allEngineering["title"],
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                        )

                      ],)
                  ),)
              );
            } 
            );
          } else {
            return Center(
              widthFactor: double.maxFinite,
              heightFactor: double.maxFinite,
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightGreenAccent,
              ),
            );
          }
          
        },
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

    
}