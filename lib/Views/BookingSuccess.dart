import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:princess/AppTheme.dart';
import 'package:princess/Provider/MainProvider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class BookingSuccess extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _state();
  }
}
class _state extends State<BookingSuccess>{

  @override
  Widget build(BuildContext context) {
    var mainProvider= Provider.of<MainProvider>(context, listen: true);
   return WillPopScope(
     onWillPop: ()async{
       Navigator.pushNamedAndRemoveUntil(context, "/mainPage", (route) => false);
       return true;
     },
     child: SafeArea(
       child: Scaffold(
         body:Container(
           child: Center(
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.center,
               children: [
                 SizedBox(height: MediaQuery.of(context).size.height*.15,),
                 Icon(Icons.check_circle_outline,color: AppTheme.primaryColor,size: 150,),
                 SizedBox(height: 15,),
                 Text("تم الحجز بنجاح رقم الطلب هو ( ${mainProvider.bookInfo["data"]["data"]["order_no"]??""}) برجاء تحويل القيمة المستحقه عبر فوادفون كاش الي رقم ",textAlign: TextAlign.center,),
                 Text(mainProvider.bookInfo["data"]["data"]["phone_cach"]??"",style: TextStyle(color: AppTheme.primaryColor,fontSize: 14,fontWeight: FontWeight.bold),),
                 Text("والتواصل معنا عن طريق صفحتنا"),
                 GestureDetector(
                   onTap: (){
                     ShareUrl(mainProvider.bookInfo["data"]["data"]["facebook"]);
                   },
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Image.asset("assets/images/facebook.png",width: 22,),
                       SizedBox(width: 5,),
                       Text("برنسيسة",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.blue,decoration: TextDecoration.underline),)
                     ],
                   ),
                 ),
                 SizedBox(height: MediaQuery.of(context).size.height*.03,),
                 GestureDetector(
                   onTap: (){
                     Navigator.pushNamedAndRemoveUntil(context, "/mainPage", (route) => false);
                   },
                   child: Container(
                     height: MediaQuery.of(context).size.height*.065,
                     width: MediaQuery.of(context).size.width*.9,
                     margin: EdgeInsets.only(
                       left:MediaQuery.of(context).size.width*.1,
                       right: MediaQuery.of(context).size.width*.1,
                     ),
                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(10),
                         color: AppTheme.primaryColor
                     ),
                     alignment: Alignment.center,
                     child: Text("موافق",style: TextStyle(fontSize: 16,color: Colors.white),),
                   ),
                 )

               ],
             )
           ),
         ) ,
       ),
     ),
   );
  }
  ShareUrl(String url)async{
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
