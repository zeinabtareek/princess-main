import 'package:flutter/material.dart';
import 'package:princess/AppTheme.dart';
import 'package:princess/Config/GlobalFunction.dart';
import 'package:princess/Provider/offer_provider.dart';
import 'package:princess/Views/OfferDetails.dart';
import 'package:princess/component/cashe_image.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class OfferScreen extends StatefulWidget {
  const OfferScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<OfferScreen> createState() => _OfferScreenState();
}

class _OfferScreenState extends State<OfferScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<OfferProvider>(context, listen: false).getOffers();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppTheme.primaryColor,
            centerTitle: true,
            title: Text("العروض",
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Consumer<OfferProvider>(
            builder: (context, provider, _) {
              return provider.loading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: AppTheme.primaryColor,
                      ),
                    )
                  : SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: SmartRefresher(
                        controller: provider.refreshController,
                        enablePullUp: true,
                        // enablePullDown: true,
                        onLoading: () async {
                          await provider.loadMore();
                          provider.refreshController.loadComplete();
                          provider.refreshController.requestLoading();
                        },
                        child: GridView.builder(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * .03,
                              right: MediaQuery.of(context).size.width * .03),
                          primary: false,
                          shrinkWrap: true,
                          itemCount: provider.offers.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                  childAspectRatio: 1 / 1.5),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                provider.parseHtmlString(index);
                                Navigator.push(
                                    context,
                                    GlobalFunction.route(OfferDetails(
                                      description: provider.content,
                                      offerModel: provider.offers[index],
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
                                                        image: provider
                                                            .offers[index]
                                                            .photo[0],
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            .22,
                                                        width: MediaQuery.of(
                                                                    context)
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
                                                        BorderRadius.circular(
                                                            10),
                                                    color:
                                                        AppTheme.primaryColor,
                                                  ),
                                                  alignment: Alignment.center,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        provider.offers[index]
                                                            .price,
                                                        style: TextStyle(
                                                            height: 1.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 13,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      Text(
                                                        "جم",
                                                        style: TextStyle(
                                                            height: 1.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 13,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ],
                                                  )))
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          .4,
                                      child: Text(
                                        provider.offers[index].name,
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
                        ),
                      ),
                    );
            },
          )),
    );
  }
}
