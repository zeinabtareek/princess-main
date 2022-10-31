import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:princess/Config/LocalStorage.dart';
import 'package:princess/Provider/AuthProvider.dart';
import 'package:provider/provider.dart';

import '../AppTheme.dart';
import '../main.dart';

class Register extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _state();
  }
}

class _state extends State<Register> {
  TextEditingController phone = new TextEditingController();
  TextEditingController name = new TextEditingController();

  // TextEditingController email =new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController password2 = new TextEditingController();
  FocusNode passwordNode = new FocusNode();
  FocusNode password2Node = new FocusNode();
  FocusNode phoneNode = new FocusNode();
  FocusNode emailNode = new FocusNode();
  final formKey = GlobalKey<FormState>();
  bool ishidden = true;
  bool ishidden2 = true;
  String message = "";
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context, listen: true);
    return SafeArea(
      child: Scaffold(
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
              child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .025,
              ),
              Image.asset(
                "assets/images/logo.png",
                height: MediaQuery.of(context).size.height * .2,
              ),
              Text(
                "انشاء حساب جديد",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Form(
                key: formKey,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * .05,
                    right: MediaQuery.of(context).size.width * .05,
                    top: MediaQuery.of(context).size.height * .03,
                    bottom: MediaQuery.of(context).size.height * .03,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "الاسم :",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * .9,
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                          controller: name,
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).requestFocus(phoneNode);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'ادخل الاسم';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              errorStyle: TextStyle(fontSize: 12),
                              enabledBorder: new OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: Colors.black12)),
                              focusedBorder: new OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: Colors.black12)),
                              focusedErrorBorder: new OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.red)),
                              errorBorder: new OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.red)),
                              contentPadding: EdgeInsets.only(
                                  left: 10, right: 10, top: 10, bottom: 10),
                              hintText: "الاسم",
                              hintStyle: TextStyle(
                                  color: Colors.black54, fontSize: 12),
                              fillColor: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .015,
                      ),
                      Text(
                        "رقم الهاتف",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * .9,
                        child: TextFormField(
                          keyboardType: TextInputType.phone,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                          controller: phone,
                          focusNode: phoneNode,
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).requestFocus(emailNode);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'رقم الهاتف';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              errorStyle: TextStyle(fontSize: 12),
                              enabledBorder: new OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: Colors.black12)),
                              focusedBorder: new OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: Colors.black12)),
                              focusedErrorBorder: new OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.red)),
                              errorBorder: new OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.red)),
                              contentPadding: EdgeInsets.only(
                                  left: 10, right: 10, top: 10, bottom: 10),
                              hintText: "رقم الهاتف",
                              hintStyle: TextStyle(
                                  color: Colors.black54, fontSize: 12),
                              fillColor: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .015,
                      ),
                      // Text("البريد الالكتروني",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.black),),
                      // SizedBox(height: 7,),
                      // Container(
                      //   width: MediaQuery.of(context).size.width*.9,
                      //   child: TextFormField(
                      //     focusNode: emailNode,
                      //     keyboardType: TextInputType.emailAddress,
                      //     style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.bold),
                      //     controller: email,
                      //     onFieldSubmitted: (value){
                      //       FocusScope.of(context).requestFocus(passwordNode);
                      //     },
                      //     validator: (value){
                      //       if(value!.isEmpty){
                      //         return 'ادخل البريد الالكتروني';
                      //       }
                      //       return null;
                      //     },
                      //     decoration: InputDecoration(
                      //         errorStyle: TextStyle(fontSize: 12),
                      //         enabledBorder: new OutlineInputBorder(
                      //             borderRadius: BorderRadius.circular(10),
                      //             borderSide: BorderSide(color: Colors.black12)
                      //         ),
                      //         focusedBorder:  new OutlineInputBorder(
                      //             borderRadius: BorderRadius.circular(10),
                      //             borderSide: BorderSide(color: Colors.black12)
                      //         ),
                      //         focusedErrorBorder:new OutlineInputBorder(
                      //             borderRadius: BorderRadius.circular(10),
                      //             borderSide: BorderSide(color: Colors.red)
                      //         ),
                      //         errorBorder:new OutlineInputBorder(
                      //             borderRadius: BorderRadius.circular(10),
                      //             borderSide: BorderSide(color: Colors.red)
                      //         ),
                      //
                      //         contentPadding: EdgeInsets.only(
                      //             left: 10,right: 10,top: 10,bottom: 10
                      //         ),
                      //         hintText: "البريد الالكتروني",
                      //         hintStyle: TextStyle(color: Colors.black54,fontSize: 12),
                      //         fillColor: Colors.white
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(height: MediaQuery.of(context).size.height*.015,),
                      Text(
                        "كلمة المرور",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * .9,
                        child: TextFormField(
                          focusNode: passwordNode,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                          controller: password,
                          obscureText: ishidden,
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).requestFocus(password2Node);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'ادخل كلمة المرور';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              errorStyle: TextStyle(fontSize: 12),
                              enabledBorder: new OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: Colors.black12)),
                              focusedBorder: new OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: Colors.black12)),
                              focusedErrorBorder: new OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.red)),
                              errorBorder: new OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.red)),
                              contentPadding: EdgeInsets.only(
                                  left: 10, right: 10, top: 10, bottom: 10),
                              suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      ishidden = !ishidden;
                                    });
                                  },
                                  child: Icon(
                                    ishidden
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    color: Colors.black54,
                                  )),
                              hintText: "كلمة المرور",
                              hintStyle: TextStyle(
                                  color: Colors.black54, fontSize: 12),
                              fillColor: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .015,
                      ),
                      Text(
                        "تاكيد كلمة المرور",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * .9,
                        child: TextFormField(
                          focusNode: password2Node,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                          controller: password2,
                          obscureText: ishidden2,
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).requestFocus(FocusNode());
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'ادخل تاكيد كلمة المرور';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              errorStyle: TextStyle(fontSize: 12),
                              enabledBorder: new OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: Colors.black12)),
                              focusedBorder: new OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: Colors.black12)),
                              focusedErrorBorder: new OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.red)),
                              errorBorder: new OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.red)),
                              contentPadding: EdgeInsets.only(
                                  left: 10, right: 10, top: 10, bottom: 10),
                              suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      ishidden2 = !ishidden2;
                                    });
                                  },
                                  child: Icon(
                                    ishidden2
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    color: Colors.black54,
                                  )),
                              hintText: "تاكيد كلمة المرور",
                              hintStyle: TextStyle(
                                  color: Colors.black54, fontSize: 12),
                              fillColor: Colors.white),
                        ),
                      ),

                      SizedBox(
                        height: MediaQuery.of(context).size.height * .03,
                      ),
                      message == ""
                          ? SizedBox()
                          : Container(
                              width: MediaQuery.of(context).size.width * .8,
                              padding: EdgeInsets.only(bottom: 20),
                              alignment: Alignment.center,
                              child: Text(
                                message,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              ),
                            ),
                      GestureDetector(
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            await authProvider.RegisterServices(name.text,
                                phone.text, password.text, password2.text);
                            if (authProvider.connection == 200) {
                              LocalStorage.SaveData(
                                  "Id",
                                  authProvider.RegisterInfo["user"]["id"]
                                      .toString());
                              LocalStorage.SaveData("token",
                                  authProvider.RegisterInfo["access_token"]);
                              setState(() {
                                MyApp.Id =
                                    authProvider.RegisterInfo["user"]["id"];
                              });
                              Navigator.pushNamedAndRemoveUntil(
                                  context, "/mainPage", (route) => false);
                            } else {
                              setState(() {
                                loading = false;
                                message = authProvider.RegisterInfo["message"];
                              });
                            }
                          }
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * .065,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: loading
                                ? Colors.black12
                                : AppTheme.primaryColor,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12.withOpacity(0.05),
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset:
                                    Offset(2, 2), // changes position of shadow
                              ),
                              BoxShadow(
                                color: Colors.black12.withOpacity(0.05),
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: Offset(
                                    -2, -2), // changes position of shadow
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "تسجيل",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .01,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * .06,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "لديك حساب مسبقا ؟ تسجيل الدخول",
                                style: TextStyle(
                                    color: Colors.black45, fontSize: 14),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .05,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .05,
              ),
            ],
          )),
        ),
      ),
    );
  }
}
