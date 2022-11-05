import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:princess/Config/GlobalFunction.dart';
import 'package:princess/Models/OfferModel.dart';
import 'package:princess/Provider/MainProvider.dart';
import 'package:princess/Views/Login.dart';
import 'package:princess/component/cashe_image.dart';
import 'package:princess/main.dart';
import 'package:provider/provider.dart';

import '../AppTheme.dart';
import 'Booking.dart';

class OfferDetails extends StatefulWidget {
  OfferModel offerModel;

  OfferDetails({required this.offerModel, });

  @override
  State<StatefulWidget> createState() {
    return _state(offerModel: this.offerModel);
  }
}

class _state extends State<OfferDetails> {
  OfferModel offerModel;

  _state({required this.offerModel});

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mainProvider = Provider.of<MainProvider>(context, listen: true);
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: h * .065,
                width: w,
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
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 20,
                        )),
                    Text(
                      offerModel.name,
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Icon(
                      Icons.arrow_back_ios,
                      color: AppTheme.primaryColor,
                      size: 20,
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * .27,
                width: w,
                child: CarouselSlider.builder(
                  itemCount: offerModel.photo.length,
                  itemBuilder: (BuildContext context, int itemIndex,
                          int pageViewIndex) =>
                      ClipRRect(
                    borderRadius: BorderRadius.circular(0),
                    child: LoadImage(
                      image: offerModel.photo[itemIndex],
                      height: MediaQuery.of(context).size.height * .27,
                      width: w,
                    ),
                  ),
                  options: CarouselOptions(
                    autoPlay: true,
                    autoPlayAnimationDuration: Duration(milliseconds: 300),
                    enlargeCenterPage: true,
                    viewportFraction: 1,
                    aspectRatio: .7,
                    initialPage: 2,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: w * .9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      offerModel.name,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Container(
                        width: w * .9,
                        child: Html(
                          data: offerModel.description,
                        )
                        // Text(
                        //   widget.description!,
                        //   style: TextStyle(fontSize: 12),
                        // ),
                        ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.monetization_on,
                          color: AppTheme.primaryColor,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "كامل قيمة العرض :   ${offerModel.price}  ج.م",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.monetization_on,
                          color: AppTheme.primaryColor,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          " اقل مقدم للعرض :    ${offerModel.minPrice} ج.م",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .04,
                    ),
                    GestureDetector(
                      onTap: () {
                        mainProvider.setOffer(this.offerModel);
                        print(
                            "--------------------------------------------------");
                        if (MyApp.Id != 0)
                          Navigator.push(
                              context, GlobalFunction.route(Booking()));
                        else
                          Navigator.push(context,
                              GlobalFunction.route(Login(type: "book")));
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * .065,
                        width: MediaQuery.of(context).size.width * .9,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppTheme.primaryColor),
                        alignment: Alignment.center,
                        child: Text(
                          "حجز الان",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .04,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
