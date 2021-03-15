import 'dart:ui';
import 'package:customerapp/features/location/presentation/pages/location-page.dart';
import 'package:customerapp/features/locationList/presentation/bloc/locations-bloc.dart';
import 'package:customerapp/features/locationList/presentation/bloc/locations-events.dart';
import 'package:customerapp/features/locationList/presentation/bloc/locations-state.dart';
import 'package:customerapp/features/request/data/models/location.dart';
import 'package:customerapp/features/share/loading-dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:customerapp/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../home.dart';

class LocationsWidget extends StatefulWidget {
  static const routeName = 'LocationsWidget';

  LocationsWidgetState createState() => LocationsWidgetState();
}

class LocationsWidgetState extends State<LocationsWidget> {
  LocationsBloc _bloc = LocationsBloc(BaseLocationsState());
  List<LocationModel>  allLocations = [];





  bool _clicked = false;

  @override
  void initState() {
    _bloc.add(GetLocationsDataEvent());
    super.initState();
  }

//  Future<void> initPlatformState() async {
//    await BackgroundLocator.initialize();
//  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  _launchCaller(phone) async {
    final url = "tel:$phone";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(translator.translate('locations'),style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400)),
         centerTitle: true,
      ),
//     backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
          Navigator.pushNamed(context, LocationWidget.routeName);

        },

        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Container(
          padding: EdgeInsets.only(left: 10,right: 10, top:20),
          child: BlocConsumer(
           cubit: _bloc,
               builder: (context, state) {
    return (allLocations.isNotEmpty) ? ListView.builder(
    itemBuilder: (ctx, index) {
    final item = allLocations[index];
    item.governorate = item.governorate.replaceAll("\n", " ");
    item.city = item.city.replaceAll("\n", " ");
    return  Container(
      child: Stack(
          children: <Widget>[
            Card(
              elevation: 4,
              margin: EdgeInsets.symmetric(horizontal: 5.0,vertical: 15.0),
              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.0,vertical: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex:1,
                              child: Text('${item.name}',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w600,)),
                            ),
                          ]
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.home,color: Colors.grey,size: 25,),
                            SizedBox(width: 5,),
                            Text('${item.governorate} - ${item.city}',style: TextStyle(fontFamily: FONT_FAMILY)),
                          ]
                      ),
                      SizedBox(height: 3,),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.place,color: Colors.orange,size: 25,),
                            SizedBox(width: 5,),
                            Text('${item.detailedAddress}',style: TextStyle(fontFamily: FONT_FAMILY)),
                          ]
                      ),
                      SizedBox(height: 3,),
                  Row( mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                          flex:2,
                          child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.person,color: Colors.grey,size: 25,),
                            SizedBox(width: 2,),
                            Text('${item.contactName}',style: TextStyle(fontFamily: FONT_FAMILY)),
                          ]
                      ),),
//                      SizedBox(height: 3,),
                      Expanded(
                          flex:1,
                          child: Row(

                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                              InkWell(
                              onTap: () {
                                _launchCaller(item.contactNumber);
                              },
                                  child: RotatedBox(
                              quarterTurns: (translator.currentLanguage == 'en' ) ? 0 : 3,
                              child:  Icon(Icons.call,color: Colors.blue,size: 25,)))
                            ,
                            SizedBox(width: 2,),
                            Text('${item.contactNumber}',style: TextStyle(fontFamily: FONT_FAMILY, fontSize: 14)),
                          ]
                      )),
                      ])
                    ],)


              ),

            ),
            Align( child: Container(

              margin: EdgeInsets.only(top: 20,left: 15,right: 15),
              width: 30,
              height: 30,
//              decoration: BoxDecoration(
//                  borderRadius: BorderRadius.all( Radius.circular(50)),
////                  border: Border.all(
////                      color: Colors.orange,
////                      width: 3
////                  ),
//                  color: (item.active) ? Colors.green : Colors.grey
//              ),

              child: (item.active) ?  Icon(Icons.done_all ,color: Colors.green,size: 25,) :  Icon(Icons.block ,color: Colors.red,size: 25,),


            ) ,
            alignment:(translator.currentLanguage == 'en' ) ?  Alignment.topRight :  Alignment.topLeft,)
           ,
          ]),
    );
    } ,
    itemCount: allLocations.length ,

    ): Column(
      children: <Widget>[
        SizedBox( height: 20,),
        Text( 'لا توجد بيانات الان',  style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400),),
        SizedBox( height: 20,),
        Container( height: 300, child: SvgPicture.asset("assets/images/empty1.svg",)),
      ],
    );
                },
                listener: (context, state) {
                  if (state is LocationsSuccessState) {
                   print(state.locationsData.data);
                   setState(() {
                     allLocations = state.locationsData.data;
                   });
                  }
                  if (state is LocationsLoadingState ) loadingAlertDialog(context);
                  if (state is LocationsSuccessState) Navigator.of(context).pop();

                }
        )
      ),
    );
  }
}
