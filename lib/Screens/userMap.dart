import 'package:client_mazdoor/Screens/custom_map.dart';
import 'package:client_mazdoor/Screens/laborList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserMap extends StatefulWidget {
  @override
  _UserMapState createState() => _UserMapState();
}

class _UserMapState extends State<UserMap> {
  PageController _pageController = PageController();
  List<Widget> _screen = [CustomMap(), LaborList()];

  int _selectedIndex = 0;
  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onItemTapped(int selectedIndex) {
    print(selectedIndex);
    _pageController.jumpToPage(selectedIndex);
  }

  //int currentPage = 0;
  //final _pageOptions = [CustomMap(), LaborList()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          controller: _pageController,
          children: _screen,
          onPageChanged: _onPageChanged,
          physics: NeverScrollableScrollPhysics(),
        ),
        //body: _pageOptions[currentPage],
        // bottomNavigationBar: FancyBottomNavigation(
        //     activeIconColor: Theme.of(context).accentColor,
        //     circleColor: Theme.of(context).primaryColor,
        //     tabs: [
        //       TabData(iconData: Icons.map, title: "Map"),
        //       TabData(iconData: Icons.list, title: "Labors Detail"),
        //     ],
        //     onTabChangedListener: (int position) {
        //       setState(() {
        //         currentPage = position;
        //       });
        //     }),
        bottomNavigationBar: CupertinoTabBar(
          //activeColor: Colors.black, //Theme.of(context).accentColor,
          //inactiveColor: Colors.yellow, //Theme.of(context).primaryColor,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.map,
                  color: _selectedIndex == 0
                      ? Colors.blue
                      : Theme.of(context).primaryColor,
                ),
                title: Text(
                  "Map",
                  style: TextStyle(
                    color: _selectedIndex == 0
                        ? Colors.blue
                        : Theme.of(context).primaryColor,
                  ),
                )),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.list,
                  color: _selectedIndex == 1
                      ? Colors.blue
                      : Theme.of(context).primaryColor,
                ),
                title: Text(
                  "LaborList",
                  style: TextStyle(
                    color: _selectedIndex == 1
                        ? Colors.blue
                        : Theme.of(context).primaryColor,
                  ),
                )),
          ],
        ));
  }
}
