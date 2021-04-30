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
import 'package:simple_search_bar/simple_search_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../home.dart';

class LocationsWidget extends StatefulWidget {
  static const routeName = 'LocationsWidget';

  LocationsWidgetState createState() => LocationsWidgetState();
}

class LocationsWidgetState extends State<LocationsWidget> {
  LocationsBloc _bloc = LocationsBloc(BaseLocationsState());
  final AppBarController appBarController = AppBarController();
  List<LocationModel>  allLocations = [];
  final List<LocationModel> dataList = <LocationModel>[];
  List<LocationModel> currentDataList = <LocationModel>[];
  int page = 1;
  int pageCount = 5;
  int startAt = 0;
  int endAt;
  int totalPages = 0;
  bool active = false;
  bool notActive = false;
  bool all = true;



  @override
  void initState() {
    _bloc.add(GetLocationsDataEvent());
    super.initState();
  }

  activeTapButton({bool allBtn, bool activeBtn, bool notActiveBtn}) {
    dataList.clear();
    var data;
    if(allBtn) {
       data = allLocations;
    } else if (activeBtn) {
       data = allLocations.where((element) => element.active == true ).toList();
    } else if (notActiveBtn) {
       data = allLocations.where((element) => element.active != true ).toList();
    }
    setState(() {
      active = activeBtn;
       notActive = notActiveBtn;
       all = allBtn;
      dataList.addAll(data);
      pageInfo(reload: true);
    });
  }
  void searchValue(String value) {
    dataList.clear();
    var data = (value != '') ? allLocations.where((element) =>
        element.toJson().values.any((x) => x.toString().toLowerCase().contains(value.toLowerCase()))) : allLocations;
    setState(() {
      dataList.addAll(data);
        pageInfo(reload: true);
      });

  }
  void pageInfo({bool reload}) {
    if (reload == true) {
       page = 1;
       pageCount = 5;
       startAt = 0;
       totalPages = 0;
    }
  endAt = startAt + pageCount;
  totalPages = (dataList.length / pageCount).floor();
  if (dataList.length / pageCount > totalPages) {
    totalPages = totalPages + 1;
  }

  var dataLength =  dataList.length;
  if(endAt > dataLength) endAt = dataLength;
  currentDataList = dataList.getRange(startAt, endAt).toList();
}
  void loadPreviousPage() {
    if (page > 1) {
      setState(() {
        startAt = startAt - pageCount;
        endAt = page == totalPages
            ? endAt - currentDataList.length
            : endAt - pageCount;
        currentDataList = dataList.getRange(startAt, endAt).toList();
        page = page - 1;
      });
    }
  }
  void loadNextPage() {
    if (page < totalPages) {
      setState(() {
        startAt = startAt + pageCount;
        endAt = dataList.length > endAt + pageCount ? endAt + pageCount : dataList.length;
        currentDataList = dataList.getRange(startAt, endAt).toList();
        page = page + 1;
      });
    }
  }

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
      appBar:  SearchAppBar(
        primary: Theme.of(context).primaryColor,
    appBarController: appBarController,
    // You could load the bar with search already active
    autoSelected: false,
    searchHint: "search...",
    mainTextColor: Colors.white,
    onChange: (String value) => searchValue(value),
    //Will show when SEARCH MODE wasn't active
    mainAppBar: AppBar(
      title: Text(translator.translate('locations'),style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400)),
      centerTitle: true,
      actions: <Widget>[
        InkWell(
          child: Icon(Icons.search,),
          onTap: () {
            //This is where You change to SEARCH MODE. To hide, just
            //add FALSE as value on the stream
            activeTapButton(activeBtn: false,allBtn: true,notActiveBtn: false);

            appBarController.stream.add(true);
            },
        ),
      ],
    )
      ),
