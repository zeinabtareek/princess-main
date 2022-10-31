import 'package:flutter/material.dart';
import 'package:princess/Config/GlobalFunction.dart';
import 'package:princess/Provider/MainProvider.dart';
import 'package:provider/provider.dart';

import '../AppTheme.dart';
import 'OfferDetails.dart';

class Search extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _state();
  }
}
class _state extends State<Search>{
  TextEditingController search =new TextEditingController();
  @override
  Widget build(BuildContext context) {
    var h=MediaQuery.of(context).size.height;
    var w=MediaQuery.of(context).size.width;
    var mainProvider= Provider.of<MainProvider>(context, listen: true);
    return SafeArea(
      child: Scaffold(
          body: Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
              child: Column(
                children: [
                  Container(
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
                        GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.arrow_back_ios,color: Colors.white,size: 20,)),
                        Text("البحث",style: TextStyle(fontSize: 14,color: Colors.white,fontWeight: FontWeight.bold),),
                        Icon(Icons.arrow_back_ios,color: AppTheme.primaryColor,size: 20,),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    width: w*.9,
                    decoration: BoxDecoration(
                      borderRadius:BorderRadius.all(Radius.circular(20)),
                      border: Border.all(color: Colors.black12,width: 1)
                    ),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      onFieldSubmitted: (value){
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      onChanged: (val){
                        mainProvider.search(val);
                      },
                      validator: (value){
                        if(value!.isEmpty){
                          return '';
                        }
                        // else if(loginValdite['Message']=="Password is incorrect.");
                        return null;
                      },
                      style: TextStyle(color: Colors.black45,fontWeight: FontWeight.bold,fontSize: 12),
                      //textDirection: lang=="ar"?TextDirection.rtl:TextDirection.ltr,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(right: 15,left: 15,top: 0,bottom: 0),
                        enabledBorder: new OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.black12)
                        ),
                        focusedBorder:  new OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.black12)
                        ),
                        focusedErrorBorder:new OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.red)
                        ),
                        errorBorder:new OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.red)
                        ),
                        hintText:"ابحث باسم العرض" ,
                        suffixIcon: Icon(Icons.search),
                        errorStyle: TextStyle(color: Colors.red,fontSize: 12),
                        hintStyle: TextStyle(color: Colors.black45,fontWeight: FontWeight.bold,fontSize: 12),
                      ),
                      controller: search,
                    ),
                  ),
                  SizedBox(height: 10,),
                  Expanded(
                    child:mainProvider.searchList.length==0? Center(child: Text("لا يوجد عروض"),):GridView.builder(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * .03,
                          right: MediaQuery.of(context).size.width * .03),
                      primary: false,
                      shrinkWrap: true,
                      itemCount: mainProvider.searchList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 1 / 1.15),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: (){
                            Navigator.push(context, GlobalFunction.route(OfferDetails(offerModel: mainProvider.searchList[index],)));
                          },
                          child: Stack(
                            children: [
                              Container(
                                //color: Colors.red,
                              ),
                              Positioned(
                                  top:  MediaQuery.of(context).size.height*.03,
                                  right: MediaQuery.of(context).size.width*.05,
                                  child: Container(
                                    // height: MediaQuery.of(context).size.height*.28,
                                    width: MediaQuery.of(context).size.width*.4,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      //color: Colors.red,
                                    ),
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: Image.network(mainProvider.searchList[index].photo[0],
                                            height: MediaQuery.of(context).size.height*.22,
                                            width: MediaQuery.of(context).size.width*.4,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Positioned(
                                            child: Container(
                                              height: MediaQuery.of(context).size.height*.22,
                                              width: MediaQuery.of(context).size.width*.4,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  Text(mainProvider.searchList[index].name,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: AppTheme.primaryColor),),
                                                  SizedBox(height: 3,),
                                                  Image.asset("assets/images/tree.png",height: 9,color: Colors.white,),
                                                  Text(mainProvider.searchList[index].description,maxLines: 1,style: TextStyle(height: 1.4,fontSize: 12,color: Colors.white),),
                                                  SizedBox(height: 10,)
                                                ],
                                              ),
                                            ))
                                      ],
                                    ),
                                  )),
                              Positioned(
                                  top:  MediaQuery.of(context).size.height*.01,
                                  right: MediaQuery.of(context).size.width*.0,
                                  child: Container(
                                      height: MediaQuery.of(context).size.height*.07,width: MediaQuery.of(context).size.height*.07,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppTheme.primaryColor,
                                      ),
                                      alignment: Alignment.center,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(mainProvider.searchList[index].price,style: TextStyle(height: 1.0,fontWeight: FontWeight.bold,fontSize: 13,color: Colors.white),),
                                          Text("جم",style: TextStyle(height: 1.0,fontWeight: FontWeight.bold,fontSize: 13,color: Colors.white),),
                                        ],
                                      )
                                  ))
                            ],
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          )
      ),
    );
  }
}