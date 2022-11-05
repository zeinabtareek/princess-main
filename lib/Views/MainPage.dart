import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:princess/AppTheme.dart';
import 'package:princess/Config/GlobalFunction.dart';
import 'package:princess/Provider/MainProvider.dart';
import 'package:princess/Views/OfferDetails.dart';
import 'package:princess/Views/offer_screen.dart';
import 'package:princess/component/cashe_image.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _state();
  }
}

class _state extends State<MainPage> {
  bool loading = true;

  loadData() async {
    var mainProvider = Provider.of<MainProvider>(context, listen: false);
    await mainProvider.getOffers();
    await mainProvider.getAppInfo();
    loading = false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    var mainProvider = Provider.of<MainProvider>(context, listen: true);
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        confirmCloseApp(context);
        return true;
      },
      child: Scaffold(
        body: loading
            ? Center(
                child: CircularProgressIndicator.adaptive(),
              )
            : SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * .4,
                            width: MediaQuery.of(context).size.width,
                          ),
                          Image.asset(
                            "assets/images/banner.png",
                            height: MediaQuery.of(context).size.height * .2,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                              top: MediaQuery.of(context).size.height * .16,
                              right: MediaQuery.of(context).size.width * .05,
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * .24,
                                width: MediaQuery.of(context).size.width * .9,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: Colors.black12.withOpacity(0.05),
                                      width: 1),
                                  color: Colors.white,
                                  /*   boxShadow: [
                         BoxShadow(
                           color: Colors.black12.withOpacity(0.03),
                           spreadRadius: 2,
                           blurRadius: 2,
                           offset: Offset(2, 2), // changes position of shadow
                         ),
                         BoxShadow(
                           color: Colors.black12.withOpacity(0.03),
                           spreadRadius: 2,
                           blurRadius: 2,
                           offset: Offset(-2, -2), // changes position of shadow
                         ),
                       ],*/
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .01),
                                    Image.asset(
                                      "assets/images/logo.png",
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .07,
                                    ),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .005),
                                    Text(
                                      "احدث العروض",
                                      style: TextStyle(
                                          fontSize: 13,
                                          height: 1.4,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .005),
                                    Image.asset("assets/images/tree.png",
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .02),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .00),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Text(
                                        "حمامات شرقية ملكى مغربى كليوباترا تركى ساونا جاكوزى مغطس بخار تكييس باديكير مانيكير برافين سويت واكس نتوياج مساج بجميع انواعه للسيدات فقط",
                                        textAlign: TextAlign.center,
                                        maxLines: 3,
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500,
                                          height: 1.4,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              " العروض",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => OfferScreen()));
                              },
                              child: Text(
                                "عرض الكل ",
                                style: TextStyle(
                                    fontSize: 12,
                                    decoration: TextDecoration.underline,
                                    decorationThickness: 2,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.primaryColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GridView.builder(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * .03,
                            right: MediaQuery.of(context).size.width * .03),
                        primary: false,
                        shrinkWrap: true,
                        itemCount: mainProvider.offers.length ~/ 2,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 1 / 1.5),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              mainProvider.parseHtmlString(index);
                              Navigator.push(
                                  context,
                                  GlobalFunction.route(OfferDetails(
                                    offerModel: mainProvider.offers[index],
                                  )));
                            },
                            child: Material(
                              child: Column(
                                children: [
                                  AspectRatio(
                                    aspectRatio: 1 / 1.15,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .03,
                                            right: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .05,
                                            child: Container(
                                              // height: MediaQuery.of(context).size.height*.28,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .4,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                //color: Colors.red,
                                              ),
                                              child: Stack(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: LoadImage(
                                                      image: mainProvider
                                                          .offers[index]
                                                          .photo[0],
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              .22,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              .4,
                                                    ),
                                                  ),
                                                  Positioned(
                                                      child: Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            .22,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            .4,
                                                    child: SizedBox(
                                                      height: 10,
                                                    ),
                                                  ))
                                                ],
                                              ),
                                            )),
                                        Positioned(
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .01,
                                            right: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .0,
                                            child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    .07,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    .07,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: AppTheme.primaryColor,
                                                ),
                                                alignment: Alignment.center,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      mainProvider
                                                          .offers[index].price,
                                                      style: TextStyle(
                                                          height: 1.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 13,
                                                          color: Colors.white),
                                                    ),
                                                    Text(
                                                      "جم",
                                                      style: TextStyle(
                                                          height: 1.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 13,
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                )))
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * .4,
                                    child: Text(
                                      mainProvider.offers[index].name,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: AppTheme.primaryColor),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )
                      /*  Expanded(
                child: ListView.builder(
                    itemCount: 5,
                    padding: EdgeInsets.only(
                      left: w*.05,right: w*.05
                    ),
                    itemBuilder: (context,index){
                  return  GestureDetector(
                    onTap: (){
                      Navigator.push(context, GlobalFunction.route(OfferDetails()));
                    },
                    child: Container(
                      width: w*.9,
                      margin: EdgeInsets.only(
                        bottom: h*.02
                      ),
                      height: h*.14,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppTheme.primaryColor,width: .5)
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10)
                            ),
                            child: Image.asset("assets/images/img2.png",
                              fit: BoxFit.fill,
                              width: w*.3,
                              height: h*.14,
                            ),
                          ),
                          SizedBox(width: w*.02-1,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: w*.58-10,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("اسم العرض",style:TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
                                    Text("15 ج.م",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),)
                                  ],
                                ),
                              ),
                              Container(
                                width: w*.58-5,
                                child: Text(" وصف بسيط عن العرض وصف العرض وصف العرض وصف بسيط عن العرض وصف العرض وصف العرض وصف بسيط عن العرض وصف العرض وصف العرض",
                                  style: TextStyle(fontSize: 10,height: 1.4),maxLines: 3,),
                              ),

                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }),
              )*/
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  confirmCloseApp(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => Dialog(
              child: Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                height: 150.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(0)),
                    border: Border.all(color: Colors.black12, width: 2.0),
                    color: Colors.white),
                child: Stack(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                Icon(
                                  Icons.warning_amber_sharp,
                                  size: 40,
                                  color: AppTheme.primaryColor,
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  "هل تريد اغلاق التطبيق؟",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                                // Text("${title}",textAlign: TextAlign.center,)
                              ],
                            )),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: Colors.black38, width: 1.0),
                                      color: Colors.white),
                                  height:
                                      MediaQuery.of(context).size.height * .045,
                                  width:
                                      MediaQuery.of(context).size.width * .32,
                                  alignment: Alignment.center,
                                  child: Text(
                                    "الغاء",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                              GestureDetector(
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: AppTheme.primaryColor),
                                  height:
                                      MediaQuery.of(context).size.height * .045,
                                  width:
                                      MediaQuery.of(context).size.width * .32,
                                  alignment: Alignment.center,
                                  child: Text(
                                    "تاكيد",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  ),
                                ),
                                onTap: () async {
                                  SystemNavigator.pop();
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ));
  }
}
