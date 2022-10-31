import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:princess/Config/Config.dart';
import 'package:princess/Models/OfferModel.dart';
import 'package:princess/Provider/MainProvider.dart';
import 'package:provider/provider.dart';
import '../AppTheme.dart';

class Booking extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _state();
  }
}
class _state extends State<Booking>{
  int payment=1;
  var selecteDate;
  bool loading =true;
  bool loadingBtn=false;
  String message="";
/*  loadData()async{
    var mainProvider= Provider.of<MainProvider>(context, listen: false);
    await mainProvider.getOfferInfo(mainProvider.offer_id);
    setState(() {
      loading=false;
      selecteDate=DateTime.now();
    });
    print(selecteDate);
    print("-------------------------------------------------------");
  }*/
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selecteDate=DateTime.now().toString().substring(0,10);
    print(selecteDate);
    print("---------------------------------------");
   // loadData();
  }
  @override
  Widget build(BuildContext context) {
    var mainProvider= Provider.of<MainProvider>(context, listen: true);
    var h=MediaQuery.of(context).size.height;
    var w=MediaQuery.of(context).size.width;
   return WillPopScope(
     onWillPop: ()async{
       Navigator.pushNamedAndRemoveUntil(context, "/mainPage", (route) => false);
       return true;
     },
     child: SafeArea(child: Scaffold(
       body:Directionality(
         textDirection: TextDirection.rtl,
         child: SingleChildScrollView(
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
                     Text("تاكيد الحجز",style: TextStyle(fontSize: 14,color: Colors.white,fontWeight: FontWeight.bold),),
                     Icon(Icons.arrow_back_ios,color: AppTheme.primaryColor,size: 20,),
                   ],
                 ),
               ),
               ClipRRect(
                 borderRadius: BorderRadius.circular(0),
                 child: Image.network(mainProvider.offer.photo[0],
                   height: MediaQuery.of(context).size.height*.2,
                   width: w,
                   fit: BoxFit.cover,
                 ),
               ),
               SizedBox(height: 10,),
               Container(
                 width: w*.9,
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text(mainProvider.offer.name,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                     Container(
                       width: w * .9,
                       child: Text(mainProvider.offer.shortDescription,
                         style: TextStyle(fontSize: 12),),
                     ),
                     SizedBox(height: 5,),
                     Text("طريقة الدفع",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                     GestureDetector(
                       onTap: (){
                         setState(() {
                           payment=1;
                         });
                       },
                       child: Row(
                         children: [
                           Radio(value: 1, groupValue: payment, onChanged: (v){
                             setState(() {
                               payment=1;
                             });
                           }),
                           Text("اقل مقدم (${mainProvider.offer.minPrice} ج.م)",style: TextStyle(color: payment==1?AppTheme.primaryColor:Colors.black))
                         ],
                       ),
                     ),
                     GestureDetector(
                       onTap: (){
                         setState(() {
                           payment=0;
                         });
                       },
                       child: Row(
                         children: [
                           Radio(value: 0, groupValue: payment, onChanged: (v){
                             setState(() {
                               payment=0;
                             });
                           }),
                           Text("كامل القيمة (${mainProvider.offer.price} ج.م)",style: TextStyle(color: payment==0?AppTheme.primaryColor:Colors.black),)
                         ],
                       ),
                     ),
                     SizedBox(height: 5,),
                     Text("اختر ناريخ الحجز",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                     SizedBox(height: 5,),
                     DatePicker(
                       DateTime.now(),
                       initialSelectedDate: DateTime.now(),
                       height: 150,
                       monthTextStyle: TextStyle(fontSize: 12),
                       dayTextStyle:TextStyle(fontSize: 12),
                       selectionColor: Colors.black,
                       selectedTextColor: Colors.white,
                       onDateChange: (date) {
                         // New date selected
                         setState(() {
                           selecteDate = date;
                         });
                         print(selecteDate.toString().substring(0,10));
                         print("------------------------");
                       },
                     ),
                     SizedBox(height: MediaQuery.of(context).size.height*.03,),
                     message==""?SizedBox():
                     Container(
                       width: MediaQuery.of(context).size.width*.9,
                       padding: EdgeInsets.only(bottom: 20),
                       alignment: Alignment.center,
                       child: Text(message,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.red),),
                     ),
                     GestureDetector(
                       onTap: ()async{
                         setState(() {
                           loadingBtn=true;
                         });
                         await mainProvider.book(mainProvider.offer.id, payment==0?"full":"part", selecteDate.toString().substring(0,10));
                          if(mainProvider.bookInfo["success"]==true){
                            Navigator.pushNamedAndRemoveUntil(context, "/BookingSuccess", (route) => false);
                          }
                          else{

                            setState(() {
                              message=mainProvider.bookInfo["message"];
                              loadingBtn=false;
                            });

                          }
                       },
                       child: Container(
                         height: MediaQuery.of(context).size.height*.065,
                         width: MediaQuery.of(context).size.width*.9,
                         decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(10),
                             color: loadingBtn?Colors.black12:AppTheme.primaryColor
                         ),
                         alignment: Alignment.center,
                         child: Text("تأكيد الحجز",style: TextStyle(fontSize: 16,color: Colors.white),),
                       ),
                     ),
                     SizedBox(height: 30,)

                   ],
                 ),

               )
             ],
           ),
         ),
       ),
     )),
   );
  }

}