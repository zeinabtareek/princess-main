import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:princess/AppTheme.dart';
import 'package:princess/Config/GlobalFunction.dart';
import 'package:princess/Views/ContactUs.dart';
import 'package:princess/Views/Policies.dart';
import 'package:princess/Views/Usages.dart';

import 'AboutApp.dart';

class MyDrawer extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
     return _state();
  }
}
class _state extends State<MyDrawer>{
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        width: MediaQuery.of(context).size.width*.7,
        height: MediaQuery.of(context).size.height,
        color: AppTheme.primaryColor,
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      height: 25,width: 25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1000),
                        color:AppTheme.primaryColor
                      ),
                      child: Icon(Icons.close,color: Colors.white,size: 18,),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height*.27,
              padding: EdgeInsets.only(
                bottom: 50
              ),
              color: Colors.white,
              alignment: Alignment.center,
              child: Image.asset("assets/images/logo.png",
              height: MediaQuery.of(context).size.height*.17,
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.pushNamedAndRemoveUntil(context, "/mainPage", (route) => false);
              },
              child: Container(
                width: MediaQuery.of(context).size.width*.7,
                height: MediaQuery.of(context).size.height*.08,
                alignment: Alignment.center,
                child: Text("الرئيسية",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white),),
              ),
            ),
            Divider(thickness: .5,color: Colors.white,),
            GestureDetector(
              onTap: (){
                Navigator.pushNamedAndRemoveUntil(context, "/booking2", (route) => false);
              },
              child: Container(
                width: MediaQuery.of(context).size.width*.7,
                height: MediaQuery.of(context).size.height*.08,
                alignment: Alignment.center,
                child: Text("الحجوزات",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white),),
              ),
            ),
            Divider(thickness: .5,color: Colors.white,),
            GestureDetector(
              onTap: (){
                Navigator.push(context, GlobalFunction.route(ContactUs()));
              },
              child: Container(
                width: MediaQuery.of(context).size.width*.7,
                height: MediaQuery.of(context).size.height*.08,
                alignment: Alignment.center,
                child: Text("تواصل معنا",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white),),
              ),
            ),
            Divider(thickness: .5,color: Colors.white,),
            GestureDetector(
              onTap: (){
                Navigator.push(context, GlobalFunction.route(AboutApp()));
              },
              child: Container(
                width: MediaQuery.of(context).size.width*.7,
                height: MediaQuery.of(context).size.height*.08,
                alignment: Alignment.center,
                child: Text("من نحن",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white),),
              ),
            ),
            Divider(thickness: .5,color: Colors.white,),
            GestureDetector(
              onTap: (){
                Navigator.push(context, GlobalFunction.route(Policies()));
              },
              child: Container(
                width: MediaQuery.of(context).size.width*.7,
                height: MediaQuery.of(context).size.height*.08,
                alignment: Alignment.center,
                child: Text("سياسة الخصوصية",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white),),
              ),
            ),
            Divider(thickness: .5,color: Colors.white,),
            GestureDetector(
              onTap: (){
                Navigator.push(context, GlobalFunction.route(Usages()));
              },
              child: Container(
                width: MediaQuery.of(context).size.width*.7,
                height: MediaQuery.of(context).size.height*.08,
                alignment: Alignment.center,
                child: Text("سياسة الاستخدام",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white),),
              ),
            ),
            Divider(thickness: .5,color: Colors.white,)
          ],
        ),
      ),
    );
  }
}