import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:princess/Config/GlobalFunction.dart';
import 'package:princess/Config/LocalStorage.dart';
import 'package:princess/Provider/AuthProvider.dart';
import 'package:princess/Views/ForgetPassword.dart';
import 'package:princess/main.dart';
import 'package:provider/provider.dart';

import '../AppTheme.dart';
import 'Register.dart';

class Login extends StatefulWidget{
  var type;
  Login({required this.type});
  @override
  State<StatefulWidget> createState() {
    return _state(type: this.type);
  }
}
class _state extends State<Login>{
  var type;
  _state({required this.type});
  String message="";
  bool loading=false;
  bool passVisibility = true;
  final formKey = GlobalKey<FormState>();
  TextEditingController username = new TextEditingController();
  TextEditingController password = new TextEditingController();
  FocusNode passwordNode=new FocusNode();
  @override
  Widget build(BuildContext context) {
    var authProvider= Provider.of<AuthProvider>(context, listen: true);
    return SafeArea(
      child: Scaffold(
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  SizedBox(  height: MediaQuery.of(context).size.height*.025,),
                  Image.asset("assets/images/logo.png",
                  height: MediaQuery.of(context).size.height*.17,
                  ),
                  Text("تسجيل الدخول",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
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
                          Text("رقم الهاتف",style: TextStyle(color: Colors.black38,fontSize: 12,fontWeight: FontWeight.bold),),
                          SizedBox(height: 5,),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius:BorderRadius.all(Radius.circular(10)),

                            ),

                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              onFieldSubmitted: (value){
                                FocusScope.of(context).requestFocus(passwordNode);
                              },
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'ادخل رقم الهاتف';
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
                                hintText:"رقم الهاتف" ,
                                errorStyle: TextStyle(color: Colors.red,fontSize: 12),
                                hintStyle: TextStyle(color: Colors.black45,fontWeight: FontWeight.bold,fontSize: 12),
                              ),
                              controller: username,
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text("كلمة المرور",style: TextStyle(color: Colors.black38,fontSize: 12,fontWeight: FontWeight.bold),),
                          SizedBox(height: 5,),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius:BorderRadius.all(Radius.circular(10)),

                            ),
                            child: TextFormField(

                              onFieldSubmitted: (value){
                                FocusScope.of(context).requestFocus(FocusNode());
                              },
                              focusNode: passwordNode,
                              obscureText: passVisibility,
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'ادخل كلمة المرور';
                                }
                                // else if(loginValdite['Message']=="Password is incorrect.");
                                return null;
                              },
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
                                hintText: "كلمة المرور",
                                errorStyle: TextStyle(color: Colors.red,fontSize: 12),
                                hintStyle: TextStyle(color: Colors.black45,fontWeight: FontWeight.bold,fontSize: 12),
                                suffixIcon:InkWell(
                                  child: Icon(passVisibility?Icons.visibility:Icons.visibility_off,color: Colors.black38,),
                                  onTap: (){
                                    setState(() {
                                      passVisibility=!passVisibility;
                                    });
                                  },
                                ) ,
                              ),
                              controller: password,
                            ),
                          ),
                      /*    SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(context, GlobalFunction.route(ForgetPassword()));
                                },
                                child: Text("هل نسيت كلمة المرور",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color:  Colors.yellow),),
                              )
                            ],
                          ),*/
                          SizedBox(height: 25,),
                          message==""?SizedBox():
                          Container(
                            width: MediaQuery.of(context).size.width*.8,
                            padding: EdgeInsets.only(bottom: 20),
                            alignment: Alignment.center,
                            child: Text(message,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.red),),
                          ),
                          GestureDetector(
                            onTap: ()async{
                              if(formKey.currentState!.validate()){
                                setState(() {
                                  loading=true;
                                });
                                await authProvider.LoginServices(username.text, password.text);
                                if(authProvider.connection==200){
                                  print(this.type);
                                  print("ssssssssssssssssssssssssssssssssssssssssssssss");
                                  LocalStorage.SaveData("Id", authProvider.LoginInfo["user"]["id"].toString());
                                  LocalStorage.SaveData("token", authProvider.LoginInfo["access_token"]);
                                  setState(() {
                                    MyApp.Id=authProvider.LoginInfo["user"]["id"];
                                  });
                                  if(this.type=="book")
                                  Navigator.pushNamedAndRemoveUntil(context, "/booking", (route) => false);
                                  else
                                    Navigator.pushNamedAndRemoveUntil(context, "/mainPage", (route) => false);
                                }
                                else{
                                  setState(() {
                                    loading=false;
                                    message=authProvider.LoginInfo["message"];
                                  });
                                }

                              }
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height*.065,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: loading?Colors.black12:AppTheme.primaryColor,
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
                              child: Text("تسجيل الدخول",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.white),),
                            ),
                          ),
                          SizedBox(height: 25,),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, GlobalFunction.route(Register()));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("ليس لديك حساب؟",style: TextStyle(color: Colors.black45,fontSize:12,fontWeight: FontWeight.bold),),
                                Text("انشاء حساب جديد",style: TextStyle(color: Colors.black45,fontSize: 12,fontWeight: FontWeight.bold),),
    ]) )])))]))))));}}