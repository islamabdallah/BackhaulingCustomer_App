import 'dart:ui';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:customerapp/core/constants.dart';
import 'package:customerapp/core/services/local_storage/local_storage_service.dart';
import 'package:flutter/widgets.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';

class RequestListWidget extends StatefulWidget {
  static const routeName = 'RequestListWidget';

  RequestListWidgetState createState() => RequestListWidgetState();
}

class RequestListWidgetState extends State<RequestListWidget> with SingleTickerProviderStateMixin  {
//  var selectedIndex = 0;
  TabController _tabController;
  int _selectedTab = 0;
  LocalStorageService localStorage = LocalStorageService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(vsync: this, length: 5);
    _tabController.addListener((){
      if (!_tabController.indexIsChanging){
        setState(() {
          _selectedTab = _tabController.index;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {

//    final Map<String, Object> rcvData = ModalRoute.of(context).settings.arguments;
//    this.selectedIndex = rcvData['id'];
    return Scaffold(
    //  backgroundColor:  Colors.white,
          appBar: AppBar(
              title: Text(translator.translate('requestList'),style: TextStyle(fontFamily: FONT_FAMILY),),
            centerTitle: true,
            
          ),
          body: DefaultTabController(
              length: 5,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 10,),
                  Material(
                    elevation: 3,
                    borderOnForeground: true,

               //    color: Colors.grey,
                    child: TabBar(
                      indicatorSize: TabBarIndicatorSize.tab,
                      unselectedLabelColor: Colors.grey,
                      labelColor: Colors.blue,
                      indicatorColor: Colors.blue,
//                      indicator: BoxDecoration(
////                          borderRadius: BorderRadius.only(
////                              bottomLeft: Radius.circular(10),
////                              bottomRight: Radius.circular(10)),
//                              color: Colors.white
//                      ),
                  
                      controller: _tabController,
                      isScrollable: true,
                      labelPadding: const EdgeInsets.all(6.0),
                      tabs: [
                        _getTab(0, translator.translate('pending'),Icons.departure_board),
                        _getTab(1, translator.translate('approved'),Icons.approval),
                        _getTab(2, translator.translate('completed'),Icons.done),
                        _getTab(3, translator.translate('rejected'),Icons.not_interested),
                        _getTab(4, translator.translate('canceled'),Icons.cancel),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      controller: _tabController,
                      children: [
                        ListView(
                          children: [
                            SizedBox(height: 20,), 
                            Container(
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
                                                      flex:3,
                                                      child: Text('Destnation Name',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w600,)),
                                                  ),
                                                  Expanded(
                                                      flex:1,
                                                      child: IconButton(
                                                      icon: Icon(Icons.delete,color: Colors.grey,size: 25),onPressed: () {}),
                                                  ),
                                                ]
                                            ),
                                            Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Icon(Icons.gps_fixed,color: Colors.orange,size: 25,),
                                                  SizedBox(width: 5,),
                                                  Text('loc6-Assuit-loc5-Assuit2',style: TextStyle(fontFamily: FONT_FAMILY)),
                                                ]
                                            ),
                                            SizedBox(height: 3,),
                                            Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Icon(Icons.place,color: Colors.green,size: 25,),
                                                  SizedBox(width: 5,),
                                                  Text('loc6-Assuit-loc5-Assuit2',style: TextStyle(fontFamily: FONT_FAMILY)),
                                                ]
                                            ),
                                            SizedBox(height: 3,),
                                            Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                      flex:1,
                                                      child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: [
                                                            Container(
                                                              width: 70,
                                                              height: 30,
                                                              decoration: BoxDecoration(
                                                                borderRadius: (translator.currentLanguage == 'en' ) ? BorderRadius.only(topRight: Radius.circular(20),
                                                                    bottomRight: Radius.circular(20)) : BorderRadius.only(
                                                                    topLeft: Radius.circular(20),
                                                                    bottomLeft: Radius.circular(20)),
                                                                color: Colors.orange,
                                                              ),
                                                              child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                  children: [
                                                                    Icon(Icons.local_shipping,color: Colors.white,size: 25,),
                                                                    SizedBox(width: 5,),
                                                                    Text('X',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400,)),
                                                                    SizedBox(width: 5,),
                                                                    Text('1',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400,)),
                                                                  ]
                                                              ),
                                                            ),
                                                            SizedBox(width: 10,),
                                                            Text('Trailler',style: TextStyle(fontFamily: FONT_FAMILY)),

                                                          ])),
                                                  Expanded(
                                                      flex:1,
                                                      child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: [
                                                            Icon(Icons.date_range,color: Colors.orange,size: 25,),
                                                            SizedBox(width: 5,),
                                                            Text('07/01/2021 0:00 AM',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400,)),
                                                          ])),

                                                ]
                                            ),

                                          ],)


                                    ),

                                  ),
                                    Container(
                                margin: EdgeInsets.only(top: 0,left: 5,right: 5),
                                width: 110,
                                height: 30,
                              decoration: BoxDecoration(
                                borderRadius: (translator.currentLanguage == 'en' ) ?  BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10))
                                : BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 3
                                ),
                                color: Colors.white
                              ),

                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
        //                            Icon(Icons.local_shipping,color: Colors.white,size: 25,),
                                    SizedBox(width: 10,),
                                    Text('07/01/2021',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w700,color: Colors.grey)),
                                  ]
                              ),
                            ),
                                ]),
                            ),
                            Container(
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
                                                      flex:3,
                                                      child: Text('Destnation Name',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w600,)),
                                                    ),
                                                    Expanded(
                                                      flex:1,
                                                      child: IconButton(
                                                          icon: Icon(Icons.delete,color: Colors.grey,size: 25),onPressed: () {}),
                                                    ),
                                                  ]
                                              ),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Icon(Icons.gps_fixed,color: Colors.orange,size: 25,),
                                                    SizedBox(width: 5,),
                                                    Text('loc6-Assuit-loc5-Assuit2',style: TextStyle(fontFamily: FONT_FAMILY)),
                                                  ]
                                              ),
                                              SizedBox(height: 3,),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Icon(Icons.place,color: Colors.green,size: 25,),
                                                    SizedBox(width: 5,),
                                                    Text('loc6-Assuit-loc5-Assuit2',style: TextStyle(fontFamily: FONT_FAMILY)),
                                                  ]
                                              ),
                                              SizedBox(height: 3,),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                        flex:1,
                                                        child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              Container(
                                                                width: 70,
                                                                height: 30,
                                                                decoration: BoxDecoration(
                                                                  borderRadius: (translator.currentLanguage == 'en' ) ? BorderRadius.only(topRight: Radius.circular(20),
                                                                      bottomRight: Radius.circular(20)) : BorderRadius.only(
                                                                      topLeft: Radius.circular(20),
                                                                      bottomLeft: Radius.circular(20)),
                                                                  color: Colors.orange,
                                                                ),
                                                                child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                    children: [
                                                                      Icon(Icons.local_shipping,color: Colors.white,size: 25,),
                                                                      SizedBox(width: 5,),
                                                                      Text('X',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400,)),
                                                                      SizedBox(width: 5,),
                                                                      Text('1',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400,)),
                                                                    ]
                                                                ),
                                                              ),
                                                              SizedBox(width: 10,),
                                                              Text('Trailler',style: TextStyle(fontFamily: FONT_FAMILY)),

                                                            ])),
                                                    Expanded(
                                                        flex:1,
                                                        child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              Icon(Icons.date_range,color: Colors.orange,size: 25,),
                                                              SizedBox(width: 5,),
                                                              Text('07/01/2021 0:00 AM',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400,)),
                                                            ])),

                                                  ]
                                              ),

                                            ],)


                                      ),

                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 0,left: 5,right: 5),
                                      width: 110,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          borderRadius: (translator.currentLanguage == 'en' ) ?  BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10))
                                              : BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                                          border: Border.all(
                                              color: Colors.grey,
                                              width: 3
                                          ),
                                          color: Colors.white
                                      ),

                                      child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            //                            Icon(Icons.local_shipping,color: Colors.white,size: 25,),
                                            SizedBox(width: 10,),
                                            Text('07/01/2021',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w700,color: Colors.grey)),
                                          ]
                                      ),
                                    ),
                                  ]),
                            ),
                            Container(
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
                                                      flex:3,
                                                      child: Text('Destnation Name',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w600,)),
                                                    ),
                                                    Expanded(
                                                      flex:1,
                                                      child: IconButton(
                                                          icon: Icon(Icons.delete,color: Colors.grey,size: 25),onPressed: () {}),
                                                    ),
                                                  ]
                                              ),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Icon(Icons.gps_fixed,color: Colors.orange,size: 25,),
                                                    SizedBox(width: 5,),
                                                    Text('loc6-Assuit-loc5-Assuit2',style: TextStyle(fontFamily: FONT_FAMILY)),
                                                  ]
                                              ),
                                              SizedBox(height: 3,),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Icon(Icons.place,color: Colors.green,size: 25,),
                                                    SizedBox(width: 5,),
                                                    Text('loc6-Assuit-loc5-Assuit2',style: TextStyle(fontFamily: FONT_FAMILY)),
                                                  ]
                                              ),
                                              SizedBox(height: 3,),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                        flex:1,
                                                        child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              Container(
                                                                width: 70,
                                                                height: 30,
                                                                decoration: BoxDecoration(
                                                                  borderRadius: (translator.currentLanguage == 'en' ) ? BorderRadius.only(topRight: Radius.circular(20),
                                                                      bottomRight: Radius.circular(20)) : BorderRadius.only(
                                                                      topLeft: Radius.circular(20),
                                                                      bottomLeft: Radius.circular(20)),
                                                                  color: Colors.orange,
                                                                ),
                                                                child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                    children: [
                                                                      Icon(Icons.local_shipping,color: Colors.white,size: 25,),
                                                                      SizedBox(width: 5,),
                                                                      Text('X',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400,)),
                                                                      SizedBox(width: 5,),
                                                                      Text('1',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400,)),
                                                                    ]
                                                                ),
                                                              ),
                                                              SizedBox(width: 10,),
                                                              Text('Trailler',style: TextStyle(fontFamily: FONT_FAMILY)),

                                                            ])),
                                                    Expanded(
                                                        flex:1,
                                                        child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              Icon(Icons.date_range,color: Colors.orange,size: 25,),
                                                              SizedBox(width: 5,),
                                                              Text('07/01/2021 0:00 AM',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400,)),
                                                            ])),

                                                  ]
                                              ),

                                            ],)


                                      ),

                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 0,left: 5,right: 5),
                                      width: 110,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          borderRadius: (translator.currentLanguage == 'en' ) ?  BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10))
                                              : BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                                          border: Border.all(
                                              color: Colors.grey,
                                              width: 3
                                          ),
                                          color: Colors.white
                                      ),

                                      child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            //                            Icon(Icons.local_shipping,color: Colors.white,size: 25,),
                                            SizedBox(width: 10,),
                                            Text('07/01/2021',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w700,color: Colors.grey)),
                                          ]
                                      ),
                                    ),
                                  ]),
                            ),
                            Container(
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
                                                      flex:3,
                                                      child: Text('Destnation Name',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w600,)),
                                                    ),
                                                    Expanded(
                                                      flex:1,
                                                      child: IconButton(
                                                          icon: Icon(Icons.delete,color: Colors.grey,size: 25),onPressed: () {}),
                                                    ),
                                                  ]
                                              ),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Icon(Icons.gps_fixed,color: Colors.orange,size: 25,),
                                                    SizedBox(width: 5,),
                                                    Text('loc6-Assuit-loc5-Assuit2',style: TextStyle(fontFamily: FONT_FAMILY)),
                                                  ]
                                              ),
                                              SizedBox(height: 3,),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Icon(Icons.place,color: Colors.green,size: 25,),
                                                    SizedBox(width: 5,),
                                                    Text('loc6-Assuit-loc5-Assuit2',style: TextStyle(fontFamily: FONT_FAMILY)),
                                                  ]
                                              ),
                                              SizedBox(height: 3,),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                        flex:1,
                                                        child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              Container(
                                                                width: 70,
                                                                height: 30,
                                                                decoration: BoxDecoration(
                                                                  borderRadius: (translator.currentLanguage == 'en' ) ? BorderRadius.only(topRight: Radius.circular(20),
                                                                      bottomRight: Radius.circular(20)) : BorderRadius.only(
                                                                      topLeft: Radius.circular(20),
                                                                      bottomLeft: Radius.circular(20)),
                                                                  color: Colors.orange,
                                                                ),
                                                                child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                    children: [
                                                                      Icon(Icons.local_shipping,color: Colors.white,size: 25,),
                                                                      SizedBox(width: 5,),
                                                                      Text('X',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400,)),
                                                                      SizedBox(width: 5,),
                                                                      Text('1',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400,)),
                                                                    ]
                                                                ),
                                                              ),
                                                              SizedBox(width: 10,),
                                                              Text('Trailler',style: TextStyle(fontFamily: FONT_FAMILY)),

                                                            ])),
                                                    Expanded(
                                                        flex:1,
                                                        child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              Icon(Icons.date_range,color: Colors.orange,size: 25,),
                                                              SizedBox(width: 5,),
                                                              Text('07/01/2021 0:00 AM',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400,)),
                                                            ])),

                                                  ]
                                              ),

                                            ],)


                                      ),

                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 0,left: 5,right: 5),
                                      width: 110,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          borderRadius: (translator.currentLanguage == 'en' ) ?  BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10))
                                              : BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                                          border: Border.all(
                                              color: Colors.grey,
                                              width: 3
                                          ),
                                          color: Colors.white
                                      ),

                                      child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            //                            Icon(Icons.local_shipping,color: Colors.white,size: 25,),
                                            SizedBox(width: 10,),
                                            Text('07/01/2021',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w700,color: Colors.grey)),
                                          ]
                                      ),
                                    ),
                                  ]),
                            ),
                            Container(
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
                                                      flex:3,
                                                      child: Text('Destnation Name',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w600,)),
                                                    ),
                                                    Expanded(
                                                      flex:1,
                                                      child: IconButton(
                                                          icon: Icon(Icons.delete,color: Colors.grey,size: 25),onPressed: () {}),
                                                    ),
                                                  ]
                                              ),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Icon(Icons.gps_fixed,color: Colors.orange,size: 25,),
                                                    SizedBox(width: 5,),
                                                    Text('loc6-Assuit-loc5-Assuit2',style: TextStyle(fontFamily: FONT_FAMILY)),
                                                  ]
                                              ),
                                              SizedBox(height: 3,),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Icon(Icons.place,color: Colors.green,size: 25,),
                                                    SizedBox(width: 5,),
                                                    Text('loc6-Assuit-loc5-Assuit2',style: TextStyle(fontFamily: FONT_FAMILY)),
                                                  ]
                                              ),
                                              SizedBox(height: 3,),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                        flex:1,
                                                        child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              Container(
                                                                width: 70,
                                                                height: 30,
                                                                decoration: BoxDecoration(
                                                                  borderRadius: (translator.currentLanguage == 'en' ) ? BorderRadius.only(topRight: Radius.circular(20),
                                                                      bottomRight: Radius.circular(20)) : BorderRadius.only(
                                                                      topLeft: Radius.circular(20),
                                                                      bottomLeft: Radius.circular(20)),
                                                                  color: Colors.orange,
                                                                ),
                                                                child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                    children: [
                                                                      Icon(Icons.local_shipping,color: Colors.white,size: 25,),
                                                                      SizedBox(width: 5,),
                                                                      Text('X',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400,)),
                                                                      SizedBox(width: 5,),
                                                                      Text('1',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400,)),
                                                                    ]
                                                                ),
                                                              ),
                                                              SizedBox(width: 10,),
                                                              Text('Trailler',style: TextStyle(fontFamily: FONT_FAMILY)),

                                                            ])),
                                                    Expanded(
                                                        flex:1,
                                                        child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              Icon(Icons.date_range,color: Colors.orange,size: 25,),
                                                              SizedBox(width: 5,),
                                                              Text('07/01/2021 0:00 AM',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400,)),
                                                            ])),

                                                  ]
                                              ),

                                            ],)


                                      ),

                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 0,left: 5,right: 5),
                                      width: 110,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          borderRadius: (translator.currentLanguage == 'en' ) ?  BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10))
                                              : BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                                          border: Border.all(
                                              color: Colors.grey,
                                              width: 3
                                          ),
                                          color: Colors.white
                                      ),

                                      child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            //                            Icon(Icons.local_shipping,color: Colors.white,size: 25,),
                                            SizedBox(width: 10,),
                                            Text('07/01/2021',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w700,color: Colors.grey)),
                                          ]
                                      ),
                                    ),
                                  ]),
                            ),
                          ],
                        ),
                        ListView(
                          children: [
                            Container(
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
                                                      flex:3,
                                                      child: Text('Destnation Name',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w600,)),
                                                    ),
                                                    Expanded(
                                                      flex:1,
                                                      child: IconButton(
                                                          icon: Icon(Icons.delete,color: Colors.grey,size: 25),onPressed: () {}),
                                                    ),
                                                  ]
                                              ),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Icon(Icons.gps_fixed,color: Colors.orange,size: 25,),
                                                    SizedBox(width: 5,),
                                                    Text('loc6-Assuit-loc5-Assuit2',style: TextStyle(fontFamily: FONT_FAMILY)),
                                                  ]
                                              ),
                                              SizedBox(height: 3,),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Icon(Icons.place,color: Colors.green,size: 25,),
                                                    SizedBox(width: 5,),
                                                    Text('loc6-Assuit-loc5-Assuit2',style: TextStyle(fontFamily: FONT_FAMILY)),
                                                  ]
                                              ),
                                              SizedBox(height: 3,),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                        flex:1,
                                                        child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              Container(
                                                                width: 70,
                                                                height: 30,
                                                                decoration: BoxDecoration(
                                                                  borderRadius: (translator.currentLanguage == 'en' ) ? BorderRadius.only(topRight: Radius.circular(20),
                                                                      bottomRight: Radius.circular(20)) : BorderRadius.only(
                                                                      topLeft: Radius.circular(20),
                                                                      bottomLeft: Radius.circular(20)),
                                                                  color: Colors.orange,
                                                                ),
                                                                child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                    children: [
                                                                      Icon(Icons.local_shipping,color: Colors.white,size: 25,),
                                                                      SizedBox(width: 5,),
                                                                      Text('X',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400,)),
                                                                      SizedBox(width: 5,),
                                                                      Text('1',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400,)),
                                                                    ]
                                                                ),
                                                              ),
                                                              SizedBox(width: 10,),
                                                              Text('Trailler',style: TextStyle(fontFamily: FONT_FAMILY)),

                                                            ])),
                                                    Expanded(
                                                        flex:1,
                                                        child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              Icon(Icons.date_range,color: Colors.orange,size: 25,),
                                                              SizedBox(width: 5,),
                                                              Text('07/01/2021 0:00 AM',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400,)),
                                                            ])),

                                                  ]
                                              ),

                                            ],)


                                      ),

                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 0,left: 5,right: 5),
                                      width: 110,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          borderRadius: (translator.currentLanguage == 'en' ) ?  BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10))
                                              : BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                                          border: Border.all(
                                              color: Colors.grey,
                                              width: 3
                                          ),
                                          color: Colors.white
                                      ),

                                      child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            //                            Icon(Icons.local_shipping,color: Colors.white,size: 25,),
                                            SizedBox(width: 10,),
                                            Text('07/01/2021',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w700,color: Colors.grey)),
                                          ]
                                      ),
                                    ),
                                  ]),
                            ),
                            Container(
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
                                                      flex:3,
                                                      child: Text('Destnation Name',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w600,)),
                                                    ),
                                                    Expanded(
                                                      flex:1,
                                                      child: IconButton(
                                                          icon: Icon(Icons.delete,color: Colors.grey,size: 25),onPressed: () {}),
                                                    ),
                                                  ]
                                              ),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Icon(Icons.gps_fixed,color: Colors.orange,size: 25,),
                                                    SizedBox(width: 5,),
                                                    Text('loc6-Assuit-loc5-Assuit2',style: TextStyle(fontFamily: FONT_FAMILY)),
                                                  ]
                                              ),
                                              SizedBox(height: 3,),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Icon(Icons.place,color: Colors.green,size: 25,),
                                                    SizedBox(width: 5,),
                                                    Text('loc6-Assuit-loc5-Assuit2',style: TextStyle(fontFamily: FONT_FAMILY)),
                                                  ]
                                              ),
                                              SizedBox(height: 3,),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                        flex:1,
                                                        child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              Container(
                                                                width: 70,
                                                                height: 30,
                                                                decoration: BoxDecoration(
                                                                  borderRadius: (translator.currentLanguage == 'en' ) ? BorderRadius.only(topRight: Radius.circular(20),
                                                                      bottomRight: Radius.circular(20)) : BorderRadius.only(
                                                                      topLeft: Radius.circular(20),
                                                                      bottomLeft: Radius.circular(20)),
                                                                  color: Colors.orange,
                                                                ),
                                                                child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                    children: [
                                                                      Icon(Icons.local_shipping,color: Colors.white,size: 25,),
                                                                      SizedBox(width: 5,),
                                                                      Text('X',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400,)),
                                                                      SizedBox(width: 5,),
                                                                      Text('1',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400,)),
                                                                    ]
                                                                ),
                                                              ),
                                                              SizedBox(width: 10,),
                                                              Text('Trailler',style: TextStyle(fontFamily: FONT_FAMILY)),

                                                            ])),
                                                    Expanded(
                                                        flex:1,
                                                        child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              Icon(Icons.date_range,color: Colors.orange,size: 25,),
                                                              SizedBox(width: 5,),
                                                              Text('07/01/2021 0:00 AM',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400,)),
                                                            ])),

                                                  ]
                                              ),

                                            ],)


                                      ),

                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 0,left: 5,right: 5),
                                      width: 110,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          borderRadius: (translator.currentLanguage == 'en' ) ?  BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10))
                                              : BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                                          border: Border.all(
                                              color: Colors.grey,
                                              width: 3
                                          ),
                                          color: Colors.white
                                      ),

                                      child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            //                            Icon(Icons.local_shipping,color: Colors.white,size: 25,),
                                            SizedBox(width: 10,),
                                            Text('07/01/2021',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w700,color: Colors.grey)),
                                          ]
                                      ),
                                    ),
                                  ]),
                            ),
                            Container(
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
                                                      flex:3,
                                                      child: Text('Destnation Name',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w600,)),
                                                    ),
                                                    Expanded(
                                                      flex:1,
                                                      child: IconButton(
                                                          icon: Icon(Icons.delete,color: Colors.grey,size: 25),onPressed: () {}),
                                                    ),
                                                  ]
                                              ),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Icon(Icons.gps_fixed,color: Colors.orange,size: 25,),
                                                    SizedBox(width: 5,),
                                                    Text('loc6-Assuit-loc5-Assuit2',style: TextStyle(fontFamily: FONT_FAMILY)),
                                                  ]
                                              ),
                                              SizedBox(height: 3,),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Icon(Icons.place,color: Colors.green,size: 25,),
                                                    SizedBox(width: 5,),
                                                    Text('loc6-Assuit-loc5-Assuit2',style: TextStyle(fontFamily: FONT_FAMILY)),
                                                  ]
                                              ),
                                              SizedBox(height: 3,),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                        flex:1,
                                                        child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              Container(
                                                                width: 70,
                                                                height: 30,
                                                                decoration: BoxDecoration(
                                                                  borderRadius: (translator.currentLanguage == 'en' ) ? BorderRadius.only(topRight: Radius.circular(20),
                                                                      bottomRight: Radius.circular(20)) : BorderRadius.only(
                                                                      topLeft: Radius.circular(20),
                                                                      bottomLeft: Radius.circular(20)),
                                                                  color: Colors.orange,
                                                                ),
                                                                child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                    children: [
                                                                      Icon(Icons.local_shipping,color: Colors.white,size: 25,),
                                                                      SizedBox(width: 5,),
                                                                      Text('X',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400,)),
                                                                      SizedBox(width: 5,),
                                                                      Text('1',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400,)),
                                                                    ]
                                                                ),
                                                              ),
                                                              SizedBox(width: 10,),
                                                              Text('Trailler',style: TextStyle(fontFamily: FONT_FAMILY)),

                                                            ])),
                                                    Expanded(
                                                        flex:1,
                                                        child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              Icon(Icons.date_range,color: Colors.orange,size: 25,),
                                                              SizedBox(width: 5,),
                                                              Text('07/01/2021 0:00 AM',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400,)),
                                                            ])),

                                                  ]
                                              ),

                                            ],)


                                      ),

                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 0,left: 5,right: 5),
                                      width: 110,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          borderRadius: (translator.currentLanguage == 'en' ) ?  BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10))
                                              : BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                                          border: Border.all(
                                              color: Colors.grey,
                                              width: 3
                                          ),
                                          color: Colors.white
                                      ),

                                      child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            //                            Icon(Icons.local_shipping,color: Colors.white,size: 25,),
                                            SizedBox(width: 10,),
                                            Text('07/01/2021',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w700,color: Colors.grey)),
                                          ]
                                      ),
                                    ),
                                  ]),
                            ),
                            Container(
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
                                                      flex:3,
                                                      child: Text('Destnation Name',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w600,)),
                                                    ),
                                                    Expanded(
                                                      flex:1,
                                                      child: IconButton(
                                                          icon: Icon(Icons.delete,color: Colors.grey,size: 25),onPressed: () {}),
                                                    ),
                                                  ]
                                              ),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Icon(Icons.gps_fixed,color: Colors.orange,size: 25,),
                                                    SizedBox(width: 5,),
                                                    Text('loc6-Assuit-loc5-Assuit2',style: TextStyle(fontFamily: FONT_FAMILY)),
                                                  ]
                                              ),
                                              SizedBox(height: 3,),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Icon(Icons.place,color: Colors.green,size: 25,),
                                                    SizedBox(width: 5,),
                                                    Text('loc6-Assuit-loc5-Assuit2',style: TextStyle(fontFamily: FONT_FAMILY)),
                                                  ]
                                              ),
                                              SizedBox(height: 3,),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                        flex:1,
                                                        child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              Container(
                                                                width: 70,
                                                                height: 30,
                                                                decoration: BoxDecoration(
                                                                  borderRadius: (translator.currentLanguage == 'en' ) ? BorderRadius.only(topRight: Radius.circular(20),
                                                                      bottomRight: Radius.circular(20)) : BorderRadius.only(
                                                                      topLeft: Radius.circular(20),
                                                                      bottomLeft: Radius.circular(20)),
                                                                  color: Colors.orange,
                                                                ),
                                                                child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                    children: [
                                                                      Icon(Icons.local_shipping,color: Colors.white,size: 25,),
                                                                      SizedBox(width: 5,),
                                                                      Text('X',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400,)),
                                                                      SizedBox(width: 5,),
                                                                      Text('1',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400,)),
                                                                    ]
                                                                ),
                                                              ),
                                                              SizedBox(width: 10,),
                                                              Text('Trailler',style: TextStyle(fontFamily: FONT_FAMILY)),

                                                            ])),
                                                    Expanded(
                                                        flex:1,
                                                        child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              Icon(Icons.date_range,color: Colors.orange,size: 25,),
                                                              SizedBox(width: 5,),
                                                              Text('07/01/2021 0:00 AM',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400,)),
                                                            ])),

                                                  ]
                                              ),

                                            ],)


                                      ),

                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 0,left: 5,right: 5),
                                      width: 110,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          borderRadius: (translator.currentLanguage == 'en' ) ?  BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10))
                                              : BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                                          border: Border.all(
                                              color: Colors.grey,
                                              width: 3
                                          ),
                                          color: Colors.white
                                      ),

                                      child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            //                            Icon(Icons.local_shipping,color: Colors.white,size: 25,),
                                            SizedBox(width: 10,),
                                            Text('07/01/2021',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w700,color: Colors.grey)),
                                          ]
                                      ),
                                    ),
                                  ]),
                            ),
                            Container(
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
                                                      flex:3,
                                                      child: Text('Destnation Name',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w600,)),
                                                    ),
                                                    Expanded(
                                                      flex:1,
                                                      child: IconButton(
                                                          icon: Icon(Icons.delete,color: Colors.grey,size: 25),onPressed: () {}),
                                                    ),
                                                  ]
                                              ),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Icon(Icons.gps_fixed,color: Colors.orange,size: 25,),
                                                    SizedBox(width: 5,),
                                                    Text('loc6-Assuit-loc5-Assuit2',style: TextStyle(fontFamily: FONT_FAMILY)),
                                                  ]
                                              ),
                                              SizedBox(height: 3,),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Icon(Icons.place,color: Colors.green,size: 25,),
                                                    SizedBox(width: 5,),
                                                    Text('loc6-Assuit-loc5-Assuit2',style: TextStyle(fontFamily: FONT_FAMILY)),
                                                  ]
                                              ),
                                              SizedBox(height: 3,),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                        flex:1,
                                                        child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              Container(
                                                                width: 70,
                                                                height: 30,
                                                                decoration: BoxDecoration(
                                                                  borderRadius: (translator.currentLanguage == 'en' ) ? BorderRadius.only(topRight: Radius.circular(20),
                                                                      bottomRight: Radius.circular(20)) : BorderRadius.only(
                                                                      topLeft: Radius.circular(20),
                                                                      bottomLeft: Radius.circular(20)),
                                                                  color: Colors.orange,
                                                                ),
                                                                child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                    children: [
                                                                      Icon(Icons.local_shipping,color: Colors.white,size: 25,),
                                                                      SizedBox(width: 5,),
                                                                      Text('X',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400,)),
                                                                      SizedBox(width: 5,),
                                                                      Text('1',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400,)),
                                                                    ]
                                                                ),
                                                              ),
                                                              SizedBox(width: 10,),
                                                              Text('Trailler',style: TextStyle(fontFamily: FONT_FAMILY)),

                                                            ])),
                                                    Expanded(
                                                        flex:1,
                                                        child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              Icon(Icons.date_range,color: Colors.orange,size: 25,),
                                                              SizedBox(width: 5,),
                                                              Text('07/01/2021 0:00 AM',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400,)),
                                                            ])),

                                                  ]
                                              ),

                                            ],)


                                      ),

                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 0,left: 5,right: 5),
                                      width: 110,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          borderRadius: (translator.currentLanguage == 'en' ) ?  BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10))
                                              : BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                                          border: Border.all(
                                              color: Colors.grey,
                                              width: 3
                                          ),
                                          color: Colors.white
                                      ),

                                      child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            //                            Icon(Icons.local_shipping,color: Colors.white,size: 25,),
                                            SizedBox(width: 10,),
                                            Text('07/01/2021',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w700,color: Colors.grey)),
                                          ]
                                      ),
                                    ),
                                  ]),
                            ),

                          ],
                        ),
                        ListView(
                          children: [
                            Container(
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
                                                      flex:3,
                                                      child: Text('Destnation Name',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w600,)),
                                                    ),
                                                    Expanded(
                                                      flex:1,
                                                      child: IconButton(
                                                          icon: Icon(Icons.delete,color: Colors.grey,size: 25),onPressed: () {}),
                                                    ),
                                                  ]
                                              ),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Icon(Icons.gps_fixed,color: Colors.orange,size: 25,),
                                                    SizedBox(width: 5,),
                                                    Text('loc6-Assuit-loc5-Assuit2',style: TextStyle(fontFamily: FONT_FAMILY)),
                                                  ]
                                              ),
                                              SizedBox(height: 3,),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Icon(Icons.place,color: Colors.green,size: 25,),
                                                    SizedBox(width: 5,),
                                                    Text('loc6-Assuit-loc5-Assuit2',style: TextStyle(fontFamily: FONT_FAMILY)),
                                                  ]
                                              ),
                                              SizedBox(height: 3,),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                        flex:1,
                                                        child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              Container(
                                                                width: 70,
                                                                height: 30,
                                                                decoration: BoxDecoration(
                                                                  borderRadius: (translator.currentLanguage == 'en' ) ? BorderRadius.only(topRight: Radius.circular(20),
                                                                      bottomRight: Radius.circular(20)) : BorderRadius.only(
                                                                      topLeft: Radius.circular(20),
                                                                      bottomLeft: Radius.circular(20)),
                                                                  color: Colors.orange,
                                                                ),
                                                                child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                    children: [
                                                                      Icon(Icons.local_shipping,color: Colors.white,size: 25,),
                                                                      SizedBox(width: 5,),
                                                                      Text('X',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400,)),
                                                                      SizedBox(width: 5,),
                                                                      Text('1',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400,)),
                                                                    ]
                                                                ),
                                                              ),
                                                              SizedBox(width: 10,),
                                                              Text('Trailler',style: TextStyle(fontFamily: FONT_FAMILY)),

                                                            ])),
                                                    Expanded(
                                                        flex:1,
                                                        child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              Icon(Icons.date_range,color: Colors.orange,size: 25,),
                                                              SizedBox(width: 5,),
                                                              Text('07/01/2021 0:00 AM',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400,)),
                                                            ])),

                                                  ]
                                              ),

                                            ],)


                                      ),

                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 0,left: 5,right: 5),
                                      width: 110,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          borderRadius: (translator.currentLanguage == 'en' ) ?  BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10))
                                              : BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                                          border: Border.all(
                                              color: Colors.grey,
                                              width: 3
                                          ),
                                          color: Colors.white
                                      ),

                                      child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            //                            Icon(Icons.local_shipping,color: Colors.white,size: 25,),
                                            SizedBox(width: 10,),
                                            Text('07/01/2021',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w700,color: Colors.grey)),
                                          ]
                                      ),
                                    ),
                                  ]),
                            ),
                            Container(
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
                                                      flex:3,
                                                      child: Text('Destnation Name',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w600,)),
                                                    ),
                                                    Expanded(
                                                      flex:1,
                                                      child: IconButton(
                                                          icon: Icon(Icons.delete,color: Colors.grey,size: 25),onPressed: () {}),
                                                    ),
                                                  ]
                                              ),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Icon(Icons.gps_fixed,color: Colors.orange,size: 25,),
                                                    SizedBox(width: 5,),
                                                    Text('loc6-Assuit-loc5-Assuit2',style: TextStyle(fontFamily: FONT_FAMILY)),
                                                  ]
                                              ),
                                              SizedBox(height: 3,),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Icon(Icons.place,color: Colors.green,size: 25,),
                                                    SizedBox(width: 5,),
                                                    Text('loc6-Assuit-loc5-Assuit2',style: TextStyle(fontFamily: FONT_FAMILY)),
                                                  ]
                                              ),
                                              SizedBox(height: 3,),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                        flex:1,
                                                        child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              Container(
                                                                width: 70,
                                                                height: 30,
                                                                decoration: BoxDecoration(
                                                                  borderRadius: (translator.currentLanguage == 'en' ) ? BorderRadius.only(topRight: Radius.circular(20),
                                                                      bottomRight: Radius.circular(20)) : BorderRadius.only(
                                                                      topLeft: Radius.circular(20),
                                                                      bottomLeft: Radius.circular(20)),
                                                                  color: Colors.orange,
                                                                ),
                                                                child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                    children: [
                                                                      Icon(Icons.local_shipping,color: Colors.white,size: 25,),
                                                                      SizedBox(width: 5,),
                                                                      Text('X',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400,)),
                                                                      SizedBox(width: 5,),
                                                                      Text('1',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400,)),
                                                                    ]
                                                                ),
                                                              ),
                                                              SizedBox(width: 10,),
                                                              Text('Trailler',style: TextStyle(fontFamily: FONT_FAMILY)),

                                                            ])),
                                                    Expanded(
                                                        flex:1,
                                                        child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              Icon(Icons.date_range,color: Colors.orange,size: 25,),
                                                              SizedBox(width: 5,),
                                                              Text('07/01/2021 0:00 AM',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400,)),
                                                            ])),

                                                  ]
                                              ),

                                            ],)


                                      ),

                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 0,left: 5,right: 5),
                                      width: 110,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          borderRadius: (translator.currentLanguage == 'en' ) ?  BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10))
                                              : BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                                          border: Border.all(
                                              color: Colors.grey,
                                              width: 3
                                          ),
                                          color: Colors.white
                                      ),

                                      child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            //                            Icon(Icons.local_shipping,color: Colors.white,size: 25,),
                                            SizedBox(width: 10,),
                                            Text('07/01/2021',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w700,color: Colors.grey)),
                                          ]
                                      ),
                                    ),
                                  ]),
                            ),
                            Container(
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
                                                      flex:3,
                                                      child: Text('Destnation Name',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w600,)),
                                                    ),
                                                    Expanded(
                                                      flex:1,
                                                      child: IconButton(
                                                          icon: Icon(Icons.delete,color: Colors.grey,size: 25),onPressed: () {}),
                                                    ),
                                                  ]
                                              ),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Icon(Icons.gps_fixed,color: Colors.orange,size: 25,),
                                                    SizedBox(width: 5,),
                                                    Text('loc6-Assuit-loc5-Assuit2',style: TextStyle(fontFamily: FONT_FAMILY)),
                                                  ]
                                              ),
                                              SizedBox(height: 3,),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Icon(Icons.place,color: Colors.green,size: 25,),
                                                    SizedBox(width: 5,),
                                                    Text('loc6-Assuit-loc5-Assuit2',style: TextStyle(fontFamily: FONT_FAMILY)),
                                                  ]
                                              ),
                                              SizedBox(height: 3,),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                        flex:1,
                                                        child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              Container(
                                                                width: 70,
                                                                height: 30,
                                                                decoration: BoxDecoration(
                                                                  borderRadius: (translator.currentLanguage == 'en' ) ? BorderRadius.only(topRight: Radius.circular(20),
                                                                      bottomRight: Radius.circular(20)) : BorderRadius.only(
                                                                      topLeft: Radius.circular(20),
                                                                      bottomLeft: Radius.circular(20)),
                                                                  color: Colors.orange,
                                                                ),
                                                                child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                    children: [
                                                                      Icon(Icons.local_shipping,color: Colors.white,size: 25,),
                                                                      SizedBox(width: 5,),
                                                                      Text('X',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400,)),
                                                                      SizedBox(width: 5,),
                                                                      Text('1',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400,)),
                                                                    ]
                                                                ),
                                                              ),
                                                              SizedBox(width: 10,),
                                                              Text('Trailler',style: TextStyle(fontFamily: FONT_FAMILY)),

                                                            ])),
                                                    Expanded(
                                                        flex:1,
                                                        child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              Icon(Icons.date_range,color: Colors.orange,size: 25,),
                                                              SizedBox(width: 5,),
                                                              Text('07/01/2021 0:00 AM',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400,)),
                                                            ])),

                                                  ]
                                              ),

                                            ],)


                                      ),

                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 0,left: 5,right: 5),
                                      width: 110,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          borderRadius: (translator.currentLanguage == 'en' ) ?  BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10))
                                              : BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                                          border: Border.all(
                                              color: Colors.grey,
                                              width: 3
                                          ),
                                          color: Colors.white
                                      ),

                                      child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            //                            Icon(Icons.local_shipping,color: Colors.white,size: 25,),
                                            SizedBox(width: 10,),
                                            Text('07/01/2021',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w700,color: Colors.grey)),
                                          ]
                                      ),
                                    ),
                                  ]),
                            ),
                            Container(
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
                                                      flex:3,
                                                      child: Text('Destnation Name',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w600,)),
                                                    ),
                                                    Expanded(
                                                      flex:1,
                                                      child: IconButton(
                                                          icon: Icon(Icons.delete,color: Colors.grey,size: 25),onPressed: () {}),
                                                    ),
                                                  ]
                                              ),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Icon(Icons.gps_fixed,color: Colors.orange,size: 25,),
                                                    SizedBox(width: 5,),
                                                    Text('loc6-Assuit-loc5-Assuit2',style: TextStyle(fontFamily: FONT_FAMILY)),
                                                  ]
                                              ),
                                              SizedBox(height: 3,),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Icon(Icons.place,color: Colors.green,size: 25,),
                                                    SizedBox(width: 5,),
                                                    Text('loc6-Assuit-loc5-Assuit2',style: TextStyle(fontFamily: FONT_FAMILY)),
                                                  ]
                                              ),
                                              SizedBox(height: 3,),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                        flex:1,
                                                        child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              Container(
                                                                width: 70,
                                                                height: 30,
                                                                decoration: BoxDecoration(
                                                                  borderRadius: (translator.currentLanguage == 'en' ) ? BorderRadius.only(topRight: Radius.circular(20),
                                                                      bottomRight: Radius.circular(20)) : BorderRadius.only(
                                                                      topLeft: Radius.circular(20),
                                                                      bottomLeft: Radius.circular(20)),
                                                                  color: Colors.orange,
                                                                ),
                                                                child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                    children: [
                                                                      Icon(Icons.local_shipping,color: Colors.white,size: 25,),
                                                                      SizedBox(width: 5,),
                                                                      Text('X',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400,)),
                                                                      SizedBox(width: 5,),
                                                                      Text('1',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400,)),
                                                                    ]
                                                                ),
                                                              ),
                                                              SizedBox(width: 10,),
                                                              Text('Trailler',style: TextStyle(fontFamily: FONT_FAMILY)),

                                                            ])),
                                                    Expanded(
                                                        flex:1,
                                                        child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              Icon(Icons.date_range,color: Colors.orange,size: 25,),
                                                              SizedBox(width: 5,),
                                                              Text('07/01/2021 0:00 AM',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400,)),
                                                            ])),

                                                  ]
                                              ),

                                            ],)


                                      ),

                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 0,left: 5,right: 5),
                                      width: 110,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          borderRadius: (translator.currentLanguage == 'en' ) ?  BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10))
                                              : BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                                          border: Border.all(
                                              color: Colors.grey,
                                              width: 3
                                          ),
                                          color: Colors.white
                                      ),

                                      child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            //                            Icon(Icons.local_shipping,color: Colors.white,size: 25,),
                                            SizedBox(width: 10,),
                                            Text('07/01/2021',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w700,color: Colors.grey)),
                                          ]
                                      ),
                                    ),
                                  ]),
                            ),
                            Container(
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
                                                      flex:3,
                                                      child: Text('Destnation Name',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w600,)),
                                                    ),
                                                    Expanded(
                                                      flex:1,
                                                      child: IconButton(
                                                          icon: Icon(Icons.delete,color: Colors.grey,size: 25),onPressed: () {}),
                                                    ),
                                                  ]
                                              ),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Icon(Icons.gps_fixed,color: Colors.orange,size: 25,),
                                                    SizedBox(width: 5,),
                                                    Text('loc6-Assuit-loc5-Assuit2',style: TextStyle(fontFamily: FONT_FAMILY)),
                                                  ]
                                              ),
                                              SizedBox(height: 3,),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Icon(Icons.place,color: Colors.green,size: 25,),
                                                    SizedBox(width: 5,),
                                                    Text('loc6-Assuit-loc5-Assuit2',style: TextStyle(fontFamily: FONT_FAMILY)),
                                                  ]
                                              ),
                                              SizedBox(height: 3,),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                        flex:1,
                                                        child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              Container(
                                                                width: 70,
                                                                height: 30,
                                                                decoration: BoxDecoration(
                                                                  borderRadius: (translator.currentLanguage == 'en' ) ? BorderRadius.only(topRight: Radius.circular(20),
                                                                      bottomRight: Radius.circular(20)) : BorderRadius.only(
                                                                      topLeft: Radius.circular(20),
                                                                      bottomLeft: Radius.circular(20)),
                                                                  color: Colors.orange,
                                                                ),
                                                                child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                    children: [
                                                                      Icon(Icons.local_shipping,color: Colors.white,size: 25,),
                                                                      SizedBox(width: 5,),
                                                                      Text('X',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400,)),
                                                                      SizedBox(width: 5,),
                                                                      Text('1',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400,)),
                                                                    ]
                                                                ),
                                                              ),
                                                              SizedBox(width: 10,),
                                                              Text('Trailler',style: TextStyle(fontFamily: FONT_FAMILY)),

                                                            ])),
                                                    Expanded(
                                                        flex:1,
                                                        child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              Icon(Icons.date_range,color: Colors.orange,size: 25,),
                                                              SizedBox(width: 5,),
                                                              Text('07/01/2021 0:00 AM',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400,)),
                                                            ])),

                                                  ]
                                              ),

                                            ],)


                                      ),

                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 0,left: 5,right: 5),
                                      width: 110,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          borderRadius: (translator.currentLanguage == 'en' ) ?  BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10))
                                              : BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                                          border: Border.all(
                                              color: Colors.grey,
                                              width: 3
                                          ),
                                          color: Colors.white
                                      ),

                                      child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            //                            Icon(Icons.local_shipping,color: Colors.white,size: 25,),
                                            SizedBox(width: 10,),
                                            Text('07/01/2021',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w700,color: Colors.grey)),
                                          ]
                                      ),
                                    ),
                                  ]),
                            ),

                          ],
                        ),
                        ListView(
                          children: [
                            Container(
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
                                                      flex:3,
                                                      child: Text('Destnation Name',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w600,)),
                                                    ),
                                                    Expanded(
                                                      flex:1,
                                                      child: IconButton(
                                                          icon: Icon(Icons.delete,color: Colors.grey,size: 25),onPressed: () {}),
                                                    ),
                                                  ]
                                              ),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Icon(Icons.gps_fixed,color: Colors.orange,size: 25,),
                                                    SizedBox(width: 5,),
                                                    Text('loc6-Assuit-loc5-Assuit2',style: TextStyle(fontFamily: FONT_FAMILY)),
                                                  ]
                                              ),
                                              SizedBox(height: 3,),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Icon(Icons.place,color: Colors.green,size: 25,),
                                                    SizedBox(width: 5,),
                                                    Text('loc6-Assuit-loc5-Assuit2',style: TextStyle(fontFamily: FONT_FAMILY)),
                                                  ]
                                              ),
                                              SizedBox(height: 3,),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                        flex:1,
                                                        child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              Container(
                                                                width: 70,
                                                                height: 30,
                                                                decoration: BoxDecoration(
                                                                  borderRadius: (translator.currentLanguage == 'en' ) ? BorderRadius.only(topRight: Radius.circular(20),
                                                                      bottomRight: Radius.circular(20)) : BorderRadius.only(
                                                                      topLeft: Radius.circular(20),
                                                                      bottomLeft: Radius.circular(20)),
                                                                  color: Colors.orange,
                                                                ),
                                                                child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                    children: [
                                                                      Icon(Icons.local_shipping,color: Colors.white,size: 25,),
                                                                      SizedBox(width: 5,),
                                                                      Text('X',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400,)),
                                                                      SizedBox(width: 5,),
                                                                      Text('1',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400,)),
                                                                    ]
                                                                ),
                                                              ),
                                                              SizedBox(width: 10,),
                                                              Text('Trailler',style: TextStyle(fontFamily: FONT_FAMILY)),

                                                            ])),
                                                    Expanded(
                                                        flex:1,
                                                        child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              Icon(Icons.date_range,color: Colors.orange,size: 25,),
                                                              SizedBox(width: 5,),
                                                              Text('07/01/2021 0:00 AM',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400,)),
                                                            ])),

                                                  ]
                                              ),

                                            ],)


                                      ),

                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 0,left: 5,right: 5),
                                      width: 110,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          borderRadius: (translator.currentLanguage == 'en' ) ?  BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10))
                                              : BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                                          border: Border.all(
                                              color: Colors.grey,
                                              width: 3
                                          ),
                                          color: Colors.white
                                      ),

                                      child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            //                            Icon(Icons.local_shipping,color: Colors.white,size: 25,),
                                            SizedBox(width: 10,),
                                            Text('07/01/2021',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w700,color: Colors.grey)),
                                          ]
                                      ),
                                    ),
                                  ]),
                            ),
                            Container(
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
                                                      flex:3,
                                                      child: Text('Destnation Name',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w600,)),
                                                    ),
                                                    Expanded(
                                                      flex:1,
                                                      child: IconButton(
                                                          icon: Icon(Icons.delete,color: Colors.grey,size: 25),onPressed: () {}),
                                                    ),
                                                  ]
                                              ),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Icon(Icons.gps_fixed,color: Colors.orange,size: 25,),
                                                    SizedBox(width: 5,),
                                                    Text('loc6-Assuit-loc5-Assuit2',style: TextStyle(fontFamily: FONT_FAMILY)),
                                                  ]
                                              ),
                                              SizedBox(height: 3,),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Icon(Icons.place,color: Colors.green,size: 25,),
                                                    SizedBox(width: 5,),
                                                    Text('loc6-Assuit-loc5-Assuit2',style: TextStyle(fontFamily: FONT_FAMILY)),
                                                  ]
                                              ),
                                              SizedBox(height: 3,),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                        flex:1,
                                                        child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              Container(
                                                                width: 70,
                                                                height: 30,
                                                                decoration: BoxDecoration(
                                                                  borderRadius: (translator.currentLanguage == 'en' ) ? BorderRadius.only(topRight: Radius.circular(20),
                                                                      bottomRight: Radius.circular(20)) : BorderRadius.only(
                                                                      topLeft: Radius.circular(20),
                                                                      bottomLeft: Radius.circular(20)),
                                                                  color: Colors.orange,
                                                                ),
                                                                child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                    children: [
                                                                      Icon(Icons.local_shipping,color: Colors.white,size: 25,),
                                                                      SizedBox(width: 5,),
                                                                      Text('X',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400,)),
                                                                      SizedBox(width: 5,),
                                                                      Text('1',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400,)),
                                                                    ]
                                                                ),
                                                              ),
                                                              SizedBox(width: 10,),
                                                              Text('Trailler',style: TextStyle(fontFamily: FONT_FAMILY)),

                                                            ])),
                                                    Expanded(
                                                        flex:1,
                                                        child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              Icon(Icons.date_range,color: Colors.orange,size: 25,),
                                                              SizedBox(width: 5,),
                                                              Text('07/01/2021 0:00 AM',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400,)),
                                                            ])),

                                                  ]
                                              ),

                                            ],)


                                      ),

                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 0,left: 5,right: 5),
                                      width: 110,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          borderRadius: (translator.currentLanguage == 'en' ) ?  BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10))
                                              : BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                                          border: Border.all(
                                              color: Colors.grey,
                                              width: 3
                                          ),
                                          color: Colors.white
                                      ),

                                      child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            //                            Icon(Icons.local_shipping,color: Colors.white,size: 25,),
                                            SizedBox(width: 10,),
                                            Text('07/01/2021',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w700,color: Colors.grey)),
                                          ]
                                      ),
                                    ),
                                  ]),
                            ),
                            Container(
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
                                                      flex:3,
                                                      child: Text('Destnation Name',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w600,)),
                                                    ),
                                                    Expanded(
                                                      flex:1,
                                                      child: IconButton(
                                                          icon: Icon(Icons.delete,color: Colors.grey,size: 25),onPressed: () {}),
                                                    ),
                                                  ]
                                              ),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Icon(Icons.gps_fixed,color: Colors.orange,size: 25,),
                                                    SizedBox(width: 5,),
                                                    Text('loc6-Assuit-loc5-Assuit2',style: TextStyle(fontFamily: FONT_FAMILY)),
                                                  ]
                                              ),
                                              SizedBox(height: 3,),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Icon(Icons.place,color: Colors.green,size: 25,),
                                                    SizedBox(width: 5,),
                                                    Text('loc6-Assuit-loc5-Assuit2',style: TextStyle(fontFamily: FONT_FAMILY)),
                                                  ]
                                              ),
                                              SizedBox(height: 3,),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                        flex:1,
                                                        child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              Container(
                                                                width: 70,
                                                                height: 30,
                                                                decoration: BoxDecoration(
                                                                  borderRadius: (translator.currentLanguage == 'en' ) ? BorderRadius.only(topRight: Radius.circular(20),
                                                                      bottomRight: Radius.circular(20)) : BorderRadius.only(
                                                                      topLeft: Radius.circular(20),
                                                                      bottomLeft: Radius.circular(20)),
                                                                  color: Colors.orange,
                                                                ),
                                                                child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                    children: [
                                                                      Icon(Icons.local_shipping,color: Colors.white,size: 25,),
                                                                      SizedBox(width: 5,),
                                                                      Text('X',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400,)),
                                                                      SizedBox(width: 5,),
                                                                      Text('1',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400,)),
                                                                    ]
                                                                ),
                                                              ),
                                                              SizedBox(width: 10,),
                                                              Text('Trailler',style: TextStyle(fontFamily: FONT_FAMILY)),

                                                            ])),
                                                    Expanded(
                                                        flex:1,
                                                        child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              Icon(Icons.date_range,color: Colors.orange,size: 25,),
                                                              SizedBox(width: 5,),
                                                              Text('07/01/2021 0:00 AM',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400,)),
                                                            ])),

                                                  ]
                                              ),

                                            ],)


                                      ),

                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 0,left: 5,right: 5),
                                      width: 110,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          borderRadius: (translator.currentLanguage == 'en' ) ?  BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10))
                                              : BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                                          border: Border.all(
                                              color: Colors.grey,
                                              width: 3
                                          ),
                                          color: Colors.white
                                      ),

                                      child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            //                            Icon(Icons.local_shipping,color: Colors.white,size: 25,),
                                            SizedBox(width: 10,),
                                            Text('07/01/2021',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w700,color: Colors.grey)),
                                          ]
                                      ),
                                    ),
                                  ]),
                            ),
                            Container(
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
                                                      flex:3,
                                                      child: Text('Destnation Name',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w600,)),
                                                    ),
                                                    Expanded(
                                                      flex:1,
                                                      child: IconButton(
                                                          icon: Icon(Icons.delete,color: Colors.grey,size: 25),onPressed: () {}),
                                                    ),
                                                  ]
                                              ),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Icon(Icons.gps_fixed,color: Colors.orange,size: 25,),
                                                    SizedBox(width: 5,),
                                                    Text('loc6-Assuit-loc5-Assuit2',style: TextStyle(fontFamily: FONT_FAMILY)),
                                                  ]
                                              ),
                                              SizedBox(height: 3,),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Icon(Icons.place,color: Colors.green,size: 25,),
                                                    SizedBox(width: 5,),
                                                    Text('loc6-Assuit-loc5-Assuit2',style: TextStyle(fontFamily: FONT_FAMILY)),
                                                  ]
                                              ),
                                              SizedBox(height: 3,),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                        flex:1,
                                                        child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              Container(
                                                                width: 70,
                                                                height: 30,
                                                                decoration: BoxDecoration(
                                                                  borderRadius: (translator.currentLanguage == 'en' ) ? BorderRadius.only(topRight: Radius.circular(20),
                                                                      bottomRight: Radius.circular(20)) : BorderRadius.only(
                                                                      topLeft: Radius.circular(20),
                                                                      bottomLeft: Radius.circular(20)),
                                                                  color: Colors.orange,
                                                                ),
                                                                child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                    children: [
                                                                      Icon(Icons.local_shipping,color: Colors.white,size: 25,),
                                                                      SizedBox(width: 5,),
                                                                      Text('X',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400,)),
                                                                      SizedBox(width: 5,),
                                                                      Text('1',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400,)),
                                                                    ]
                                                                ),
                                                              ),
                                                              SizedBox(width: 10,),
                                                              Text('Trailler',style: TextStyle(fontFamily: FONT_FAMILY)),

                                                            ])),
                                                    Expanded(
                                                        flex:1,
                                                        child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              Icon(Icons.date_range,color: Colors.orange,size: 25,),
                                                              SizedBox(width: 5,),
                                                              Text('07/01/2021 0:00 AM',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400,)),
                                                            ])),

                                                  ]
                                              ),

                                            ],)


                                      ),

                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 0,left: 5,right: 5),
                                      width: 110,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          borderRadius: (translator.currentLanguage == 'en' ) ?  BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10))
                                              : BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                                          border: Border.all(
                                              color: Colors.grey,
                                              width: 3
                                          ),
                                          color: Colors.white
                                      ),

                                      child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            //                            Icon(Icons.local_shipping,color: Colors.white,size: 25,),
                                            SizedBox(width: 10,),
                                            Text('07/01/2021',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w700,color: Colors.grey)),
                                          ]
                                      ),
                                    ),
                                  ]),
                            ),
                            Container(
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
                                                      flex:3,
                                                      child: Text('Destnation Name',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w600,)),
                                                    ),
                                                    Expanded(
                                                      flex:1,
                                                      child: IconButton(
                                                          icon: Icon(Icons.delete,color: Colors.grey,size: 25),onPressed: () {}),
                                                    ),
                                                  ]
                                              ),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Icon(Icons.gps_fixed,color: Colors.orange,size: 25,),
                                                    SizedBox(width: 5,),
                                                    Text('loc6-Assuit-loc5-Assuit2',style: TextStyle(fontFamily: FONT_FAMILY)),
                                                  ]
                                              ),
                                              SizedBox(height: 3,),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Icon(Icons.place,color: Colors.green,size: 25,),
                                                    SizedBox(width: 5,),
                                                    Text('loc6-Assuit-loc5-Assuit2',style: TextStyle(fontFamily: FONT_FAMILY)),
                                                  ]
                                              ),
                                              SizedBox(height: 3,),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                        flex:1,
                                                        child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              Container(
                                                                width: 70,
                                                                height: 30,
                                                                decoration: BoxDecoration(
                                                                  borderRadius: (translator.currentLanguage == 'en' ) ? BorderRadius.only(topRight: Radius.circular(20),
                                                                      bottomRight: Radius.circular(20)) : BorderRadius.only(
                                                                      topLeft: Radius.circular(20),
                                                                      bottomLeft: Radius.circular(20)),
                                                                  color: Colors.orange,
                                                                ),
                                                                child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                    children: [
                                                                      Icon(Icons.local_shipping,color: Colors.white,size: 25,),
                                                                      SizedBox(width: 5,),
                                                                      Text('X',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400,)),
                                                                      SizedBox(width: 5,),
                                                                      Text('1',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400,)),
                                                                    ]
                                                                ),
                                                              ),
                                                              SizedBox(width: 10,),
                                                              Text('Trailler',style: TextStyle(fontFamily: FONT_FAMILY)),

                                                            ])),
                                                    Expanded(
                                                        flex:1,
                                                        child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              Icon(Icons.date_range,color: Colors.orange,size: 25,),
                                                              SizedBox(width: 5,),
                                                              Text('07/01/2021 0:00 AM',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400,)),
                                                            ])),

                                                  ]
                                              ),

                                            ],)


                                      ),

                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 0,left: 5,right: 5),
                                      width: 110,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          borderRadius: (translator.currentLanguage == 'en' ) ?  BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10))
                                              : BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                                          border: Border.all(
                                              color: Colors.grey,
                                              width: 3
                                          ),
                                          color: Colors.white
                                      ),

                                      child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            //                            Icon(Icons.local_shipping,color: Colors.white,size: 25,),
                                            SizedBox(width: 10,),
                                            Text('07/01/2021',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w700,color: Colors.grey)),
                                          ]
                                      ),
                                    ),
                                  ]),
                            ),

                          ],
                        ),
                        ListView(
                          children: [
                            Container(
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
                                                      flex:3,
                                                      child: Text('Destnation Name',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w600,)),
                                                    ),
                                                    Expanded(
                                                      flex:1,
                                                      child: IconButton(
                                                          icon: Icon(Icons.delete,color: Colors.grey,size: 25),onPressed: () {}),
                                                    ),
                                                  ]
                                              ),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Icon(Icons.gps_fixed,color: Colors.orange,size: 25,),
                                                    SizedBox(width: 5,),
                                                    Text('loc6-Assuit-loc5-Assuit2',style: TextStyle(fontFamily: FONT_FAMILY)),
                                                  ]
                                              ),
                                              SizedBox(height: 3,),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Icon(Icons.place,color: Colors.green,size: 25,),
                                                    SizedBox(width: 5,),
                                                    Text('loc6-Assuit-loc5-Assuit2',style: TextStyle(fontFamily: FONT_FAMILY)),
                                                  ]
                                              ),
                                              SizedBox(height: 3,),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                        flex:1,
                                                        child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              Container(
                                                                width: 70,
                                                                height: 30,
                                                                decoration: BoxDecoration(
                                                                  borderRadius: (translator.currentLanguage == 'en' ) ? BorderRadius.only(topRight: Radius.circular(20),
                                                                      bottomRight: Radius.circular(20)) : BorderRadius.only(
                                                                      topLeft: Radius.circular(20),
                                                                      bottomLeft: Radius.circular(20)),
                                                                  color: Colors.orange,
                                                                ),
                                                                child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                    children: [
                                                                      Icon(Icons.local_shipping,color: Colors.white,size: 25,),
                                                                      SizedBox(width: 5,),
                                                                      Text('X',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400,)),
                                                                      SizedBox(width: 5,),
                                                                      Text('1',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400,)),
                                                                    ]
                                                                ),
                                                              ),
                                                              SizedBox(width: 10,),
                                                              Text('Trailler',style: TextStyle(fontFamily: FONT_FAMILY)),

                                                            ])),
                                                    Expanded(
                                                        flex:1,
                                                        child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              Icon(Icons.date_range,color: Colors.orange,size: 25,),
                                                              SizedBox(width: 5,),
                                                              Text('07/01/2021 0:00 AM',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400,)),
                                                            ])),

                                                  ]
                                              ),

                                            ],)


                                      ),

                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 0,left: 5,right: 5),
                                      width: 110,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          borderRadius: (translator.currentLanguage == 'en' ) ?  BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10))
                                              : BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                                          border: Border.all(
                                              color: Colors.grey,
                                              width: 3
                                          ),
                                          color: Colors.white
                                      ),

                                      child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            //                            Icon(Icons.local_shipping,color: Colors.white,size: 25,),
                                            SizedBox(width: 10,),
                                            Text('07/01/2021',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w700,color: Colors.grey)),
                                          ]
                                      ),
                                    ),
                                  ]),
                            ),
                            Container(
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
                                                      flex:3,
                                                      child: Text('Destnation Name',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w600,)),
                                                    ),
                                                    Expanded(
                                                      flex:1,
                                                      child: IconButton(
                                                          icon: Icon(Icons.delete,color: Colors.grey,size: 25),onPressed: () {}),
                                                    ),
                                                  ]
                                              ),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Icon(Icons.gps_fixed,color: Colors.orange,size: 25,),
                                                    SizedBox(width: 5,),
                                                    Text('loc6-Assuit-loc5-Assuit2',style: TextStyle(fontFamily: FONT_FAMILY)),
                                                  ]
                                              ),
                                              SizedBox(height: 3,),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Icon(Icons.place,color: Colors.green,size: 25,),
                                                    SizedBox(width: 5,),
                                                    Text('loc6-Assuit-loc5-Assuit2',style: TextStyle(fontFamily: FONT_FAMILY)),
                                                  ]
                                              ),
                                              SizedBox(height: 3,),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                        flex:1,
                                                        child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              Container(
                                                                width: 70,
                                                                height: 30,
                                                                decoration: BoxDecoration(
                                                                  borderRadius: (translator.currentLanguage == 'en' ) ? BorderRadius.only(topRight: Radius.circular(20),
                                                                      bottomRight: Radius.circular(20)) : BorderRadius.only(
                                                                      topLeft: Radius.circular(20),
                                                                      bottomLeft: Radius.circular(20)),
                                                                  color: Colors.orange,
                                                                ),
                                                                child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                    children: [
                                                                      Icon(Icons.local_shipping,color: Colors.white,size: 25,),
                                                                      SizedBox(width: 5,),
                                                                      Text('X',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400,)),
                                                                      SizedBox(width: 5,),
                                                                      Text('1',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400,)),
                                                                    ]
                                                                ),
                                                              ),
                                                              SizedBox(width: 10,),
                                                              Text('Trailler',style: TextStyle(fontFamily: FONT_FAMILY)),

                                                            ])),
                                                    Expanded(
                                                        flex:1,
                                                        child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              Icon(Icons.date_range,color: Colors.orange,size: 25,),
                                                              SizedBox(width: 5,),
                                                              Text('07/01/2021 0:00 AM',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400,)),
                                                            ])),

                                                  ]
                                              ),

                                            ],)


                                      ),

                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 0,left: 5,right: 5),
                                      width: 110,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          borderRadius: (translator.currentLanguage == 'en' ) ?  BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10))
                                              : BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                                          border: Border.all(
                                              color: Colors.grey,
                                              width: 3
                                          ),
                                          color: Colors.white
                                      ),

                                      child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            //                            Icon(Icons.local_shipping,color: Colors.white,size: 25,),
                                            SizedBox(width: 10,),
                                            Text('07/01/2021',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w700,color: Colors.grey)),
                                          ]
                                      ),
                                    ),
                                  ]),
                            ),
                            Container(
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
                                                      flex:3,
                                                      child: Text('Destnation Name',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w600,)),
                                                    ),
                                                    Expanded(
                                                      flex:1,
                                                      child: IconButton(
                                                          icon: Icon(Icons.delete,color: Colors.grey,size: 25),onPressed: () {}),
                                                    ),
                                                  ]
                                              ),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Icon(Icons.gps_fixed,color: Colors.orange,size: 25,),
                                                    SizedBox(width: 5,),
                                                    Text('loc6-Assuit-loc5-Assuit2',style: TextStyle(fontFamily: FONT_FAMILY)),
                                                  ]
                                              ),
                                              SizedBox(height: 3,),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Icon(Icons.place,color: Colors.green,size: 25,),
                                                    SizedBox(width: 5,),
                                                    Text('loc6-Assuit-loc5-Assuit2',style: TextStyle(fontFamily: FONT_FAMILY)),
                                                  ]
                                              ),
                                              SizedBox(height: 3,),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                        flex:1,
                                                        child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              Container(
                                                                width: 70,
                                                                height: 30,
                                                                decoration: BoxDecoration(
                                                                  borderRadius: (translator.currentLanguage == 'en' ) ? BorderRadius.only(topRight: Radius.circular(20),
                                                                      bottomRight: Radius.circular(20)) : BorderRadius.only(
                                                                      topLeft: Radius.circular(20),
                                                                      bottomLeft: Radius.circular(20)),
                                                                  color: Colors.orange,
                                                                ),
                                                                child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                    children: [
                                                                      Icon(Icons.local_shipping,color: Colors.white,size: 25,),
                                                                      SizedBox(width: 5,),
                                                                      Text('X',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400,)),
                                                                      SizedBox(width: 5,),
                                                                      Text('1',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400,)),
                                                                    ]
                                                                ),
                                                              ),
                                                              SizedBox(width: 10,),
                                                              Text('Trailler',style: TextStyle(fontFamily: FONT_FAMILY)),

                                                            ])),
                                                    Expanded(
                                                        flex:1,
                                                        child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              Icon(Icons.date_range,color: Colors.orange,size: 25,),
                                                              SizedBox(width: 5,),
                                                              Text('07/01/2021 0:00 AM',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400,)),
                                                            ])),

                                                  ]
                                              ),

                                            ],)


                                      ),

                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 0,left: 5,right: 5),
                                      width: 110,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          borderRadius: (translator.currentLanguage == 'en' ) ?  BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10))
                                              : BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                                          border: Border.all(
                                              color: Colors.grey,
                                              width: 3
                                          ),
                                          color: Colors.white
                                      ),

                                      child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            //                            Icon(Icons.local_shipping,color: Colors.white,size: 25,),
                                            SizedBox(width: 10,),
                                            Text('07/01/2021',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w700,color: Colors.grey)),
                                          ]
                                      ),
                                    ),
                                  ]),
                            ),
                            Container(
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
                                                      flex:3,
                                                      child: Text('Destnation Name',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w600,)),
                                                    ),
                                                    Expanded(
                                                      flex:1,
                                                      child: IconButton(
                                                          icon: Icon(Icons.delete,color: Colors.grey,size: 25),onPressed: () {}),
                                                    ),
                                                  ]
                                              ),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Icon(Icons.gps_fixed,color: Colors.orange,size: 25,),
                                                    SizedBox(width: 5,),
                                                    Text('loc6-Assuit-loc5-Assuit2',style: TextStyle(fontFamily: FONT_FAMILY)),
                                                  ]
                                              ),
                                              SizedBox(height: 3,),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Icon(Icons.place,color: Colors.green,size: 25,),
                                                    SizedBox(width: 5,),
                                                    Text('loc6-Assuit-loc5-Assuit2',style: TextStyle(fontFamily: FONT_FAMILY)),
                                                  ]
                                              ),
                                              SizedBox(height: 3,),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                        flex:1,
                                                        child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              Container(
                                                                width: 70,
                                                                height: 30,
                                                                decoration: BoxDecoration(
                                                                  borderRadius: (translator.currentLanguage == 'en' ) ? BorderRadius.only(topRight: Radius.circular(20),
                                                                      bottomRight: Radius.circular(20)) : BorderRadius.only(
                                                                      topLeft: Radius.circular(20),
                                                                      bottomLeft: Radius.circular(20)),
                                                                  color: Colors.orange,
                                                                ),
                                                                child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                    children: [
                                                                      Icon(Icons.local_shipping,color: Colors.white,size: 25,),
                                                                      SizedBox(width: 5,),
                                                                      Text('X',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400,)),
                                                                      SizedBox(width: 5,),
                                                                      Text('1',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400,)),
                                                                    ]
                                                                ),
                                                              ),
                                                              SizedBox(width: 10,),
                                                              Text('Trailler',style: TextStyle(fontFamily: FONT_FAMILY)),

                                                            ])),
                                                    Expanded(
                                                        flex:1,
                                                        child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              Icon(Icons.date_range,color: Colors.orange,size: 25,),
                                                              SizedBox(width: 5,),
                                                              Text('07/01/2021 0:00 AM',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400,)),
                                                            ])),

                                                  ]
                                              ),

                                            ],)


                                      ),

                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 0,left: 5,right: 5),
                                      width: 110,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          borderRadius: (translator.currentLanguage == 'en' ) ?  BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10))
                                              : BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                                          border: Border.all(
                                              color: Colors.grey,
                                              width: 3
                                          ),
                                          color: Colors.white
                                      ),

                                      child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            //                            Icon(Icons.local_shipping,color: Colors.white,size: 25,),
                                            SizedBox(width: 10,),
                                            Text('07/01/2021',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w700,color: Colors.grey)),
                                          ]
                                      ),
                                    ),
                                  ]),
                            ),
                            Container(
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
                                                      flex:3,
                                                      child: Text('Destnation Name',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w600,)),
                                                    ),
                                                    Expanded(
                                                      flex:1,
                                                      child: IconButton(
                                                          icon: Icon(Icons.delete,color: Colors.grey,size: 25),onPressed: () {}),
                                                    ),
                                                  ]
                                              ),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Icon(Icons.gps_fixed,color: Colors.orange,size: 25,),
                                                    SizedBox(width: 5,),
                                                    Text('loc6-Assuit-loc5-Assuit2',style: TextStyle(fontFamily: FONT_FAMILY)),
                                                  ]
                                              ),
                                              SizedBox(height: 3,),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Icon(Icons.place,color: Colors.green,size: 25,),
                                                    SizedBox(width: 5,),
                                                    Text('loc6-Assuit-loc5-Assuit2',style: TextStyle(fontFamily: FONT_FAMILY)),
                                                  ]
                                              ),
                                              SizedBox(height: 3,),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                        flex:1,
                                                        child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              Container(
                                                                width: 70,
                                                                height: 30,
                                                                decoration: BoxDecoration(
                                                                  borderRadius: (translator.currentLanguage == 'en' ) ? BorderRadius.only(topRight: Radius.circular(20),
                                                                      bottomRight: Radius.circular(20)) : BorderRadius.only(
                                                                      topLeft: Radius.circular(20),
                                                                      bottomLeft: Radius.circular(20)),
                                                                  color: Colors.orange,
                                                                ),
                                                                child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                    children: [
                                                                      Icon(Icons.local_shipping,color: Colors.white,size: 25,),
                                                                      SizedBox(width: 5,),
                                                                      Text('X',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400,)),
                                                                      SizedBox(width: 5,),
                                                                      Text('1',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400,)),
                                                                    ]
                                                                ),
                                                              ),
                                                              SizedBox(width: 10,),
                                                              Text('Trailler',style: TextStyle(fontFamily: FONT_FAMILY)),

                                                            ])),
                                                    Expanded(
                                                        flex:1,
                                                        child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              Icon(Icons.date_range,color: Colors.orange,size: 25,),
                                                              SizedBox(width: 5,),
                                                              Text('07/01/2021 0:00 AM',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400,)),
                                                            ])),

                                                  ]
                                              ),

                                            ],)


                                      ),

                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 0,left: 5,right: 5),
                                      width: 110,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          borderRadius: (translator.currentLanguage == 'en' ) ?  BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10))
                                              : BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                                          border: Border.all(
                                              color: Colors.grey,
                                              width: 3
                                          ),
                                          color: Colors.white
                                      ),

                                      child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            //                            Icon(Icons.local_shipping,color: Colors.white,size: 25,),
                                            SizedBox(width: 10,),
                                            Text('07/01/2021',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w700,color: Colors.grey)),
                                          ]
                                      ),
                                    ),
                                  ]),
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        );
  }
  _getTab(index, child, icon) {
    return Badge(
      position: BadgePosition.topEnd(top: -5),
      badgeColor: Colors.red,
      badgeContent: Text('${index.toString()}',style: TextStyle(color: Colors.white),),
      child: Tab(
      child: Container(
          alignment: Alignment.center,
          constraints: BoxConstraints.expand(width: 70),
//          decoration: BoxDecoration(
//              color: (_selectedTab == index ? Colors.white : Colors.grey.shade50),
////              borderRadius: _generateBorderRadius(index)
//              ),
          child:Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(icon,size: 25,),
                Text(child,style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400,))
              ]

          )
        ),
      )
    );
  }

  _generateBorderRadius(index) {
    if ((index + 1) == _selectedTab)
      return BorderRadius.only(bottomRight: Radius.circular(10.0));
    else if ((index - 1) == _selectedTab)
      return BorderRadius.only(bottomLeft: Radius.circular(10.0));
    else
      return BorderRadius.zero;
  }
}