//     backgroundColor: Colors.white,

      body: Container(
          padding: EdgeInsets.only(left: 10,right: 10, top:10),
          child: BlocConsumer(
           cubit: _bloc,
               builder: (context, state) {
             return (currentDataList.isNotEmpty) ?
             Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 2.0),
          child:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              OutlinedButton.icon(
                 icon:  Icon(
                 Icons.clear_all,
                 size: 18.0,
                 color: (all == true) ? Colors.white : Colors.green,
                 ),
                 label: Text(translator.translate('all'),
                 style: TextStyle(
                 color: (all == true) ? Colors.white : Colors.green, ),),
                style: OutlinedButton.styleFrom(
                  primary: (all == true) ? Colors.white : Colors.green,
                  backgroundColor: (all == true) ? Colors.green : null,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26.0),
                      side: BorderSide(color: Colors.green)
                  ),
                ),
                onPressed: () {
                  activeTapButton(activeBtn: false,allBtn: true,notActiveBtn: false);
                },
              ),
              OutlinedButton.icon(
                onPressed: () {
                  activeTapButton(activeBtn: true,allBtn: false,notActiveBtn: false);
                },

//                shape: RoundedRectangleBorder(
//                    borderRadius: BorderRadius.circular(26.0),
//                    side: BorderSide(color: Colors.green)
//                ),
                icon:  Icon(
                  Icons.done_all,
                  size: 18.0,
                  color: (active == true) ? Colors.white : Colors.green,
                ),
                label: Text(translator.translate('active'),
                 style: TextStyle(
                 color: (active == true) ? Colors.white : Colors.green, ),),
                  style: OutlinedButton.styleFrom(
                    primary: (active == true) ? Colors.white : Colors.green,
                    backgroundColor: (active == true) ? Colors.green : null,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(26.0),
                        side: BorderSide(color: Colors.green)
                    ),
                  )              ),
              OutlinedButton.icon(
                onPressed: () {
                  activeTapButton(activeBtn: false,allBtn: false,notActiveBtn: true);
                },

//                shape: RoundedRectangleBorder(
//                    borderRadius: BorderRadius.circular(26.0),
//                    side: BorderSide(color: Colors.green)
//                ),
                icon:  Icon(
                  Icons.block,
                  size: 18.0,
                  color: (notActive == true) ? Colors.white : Colors.green,
                ),
                label: Text(translator.translate('notActive'),
                  style: TextStyle(
                    color: (notActive == true) ? Colors.white : Colors.green, ),),
                 style: OutlinedButton.styleFrom(
                 primary: (notActive == true) ? Colors.white : Colors.green,
                 backgroundColor: (notActive == true) ? Colors.green : null,
                 shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(26.0),
                 side: BorderSide(color: Colors.green)
                 ),
                 )
              ),
            ],
          ),

        ),
        Expanded(child:ListView.builder(
          itemBuilder: (ctx, index) {
            final item = currentDataList[index];
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
                            Text('${item.contactNumber}',style: TextStyle(fontFamily: FONT_FAMILY, fontSize: 10)),
                          ]
                      )),
                      ])
                    ],)


              ),

            ),
            Align(
              child:
              Container(
                margin: EdgeInsets.only(top: 20,left: 15,right: 15),
                width: 90,
                height: 30,
                child: (item.active) ?
                RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.green),
                    children: [
                      TextSpan(
                        text:  translator.translate('active'),
                      ),
                      WidgetSpan(
                        child: Icon(Icons.done_all ,color: Colors.green,size: 20,),
                      ),
                    ],
                  ),
                )
                    :
                RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.red,
                    fontSize: 14.0),
                    children: [
                      TextSpan(
                        text: translator.translate('notActive'),
                      ),
                      WidgetSpan(
                        child:  Icon(Icons.block ,color: Colors.red,size: 20,),
                      ),
                    ],
                  ),
                )
            ,
              ) ,
            alignment:(translator.currentLanguage == 'en' ) ?  Alignment.topRight :  Alignment.topLeft,)
           ,
          ]),
    );
            } ,
          itemCount: currentDataList.length ,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
    )),
        Container(
        padding: EdgeInsets.symmetric(vertical: 2.0,horizontal: 1.0),
        child:
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            OutlineButton.icon(
              onPressed: () {
                print("Outline Button is Clicked");
                Navigator.pushNamed(context, LocationWidget.routeName);
              },
              highlightedBorderColor: Colors.blue,
              borderSide: BorderSide(
                color: Colors.green,
              ),
//              shape: RoundedRectangleBorder(
//                borderRadius: BorderRadius.circular(26.0),
//              ),
              icon: const Icon(
                Icons.add,
                size: 18.0,
                color: Colors.green,
              ),
              label: Text(translator.translate('addLocation'),style: TextStyle(color: Colors.green, ),),
            ),
            Row(
                 mainAxisAlignment: MainAxisAlignment.end,
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: <Widget>[
            IconButton(
              onPressed: page > 1 ? loadPreviousPage : null,
              icon: Icon(
                Icons.arrow_back_ios,
                size: 25,
              ),
            ),
            Text("$page / $totalPages"),
            IconButton(
              onPressed: page < totalPages ? loadNextPage : null,
              icon: Icon(
                Icons.arrow_forward_ios,
                size: 25,
              ),
            ),]),
          ],
        ),

      ),
      ]):
             Column(
      children: <Widget>[
             Expanded(
                 child: Column(
                     children: <Widget>[
                       SizedBox( height: 20,),
                       Text( translator.translate('noData'),  style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400),),
                       SizedBox( height: 20,),
                       Container( height: 300, child: SvgPicture.asset("assets/images/empty1.svg",)),
                     ])
             ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 2.0,horizontal: 1.0),
          child:
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              OutlineButton.icon(
                onPressed: () {
                Navigator.pushNamed(context, LocationWidget.routeName);
                },
                highlightedBorderColor: Colors.blue,
                borderSide: BorderSide(
                  color: Colors.green,
                ),
                icon: const Icon(
                  Icons.add,
                  size: 18.0,
                  color: Colors.green,
                ),
                label: Text(translator.translate('addLocation'),style: TextStyle(color: Colors.green, ),),
              ),
            ],
          ),

        )
      ],
    );
             },
              listener: (context, state) {
                  if (state is LocationsSuccessState) {
                   print(state.locationsData.data);
                   setState(() {
                     allLocations = state.locationsData.data;
                    // dataList.addAll(allLocations);
                     activeTapButton(activeBtn: false,allBtn: true,notActiveBtn: false);
                   });
                  }
                  if (state is LocationsLoadingState ) loadingAlertDialog(context);
                  if (state is LocationsSuccessState) Navigator.of(context).pop();
                  if (state is LocationsFailedState) Navigator.of(context).pop();
                }
        )
      ),
    );
  }
}
