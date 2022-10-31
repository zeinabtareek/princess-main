import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:princess/Provider/MainProvider.dart';
import 'package:provider/provider.dart';
import 'package:geocoding/geocoding.dart';
import '../AppTheme.dart';

class ContactUs extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
   return _state();
  }
}
class _state extends State<ContactUs>{
  double lat=30.0130557;
  double lang=31.2088526;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    makeMarker();
  }
  @override
  Widget build(BuildContext context) {
    var mainProvider= Provider.of<MainProvider>(context, listen: true);
    return Scaffold(
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height*.1,
                width: MediaQuery.of(context).size.width,
                color: AppTheme.primaryColor,
                alignment: Alignment.center,
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height*.03,
                    left: MediaQuery.of(context).size.width*.05-5,
                    right: MediaQuery.of(context).size.width*.05-5
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: (){
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Icon(Icons.arrow_forward_ios_rounded,color: AppTheme.primaryColor,size: 20,),
                        )),
                    Text("تواصل معنا",style: TextStyle(fontSize: 14,color: Colors.white,fontWeight: FontWeight.bold),),
                    GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        }
                        ,child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Icon(Icons.arrow_forward_ios_rounded,color: Colors.white,size: 20,),
                    )),
                  ],
                ),
              ),
              SizedBox(height: 15,),
              Expanded(child: SingleChildScrollView(
               child: Container(
                 width: MediaQuery.of(context).size.width*.9,
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     SizedBox(height: 10,),
                     Container(
                       width: MediaQuery.of(context).size.width,
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                          Image.asset("assets/images/logo.png",
                            width: MediaQuery.of(context).size.width*.32,
                          )
                         ],
                       ),
                     ),
                     SizedBox(height: 20,),
                     Row(
                       children: [
                         SizedBox(width: 10,),
                         Icon(Icons.phone,size: 20,color: AppTheme.primaryColor,),
                         SizedBox(width: 10,),
                         Text(mainProvider.AppInfo["phones"],style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),)
                       ],
                     ),
                     SizedBox(height: 5,),
                     Row(
                       children: [
                         SizedBox(width: 10,),
                         Icon(Icons.email,size: 20,color: AppTheme.primaryColor,),
                         SizedBox(width: 10,),
                         Text(mainProvider.AppInfo["email"],style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),)
                       ],
                     ),
                     SizedBox(height: 5,),
                     Row(
                       children: [
                         SizedBox(width: 10,),
                         Icon(Icons.location_on,size: 20,color: AppTheme.primaryColor,),
                         SizedBox(width: 10,),
                         Text(mainProvider.AppInfo["address"],style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),)
                       ],
                     ),
                     SizedBox(height: 20,),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppTheme.primaryColor,width: 1)
                        ),
                        height: MediaQuery.of(context).size.height*.45,width: MediaQuery.of(context).size.width,
                        child:   ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: GoogleMap(
                            mapType: MapType.normal,
                            onMapCreated: (GoogleMapController controller) {
                              _controller.complete(controller);
                            },
                            initialCameraPosition: CameraPosition(
                              // bearing: 30,
                                target: LatLng(lat,lang),
                                //tilt: 45,
                                zoom: 17
                            ),
                            compassEnabled: true,
                            markers: listMarkers,
                          )
                        ),
                      )
                   ],
                 ),
               ),
              )),

            ],
          ),
        )
    );
  }
  Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> listMarkers = {};
  makeMarker() async{
    listMarkers.add(Marker(
        markerId: MarkerId("1"),
        draggable: false,
        position: LatLng(lat, lang),
        infoWindow: InfoWindow(title: "موقعك الفرع"),
        icon: BitmapDescriptor.defaultMarker
    ));
  }

}