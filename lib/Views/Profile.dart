import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:princess/Config/LocalStorage.dart';
import 'package:princess/Provider/AuthProvider.dart';
import 'package:princess/Views/Login.dart';
import 'package:princess/main.dart';
import 'package:provider/provider.dart';

import '../AppTheme.dart';

class Profile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _state();
  }
}

class _state extends State<Profile> {
  TextEditingController name = new TextEditingController();

  // TextEditingController email = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  TextEditingController oldpassword = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController password_confirmation = new TextEditingController();
  bool loading = true;
  Map<String, dynamic> data = {};
  bool loadingBtn = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<AuthProvider>(context, listen: false).getUserInfo();
    loadData();
  }

  loadData() async {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (MyApp.Id != 0) {
      data = await authProvider.getUserInfo();
    }
    setState(() {
      loading = false;
      name.text = data["name"];
      // email.text = data["email"];
      phone.text = data["phone"];
      // password.text = data["password"];
      // oldpassword.text = data["oldpassword"];
      // password_confirmation.text = data["password_confirmation"];
    });
  }

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context, listen: true);
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return WillPopScope(
        onWillPop: () async {
          Navigator.pushNamedAndRemoveUntil(
              context, "/mainPage", (route) => false);
          return true;
        },
        child: Scaffold(
          body: MyApp.Id == 0
              ? Login(
                  type: "login",
                )
              : loading
                  ? Center(
                      child: CircularProgressIndicator.adaptive(),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          /*  Container(
                height: h*.065,
                width: w,
                color: AppTheme.primaryColor,
                alignment: Alignment.center,
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width*.05,
                    right: MediaQuery.of(context).size.width*.05
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.search,color:  AppTheme.primaryColor,),
                    Text("حسابي",style: TextStyle(fontSize: 14,color: Colors.white,fontWeight: FontWeight.bold),),
                    Icon(Icons.search,color: AppTheme.primaryColor,),
                  ],
                ),
              ),*/
                          Container(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * .05,
                                right: MediaQuery.of(context).size.width * .05),
                            child: Column(
                              children: [
                                /* SizedBox(height: MediaQuery.of(context).size.height*.01,),
                    Stack(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.width*.4,
                          width: MediaQuery.of(context).size.width*.4,
                        ),
                        Positioned(
                          left: MediaQuery.of(context).size.width*.05,
                          top: MediaQuery.of(context).size.width*.05,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(1000),
                            child: Image.asset("assets/images/img3.png",
                              height: MediaQuery.of(context).size.width*.33,
                              width: MediaQuery.of(context).size.width*.33,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Positioned(
                            left: MediaQuery.of(context).size.width*.3,
                            top: MediaQuery.of(context).size.width*.285,
                            child:Container(
                              child: Icon(Icons.add_a_photo,size: 30,),
                            )
                        )
                      ],
                    ),*/
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * .02,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: w,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              "assets/images/logo.png",
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .16,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .001,
                                      ),
                                      Text("الاسم : "),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      TextFormField(
                                        keyboardType: TextInputType.text,
                                        onFieldSubmitted: (value) {
                                          FocusScope.of(context)
                                              .requestFocus(FocusNode());
                                        },
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'ادخل الاسم';
                                          }
                                          return null;
                                        },
                                        //textDirection: lang=="ar"?TextDirection.rtl:TextDirection.ltr,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                              right: 15,
                                              left: 15,
                                              top: 0,
                                              bottom: 0),
                                          enabledBorder: new OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Colors.black12)),
                                          focusedBorder: new OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Colors.black12)),
                                          focusedErrorBorder:
                                              new OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: BorderSide(
                                                      color: Colors.black12)),
                                          errorBorder: new OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Colors.red)),
                                          hintText: "الاسم",
                                          errorStyle: TextStyle(fontSize: 0),
                                          hintStyle: TextStyle(
                                              color: Colors.black45,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        ),
                                        controller: name,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      // Text("البريد الالكتروني : "),
                                      // SizedBox(
                                      //   height: 5,
                                      // ),
                                      // TextFormField(
                                      //   keyboardType:
                                      //       TextInputType.emailAddress,
                                      //   onFieldSubmitted: (value) {
                                      //     FocusScope.of(context)
                                      //         .requestFocus(FocusNode());
                                      //   },
                                      //   validator: (value) {
                                      //     if (value!.isEmpty) {
                                      //       return 'ادخل البريد الالكتروني';
                                      //     }
                                      //     return null;
                                      //   },
                                      //   //textDirection: lang=="ar"?TextDirection.rtl:TextDirection.ltr,
                                      //   decoration: InputDecoration(
                                      //     contentPadding: EdgeInsets.only(
                                      //         right: 15,
                                      //         left: 15,
                                      //         top: 0,
                                      //         bottom: 0),
                                      //     enabledBorder: new OutlineInputBorder(
                                      //         borderRadius:
                                      //             BorderRadius.circular(10),
                                      //         borderSide: BorderSide(
                                      //             color: Colors.black12)),
                                      //     focusedBorder: new OutlineInputBorder(
                                      //         borderRadius:
                                      //             BorderRadius.circular(10),
                                      //         borderSide: BorderSide(
                                      //             color: Colors.black12)),
                                      //     focusedErrorBorder:
                                      //         new OutlineInputBorder(
                                      //             borderRadius:
                                      //                 BorderRadius.circular(10),
                                      //             borderSide: BorderSide(
                                      //                 color: Colors.black12)),
                                      //     errorBorder: new OutlineInputBorder(
                                      //         borderRadius:
                                      //             BorderRadius.circular(10),
                                      //         borderSide: BorderSide(
                                      //             color: Colors.red)),
                                      //     hintText: "البريد الالكتروني",
                                      //     errorStyle: TextStyle(fontSize: 0),
                                      //     hintStyle: TextStyle(
                                      //         color: Colors.black45,
                                      //         fontWeight: FontWeight.bold,
                                      //         fontSize: 12),
                                      //   ),
                                      //   controller: email,
                                      // ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text("رقم الهاتف : "),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      TextFormField(
                                        keyboardType: TextInputType.number,
                                        onFieldSubmitted: (value) {
                                          FocusScope.of(context)
                                              .requestFocus(FocusNode());
                                        },
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'ادخل رقم الهاتف';
                                          }
                                          return null;
                                        },
                                        //textDirection: lang=="ar"?TextDirection.rtl:TextDirection.ltr,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                              right: 15,
                                              left: 15,
                                              top: 0,
                                              bottom: 0),
                                          enabledBorder: new OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Colors.black12)),
                                          focusedBorder: new OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Colors.black12)),
                                          focusedErrorBorder:
                                              new OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: BorderSide(
                                                      color: Colors.black12)),
                                          errorBorder: new OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Colors.red)),
                                          hintText: "رقم الهاتف",
                                          errorStyle: TextStyle(fontSize: 0),
                                          hintStyle: TextStyle(
                                              color: Colors.black45,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        ),
                                        controller: phone,
                                      ),
                                      Text("الرقم السرى القديم : "),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      TextFormField(
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        onFieldSubmitted: (value) {
                                          FocusScope.of(context)
                                              .requestFocus(FocusNode());
                                        },
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'ادخل رقم السرى القديم';
                                          }
                                          return null;
                                        },
                                        //textDirection: lang=="ar"?TextDirection.rtl:TextDirection.ltr,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                              right: 15,
                                              left: 15,
                                              top: 0,
                                              bottom: 0),
                                          enabledBorder: new OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Colors.black12)),
                                          focusedBorder: new OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Colors.black12)),
                                          focusedErrorBorder:
                                              new OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: BorderSide(
                                                      color: Colors.black12)),
                                          errorBorder: new OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Colors.red)),
                                          hintText: "الرقم السرى القديم",
                                          errorStyle: TextStyle(fontSize: 0),
                                          hintStyle: TextStyle(
                                              color: Colors.black45,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        ),
                                        controller: oldpassword,
                                      ),
                                      Text("الرقم السرى الجديد : "),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      TextFormField(
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        onFieldSubmitted: (value) {
                                          FocusScope.of(context)
                                              .requestFocus(FocusNode());
                                        },
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'ادخل الرقم السرى الجديد ';
                                          }
                                          return null;
                                        },
                                        //textDirection: lang=="ar"?TextDirection.rtl:TextDirection.ltr,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                              right: 15,
                                              left: 15,
                                              top: 0,
                                              bottom: 0),
                                          enabledBorder: new OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Colors.black12)),
                                          focusedBorder: new OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Colors.black12)),
                                          focusedErrorBorder:
                                              new OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: BorderSide(
                                                      color: Colors.black12)),
                                          errorBorder: new OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Colors.red)),
                                          hintText: "الرقم السرى الجديد",
                                          errorStyle: TextStyle(fontSize: 0),
                                          hintStyle: TextStyle(
                                              color: Colors.black45,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        ),
                                        controller: password,
                                      ),
                                      Text(" اعد كتابه الرقم السرى الجديد : "),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      TextFormField(
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        onFieldSubmitted: (value) {
                                          FocusScope.of(context)
                                              .requestFocus(FocusNode());
                                        },
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'اعد كنابه الرقم السرى ';
                                          }
                                          return null;
                                        },
                                        //textDirection: lang=="ar"?TextDirection.rtl:TextDirection.ltr,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                              right: 15,
                                              left: 15,
                                              top: 0,
                                              bottom: 0),
                                          enabledBorder: new OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Colors.black12)),
                                          focusedBorder: new OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Colors.black12)),
                                          focusedErrorBorder:
                                              new OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: BorderSide(
                                                      color: Colors.black12)),
                                          errorBorder: new OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Colors.red)),
                                          hintText:
                                              "اعد كتابه الرقم السرى الجديد",
                                          errorStyle: TextStyle(fontSize: 0),
                                          hintStyle: TextStyle(
                                              color: Colors.black45,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        ),
                                        controller: password_confirmation,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * .05,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    setState(() {
                                      loadingBtn = true;
                                    });
                                    await authProvider.editProfile(
                                      name.text,
                                      phone.text,
                                    );
                                    await authProvider.editProfilePassword(
                                        password: password.text,
                                        oldpassword: oldpassword.text,
                                        password_confirmation:
                                            password_confirmation.text);
                                    FlutterToastr.show(
                                        authProvider.updateInfo["message"],
                                        context,
                                        duration: FlutterToastr.lengthShort,
                                        position: FlutterToastr.center);
                                    setState(() {
                                      loadingBtn = false;
                                    });
                                  },
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        .065,
                                    width:
                                        MediaQuery.of(context).size.width * .9,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: loadingBtn
                                            ? Colors.black12
                                            : AppTheme.primaryColor),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "حفظ",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * .02,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      MyApp.Id = 0;
                                    });
                                    LocalStorage.Logout();
                                    Navigator.pushNamedAndRemoveUntil(
                                        context, "/mainPage", (route) => false);
                                  },
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        .065,
                                    width:
                                        MediaQuery.of(context).size.width * .9,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.black38),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "تسجيل الخروج",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: Colors.white),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
        ));
  }
}
