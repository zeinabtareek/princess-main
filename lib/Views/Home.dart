import 'package:flutter/material.dart';
import 'package:princess/Config/GlobalFunction.dart';
import 'package:princess/Views/History.dart';
import 'package:princess/Views/MyDrawer.dart';
import '../../AppTheme.dart';
import 'MainPage.dart';
import 'Profile.dart';
import 'Search.dart';

class HomePage extends StatefulWidget {
  int index;

  HomePage({required this.index});

  @override
  _State createState() => _State(index: this.index);
}

class _State extends State<HomePage> {
  int index;

  _State({required this.index});

  int _currentIndex = 0;
  List<Widget> itemsUi = [
    Profile(),
    History(),
    MainPage(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _currentIndex = index;
    });
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _key,
        drawer: MyDrawer(),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * .065,
                width: MediaQuery.of(context).size.width,
                color: AppTheme.primaryColor,
                alignment: Alignment.center,
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * .05,
                    right: MediaQuery.of(context).size.width * .05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context, GlobalFunction.routeBottom(Search()));
                        },
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                        )),
                    Text(
                      _currentIndex == 0
                          ? "حسابي"
                          : _currentIndex == 1
                              ? "الحجوزات"
                              : "الرئيسية",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                        onTap: () {
                          _key.currentState!.openDrawer();
                        },
                        child: Icon(
                          Icons.menu,
                          color: Colors.white,
                        )),
                  ],
                ),
              ),
              Expanded(child: itemsUi[_currentIndex])
            ],
          ),
        ),
        bottomNavigationBar: Stack(children: <Widget>[
          BottomNavigationBar(
              elevation: 25.0,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: AppTheme.primaryColor,
              unselectedItemColor: Colors.black38,
              currentIndex: _currentIndex,
              selectedLabelStyle: TextStyle(fontSize: 12, color: Colors.black),
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                  // print('${index}index');
                });
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person_outline,
                    size: 25,
                  ),
                  label: "الحساب",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.history,
                    size: 25,
                  ),
                  label: "الحجوزات",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home_outlined,
                    size: 25,
                  ),
                  label: "الرئيسية",
                ),
              ]),
        ]),
      ),
    );
  }
}
