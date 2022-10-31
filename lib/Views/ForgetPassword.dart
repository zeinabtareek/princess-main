import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:princess/Config/GlobalFunction.dart';

import '../AppTheme.dart';
import 'Verification.dart';

class ForgetPassword extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
   return _state();
  }
}
class _state extends State<ForgetPassword>{
  final formKey = GlobalKey<FormState>();
  TextEditingController email = new TextEditingController();
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    body: SingleChildScrollView(
      child: Column(
        children: [
          Form(
            key: formKey,
            child: Padding(
              padding:  EdgeInsets.only(
                  left: MediaQuery.of(context).size.width*.05,
                  right:  MediaQuery.of(context).size.width*.05
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(margin: EdgeInsets.zero,height: MediaQuery.of(context).size.height*.05,color: Colors.white),
                 Row(
                   children: [
                     Container(
                         width: MediaQuery.of(context).size.width*.8,
                         child: Text("Enter Your Email To Send Code To Reset Your Password",textAlign: TextAlign.center,style: TextStyle(color: Colors.black38,fontSize: 14,fontWeight: FontWeight.bold),)),
                   ],
                 ),
                  Container(margin: EdgeInsets.zero,height: MediaQuery.of(context).size.height*.05,color: Colors.white),
                  Text("Email",style: TextStyle(color: Colors.black38,fontSize: 12,fontWeight: FontWeight.bold),),
                  SizedBox(height: 5,),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius:BorderRadius.all(Radius.circular(10)),

                    ),

                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      onFieldSubmitted: (value){
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Enter Email';
                        }
                        // else if(loginValdite['Message']=="Password is incorrect.");
                        return null;
                      },
                      //textDirection: lang=="ar"?TextDirection.rtl:TextDirection.ltr,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(right: 15,left: 15,top: 0,bottom: 0),
                        enabledBorder: new OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.black12)
                        ),
                        focusedBorder:  new OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.black12)
                        ),
                        focusedErrorBorder:new OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.red)
                        ),
                        errorBorder:new OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.red)
                        ),
                        hintText:"Email" ,
                        errorStyle: TextStyle(color: Colors.red,fontSize: 12),
                        hintStyle: TextStyle(color: Colors.black45,fontWeight: FontWeight.bold,fontSize: 12),
                      ),
                      controller: email,
                    ),
                  ),
                  SizedBox(height: 20,),
                  SizedBox(height: 25,),
                  GestureDetector(
                    onTap: (){
                      if(formKey.currentState!.validate()){
                        Navigator.push(context, GlobalFunction.route(Verification()));
                      }
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height*.065,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppTheme.primaryColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12.withOpacity(0.05),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: Offset(2, 2), // changes position of shadow
                          ),
                          BoxShadow(
                            color: Colors.black12.withOpacity(0.05),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: Offset(-2, -2), // changes position of shadow
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Text("Confirm",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.white),),
                    ),
                  ),
                  SizedBox(height: 25,),

                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
  }
}