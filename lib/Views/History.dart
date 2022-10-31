import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:princess/Models/OrderModel.dart';
import 'package:princess/Provider/MainProvider.dart';
import 'package:princess/Views/Login.dart';
import 'package:princess/component/cashe_image.dart';
import 'package:princess/main.dart';
import 'package:provider/provider.dart';

import '../AppTheme.dart';

class History extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _state();
  }
}

class _state extends State<History> {
  int selected = 0;
  bool loading = true;
  List<OrderModel> data = [];
  bool loadingBtn = false;

  loadData() async {
    var mainProvider = Provider.of<MainProvider>(context, listen: false);
    await mainProvider.getCurrentOrders();
    await mainProvider.getPastOrders();
    setState(() {
      loading = false;
      data = mainProvider.currentOrders;
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
    var mainProvider = Provider.of<MainProvider>(context, listen: true);
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
              ? Login(type: "login")
              : loading || loadingBtn
                  ? Center(
                      child: CircularProgressIndicator.adaptive(),
                    )
                  : Container(
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
                    Icon(Icons.search,color:AppTheme.primaryColor,),
                    Text("الحجوزات",style: TextStyle(fontSize: 14,color: Colors.white,fontWeight: FontWeight.bold),),
                    Icon(Icons.search,color: AppTheme.primaryColor,),
                  ],
                ),
              ),*/
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(left: w * .05, right: w * .05),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selected = 0;
                                      data = mainProvider.currentOrders;
                                    });
                                  },
                                  child: Container(
                                    width: w * .42,
                                    height: h * .06,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: selected == 0
                                            ? AppTheme.primaryColor
                                            : Colors.black54),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "الحالي",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selected = 1;
                                      data = mainProvider.pastOrders;
                                    });
                                  },
                                  child: Container(
                                    width: w * .42,
                                    height: h * .06,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: selected == 1
                                            ? AppTheme.primaryColor
                                            : Colors.black54),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "السابق",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          /*Expanded(child:  GridView.builder(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * .03,
                    right: MediaQuery.of(context).size.width * .03),
                primary: false,
                shrinkWrap: true,
                itemCount: 5,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 1 / 1.3),
                itemBuilder: (context, index) {
                  return  Stack(
                      children: [
                        Container(
                          //  color: Colors.red,
                        ),
                        Positioned(
                            top:  MediaQuery.of(context).size.height*.03,
                            right: MediaQuery.of(context).size.width*.05,
                            child: Container(
                              height: MediaQuery.of(context).size.height*.28,
                              width: MediaQuery.of(context).size.width*.4,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.black,
                              ),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset("assets/images/img4.png",
                                      height: MediaQuery.of(context).size.height*.28,
                                      width: MediaQuery.of(context).size.width*.4,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                      child: Container(
                                        height: MediaQuery.of(context).size.height*.28,
                                        width: MediaQuery.of(context).size.width*.4,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                           Container(
                                             width: MediaQuery.of(context).size.width*.4,
                                             color: Colors.black,
                                             child: Column(
                                               children: [
                                                 SizedBox(height: 8,),
                                                 Text("تاريخ الحجز: 22-2-2022",style: TextStyle(height: 1.4,fontSize: 10,fontWeight: FontWeight.bold,color: Colors.white),),
                                                 SizedBox(height: 0,),
                                                  Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text("تم التاكيد",style: TextStyle(height: 1.4,fontSize: 10,fontWeight: FontWeight.bold,color: AppTheme.primaryColor),),
                                                    SizedBox(width: 5,),
                                                    Icon(Icons.check_circle,color: AppTheme.primaryColor,size: 16,)
                                                  ],
                                                ),
                                                 SizedBox(height: 10,)
                                               ],
                                             ),
                                           )

                                          ],
                                        ),
                                      ))
                                ],
                              ),
                            )),
                        Positioned(
                            top:  MediaQuery.of(context).size.height*.0,
                            right: MediaQuery.of(context).size.width*.0,
                            child: Container(
                                height: MediaQuery.of(context).size.height*.08,width: MediaQuery.of(context).size.height*.08,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppTheme.primaryColor,
                                ),
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("45",style: TextStyle(height: 1.0,fontWeight: FontWeight.bold,fontSize: 15,color: Colors.white),),
                                    Text("جم",style: TextStyle(height: 1.0,fontWeight: FontWeight.bold,fontSize: 15,color: Colors.white),),
                                  ],
                                )
                            ))
                      ],
                    );
                },
              ))*/

                          Expanded(
                            child: data.length == 0
                                ? Center(
                                    child: Text("لا يوجد حجوزات لديك"),
                                  )
                                : ListView.builder(
                                    itemCount: data.length,
                                    padding: EdgeInsets.only(
                                        left: w * .05, right: w * .05),
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                          width: w * .9,
                                          margin:
                                              EdgeInsets.only(bottom: h * .02),
                                          height: h * .14,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: AppTheme.primaryColor,
                                                  width: .5)),
                                          child: Row(
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10)),
                                                child: LoadImage(
                                                  image: data[index].photo[0],
                                                  width: w * .3,
                                                  height: h * .14,
                                                ),
                                              ),
                                              SizedBox(
                                                width: w * .02 - 1,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: w * .58 - 10,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Flexible(
                                                          child: AutoSizeText(
                                                            data[index]
                                                                .offerName,
                                                            maxLines: 1,
                                                            style: TextStyle(
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                        AutoSizeText(
                                                          "${data[index].price} ج.م",
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color: AppTheme
                                                                  .primaryColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                      width: w * .58 - 5,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          SizedBox(
                                                            height: 8,
                                                          ),
                                                          Text(
                                                            "تاريخ الحجز :  ${data[index].date.toString().substring(0, 10)}",
                                                            style: TextStyle(
                                                                height: 1.4,
                                                                fontSize: 12),
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                  data[index].status ==
                                                                          "pending"
                                                                      ? "في انتظار تاكيد الحجز"
                                                                      : data[index].status ==
                                                                              "canceled"
                                                                          ? "في انتظار تاكيد الالغاء"
                                                                          : data[index].status ==
                                                                                  "accepte_canceled"
                                                                              ? "تم الالغاء"
                                                                              : data[index].status ==
                                                                                      "accepted"
                                                                                  ? "تمت الموافقه علي الطلب"
                                                                                  : data[index].status ==
                                                                                          "rejected"
                                                                                      ? "تمت رفض الطلب"
                                                                                      : data[index].status ==
                                                                                              "completed"
                                                                                          ? "تم الانتهاء من الطلب"
                                                                                          : "",
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      height:
                                                                          1.4,
                                                                      fontSize:
                                                                          11,
                                                                      color: data[index].status ==
                                                                              "canceled"
                                                                          ? Colors
                                                                              .red
                                                                          : Colors
                                                                              .green)),
                                                              selected == 0
                                                                  ? data[index]
                                                                              .status ==
                                                                          "canceled"
                                                                      ? SizedBox()
                                                                      : GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            confirmCancelBooking(context,
                                                                                data[index].id);
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            padding: EdgeInsets.only(
                                                                                left: 12.5,
                                                                                right: 12.5,
                                                                                top: 3,
                                                                                bottom: 3),
                                                                            decoration:
                                                                                BoxDecoration(borderRadius: BorderRadius.circular(8), color: AppTheme.primaryColor),
                                                                            alignment:
                                                                                Alignment.center,
                                                                            child:
                                                                                Text(
                                                                              "الغاء الحجز",
                                                                              style: TextStyle(height: 1.5, fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                                                                            ),
                                                                          ),
                                                                        )
                                                                  : SizedBox()
                                                            ],
                                                          )
                                                        ],
                                                      )),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                          )
                        ],
                      ),
                    )),
    );
  }

  confirmCancelBooking(BuildContext context, var id) {
    var mainProvider = Provider.of<MainProvider>(context, listen: false);
    showDialog(
        context: context,
        builder: (BuildContext context) => Dialog(
              child: Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                height: 120.0,
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
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  "هل تريد الغاء هذا الحجز؟",
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
                                      color: loadingBtn
                                          ? Colors.black12
                                          : AppTheme.primaryColor),
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
                                  setState(() {
                                    loadingBtn = true;
                                  });
                                  Navigator.pop(context);
                                  await mainProvider.cancelOrder(id);
                                  await mainProvider.getCurrentOrders();
                                  await mainProvider.getPastOrders();
                                  setState(() {
                                    data = mainProvider.currentOrders;
                                  });

                                  setState(() {
                                    loadingBtn = false;
                                  });
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
