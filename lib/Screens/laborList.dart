import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:url_launcher/url_launcher.dart';

class LaborList extends StatefulWidget {
  @override
  _LaborListState createState() => _LaborListState();
}

class _LaborListState extends State<LaborList>
    with AutomaticKeepAliveClientMixin {
  String phoneNumber;
  void callNumber(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'could not call $phoneNumber';
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        //automaticallyImplyLeading: true,
        title: Text("MAZDOOR DETAIL",
            style: TextStyle(
              fontSize: 30.0,
              fontFamily: "Signatra",
            )),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        )),
      ),
      body: StreamBuilder(
          stream: Firestore.instance
              .collection("Labors_Info")
              //.where("laborType", isEqualTo: "Construction")
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot allLabor = snapshot.data.documents[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: Colors.green[100],
                    elevation: 10.0,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          leading: CircleAvatar(
                            radius: 50.0,
                            backgroundColor: Colors.blue,
                            child: ClipOval(
                              child: SizedBox(
                                width: 60.0,
                                height: 100.0,
                                child: Image.network(
                                  allLabor["laborImage"],
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                          title: Text(
                            allLabor["laborName"],
                            style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          subtitle: Text(
                            "${allLabor["laborPhoneNumber"]} \n${allLabor["laborType"]}",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          isThreeLine: true,
                          //dense: true,
                        ),
                        ButtonBar(
                          children: <Widget>[
                            Ink(
                              decoration: const ShapeDecoration(
                                shape: CircleBorder(),
                                color: Colors.green,
                              ),
                              child: IconButton(
                                color: Colors.white,
                                icon: Icon(Icons.message),
                                onPressed: () async {
                                  setState(() {
                                    phoneNumber =
                                        "sms:" + allLabor["laborPhoneNumber"];
                                  });
                                  callNumber(phoneNumber);
                                },
                              ),
                            ),
                            Ink(
                              decoration: const ShapeDecoration(
                                shape: CircleBorder(),
                                color: Colors.green,
                              ),
                              child: IconButton(
                                color: Colors.white,
                                icon: Icon(Icons.call),
                                onPressed: () async {
                                  setState(() {
                                    phoneNumber =
                                        "tel://" + allLabor["laborPhoneNumber"];
                                  });
                                  callNumber(phoneNumber);
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              );
            }
          }),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
