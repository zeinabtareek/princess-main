import 'package:flutter/cupertino.dart';
import 'package:princess/Views/Booking.dart';
import 'package:princess/Views/BookingSuccess.dart';
import 'package:princess/Views/Home.dart';
import 'package:princess/Views/Splash.dart';
class Routes{
  static Map <String,WidgetBuilder> routes={
    '/splash':(BuildContext context)=>new Splash(),
    '/mainPage':(BuildContext context)=>new HomePage(index: 2),
    '/booking2':(BuildContext context)=>new HomePage(index: 1),
      '/booking':(BuildContext context)=>new Booking(),
    '/BookingSuccess':(BuildContext context)=>new BookingSuccess(),
  };
}