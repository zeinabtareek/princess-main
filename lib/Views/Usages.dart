import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:princess/Provider/MainProvider.dart';
import 'package:provider/provider.dart';

import '../AppTheme.dart';

class Usages extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _state();
  }
}
class _state extends State<Usages>{
  @override
  Widget build(BuildContext context) {
    var mainProvider= Provider.of<MainProvider>(context, listen: true);
    return Scaffold(
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height*.1,
                width: MediaQuery.of(context).size.width,
                color: AppTheme.primaryColor,
                alignment: Alignment.center,
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height*.03,
                    left: MediaQuery.of(context).size.width*.05-5,
                    right: MediaQuery.of(context).size.width*.05-5
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: (){
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Icon(Icons.arrow_forward_ios_rounded,color: AppTheme.primaryColor,size: 20,),
                        )),
                    Text("سياسة الاستخدام",style: TextStyle(fontSize: 14,color: Colors.white,fontWeight: FontWeight.bold),),
                    GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        }
                        ,child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Icon(Icons.arrow_forward_ios_rounded,color: Colors.white,size: 20,),
                    )),
                  ],
                ),
              ),
              SizedBox(height: 15,),
              Expanded(child: SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width*.9,
                  padding: EdgeInsets.only(bottom: 15),
                  alignment: Alignment.center,
                  child: Text(mainProvider.AppInfo["policy_ar"]
                    ,style: TextStyle(fontSize: 12),textAlign: TextAlign.center,),
                ),
              )),

            ],
          ),
        )
    );
  }
}