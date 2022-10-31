import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:princess/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _state();
  }
}

class _state extends State<Splash> {
  loadData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("Id"));
    print("--------------------------------------------------");
    setState(() {
      MyApp.Id = int.parse(pref.getString("Id") ?? "0");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 5), () {
      Navigator.pushNamedAndRemoveUntil(context, "/mainPage", (route) => false);
      // Phoenix.rebirth(context);
    });
    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/images/logo.png",
          height: MediaQuery.of(context).size.height * .35,
        ),
      ),
    );
  }
}
