import 'dart:ui';
import 'package:badges/badges.dart';
import 'package:customerapp/features/requestList/data/models/request-list-data.dart';
import 'package:customerapp/features/requestList/data/models/review.dart';
import 'package:customerapp/features/requestList/presentation/bloc/request-list-bloc.dart';
import 'package:customerapp/features/requestList/presentation/bloc/request-list-events.dart';
import 'package:customerapp/features/requestList/presentation/bloc/request-list-state.dart';
import 'package:customerapp/features/share/custom-dialog.dart';
import 'package:customerapp/features/share/loading-dialog.dart';
import 'package:flutter/material.dart';
import 'package:customerapp/core/constants.dart';
import 'package:customerapp/core/services/local_storage/local_storage_service.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:rating_dialog/rating_dialog.dart';

class RequestListWidget extends StatefulWidget {
  static const routeName = 'RequestListWidget';

  RequestListWidgetState createState() => RequestListWidgetState();
}

class RequestListWidgetState extends State<RequestListWidget> with SingleTickerProviderStateMixin  {
//  var selectedIndex = 0;
  RequestListBloc _bloc = RequestListBloc(BaseRequestListState());
  TabController _tabController;
  int _selectedTab = 0;
  LocalStorageService localStorage = LocalStorageService();
  Count count = Count(approved: 0,assigned: 0,canceled: 0,completed: 0,pending: 0,rejected: 0);
  List<Request> pendingList = [];
  List<Request> approvedList = [];
  List<Request> assignedList = [];
  List<Request> rejectedList = [];
  List<Request> completedList = [];
  List<Request> canceledList = [];
  ReviewModel reviewRate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(vsync: this, length: 5);
    _bloc.add(GetPendingDataEvent());

    _tabController.addListener((){
      if (!_tabController.indexIsChanging){
        setState(() {
          _selectedTab = _tabController.index;
        });
      }
    });
  }
  showAlertDialog(title,msg,type) {
    // show the dialog
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return  AdvanceCustomAlert(title,msg,type);
      },
    );
  }
  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }
// show the rating dialog
   _showRatingDialog(Request item) {
     reviewRate = new ReviewModel(reqId: item.id, clientId: item.clientId);
    final _dialog = RatingDialog(
      title: 'Rating Dialog',
      // encourage your user to leave a high rating?
      message: 'Tap a star to set your rating. Add more description here if you want.',
      image: const FlutterLogo(size: 100),
      submitButton: 'Submit',
      onCancelled: () => print('cancelled'),
      onSubmitted: (response) {
        print('rating: ${response.rating}, comment: ${response.comment}');
        reviewRate.rate = response.rating;
        reviewRate.comment = response.comment;
        _bloc.add(ReviewRequestEvent(reviewRate));
      },
    );
    // show the dialog
    showDialog(
      context: context,
      barrierDismissible: true, // set to false if you want to force a rating
      builder: (context) => _dialog,
    );
  }

  Widget requestCard(Request item, bool pending) {
    final df = new DateFormat('dd-MM-yyyy hh:mm a');
    var outputFormat = DateFormat('MM/dd/yyyy');
    var deliverDate = outputFormat.format(item.deliverDate);
    var pickUpDate = df.format(item.pickUpDate);
    return  Container(
      child: Stack(children: <Widget>[
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
                              child: Text('${item.destinationName}',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w600,)),
                            ),
                       if(pending) Expanded(
                              flex:1,
                              child: IconButton(
                                  icon: Icon(Icons.delete,color: Colors.grey,size: 25),onPressed: () {
                                _bloc.add(CancelRequestEvent(item));
                              }),
                            ),
                       if(item.statusAsString == 'Completed')
                         Expanded(
                              flex:1,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(Icons.star,color: Colors.yellow,size: 20),
                                    Icon(Icons.star_half_rounded,color: Colors.yellow,size: 20),
                                    if(item.rated)  Text('${item.rate}',style: TextStyle(
                                      color: (item.rate > 3) ? Colors.green: (item.rate < 3) ? Colors.redAccent: Colors.yellowAccent,
                                    ),),
                                    if(!item.rated) SizedBox(width: 5,),
                                    if(!item.rated)  InkWell(
                                      child: Icon(Icons.edit,color: Colors.green,size: 20),
                                      onTap: () { _showRatingDialog(item);},
                                    ) ,
                                  ])

                            ),
                          ]
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.gps_fixed,color: Colors.orange,size: 25,),
                            SizedBox(width: 5,),
                            Text('${item.sourceDetailedAddress}',style: TextStyle(fontFamily: FONT_FAMILY)),
                          ]
                      ),
                      SizedBox(height: 3,),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.place,color: Colors.green,size: 25,),
                            SizedBox(width: 5,),
                            Text('${item.destinationDetailedAddress}',style: TextStyle(fontFamily: FONT_FAMILY)),
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
                                        width: 60,
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
                                              Text('${item.numberOfTrucks}',style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400,)),
                                            ]
                                        ),
                                      ),
                                      SizedBox(width: 5,),
                                      Text('${item.truckType}',style: TextStyle(fontFamily: FONT_FAMILY,fontSize: 12)),
                                    ])),
                            Expanded(
                                flex:1,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(Icons.date_range,color: Colors.orange,size: 25,),
                                      SizedBox(width: 5,),
                                      Text(pickUpDate, style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400,)),
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
                  borderRadius: (translator.currentLanguage == 'en' ) ? BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10))
                      : BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                  border: Border.all(color: Colors.grey, width: 3),
                  color: Colors.white
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //                            Icon(Icons.local_shipping,color: Colors.white,size: 25,),
                    SizedBox(width: 10,),
                    Text(deliverDate,style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w700,color: Colors.grey)),
                  ]
              ),
            ),
          ]),
    );
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
                      controller: _tabController,
                      isScrollable: true,
                      labelPadding: const EdgeInsets.all(6.0),
                      onTap: (value) => changeTab(value),
                      tabs: [
                        _getTab(count.pending, translator.translate('pending'),Icons.departure_board),
                        _getTab(count.approved, translator.translate('approved'),Icons.approval),
                        _getTab(count.completed, translator.translate('completed'),Icons.done),
                        _getTab(count.rejected, translator.translate('rejected'),Icons.not_interested),
                        _getTab(count.canceled, translator.translate('canceled'),Icons.cancel),
                      ],
                    ),
                  ),
                  Expanded(
                    child: BlocConsumer(
                    cubit: _bloc,
                    builder: (context, state) {
                      return TabBarView(
                        physics: NeverScrollableScrollPhysics(),
                        controller: _tabController,
                        children: [
                          //pendingItem
                          pendingList.isEmpty ? Column(
                                  children: <Widget>[
                                    SizedBox( height: 20,),
                                    Text( translator.translate('noData'),  style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400),),
                                    SizedBox( height: 20,),
                                    Container( height: 300, child: SvgPicture.asset("assets/images/empty1.svg",)),
                                  ]) :
                          ListView.builder(
                            itemBuilder: (ctx, index) {
                              final pendingItem = pendingList[index];
                              return requestCard(pendingItem, true);
                            },
                            itemCount: pendingList.length ,
                          ),
                          //approvedItem
                          approvedList.isEmpty ?  Column(
                              children: <Widget>[
                                SizedBox( height: 20,),
                                Text( translator.translate('noData'),  style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400),),
                                SizedBox( height: 20,),
                                Container( height: 300, child: SvgPicture.asset("assets/images/empty1.svg",)),
                              ]) :
                          ListView.builder(
                            itemBuilder: (ctx, index) {
                              final approvedItem = approvedList[index];
                              return requestCard(approvedItem, false);

                            },
                            itemCount: approvedList.length ,
                          ),
                          //assignedItem
                          completedList.isEmpty ? Column(
                              children: <Widget>[
                                SizedBox( height: 20,),
                                Text( translator.translate('noData'),  style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400),),
                                SizedBox( height: 20,),
                                Container( height: 300, child: SvgPicture.asset("assets/images/empty1.svg",)),
                              ]):
                          ListView.builder(
                            itemBuilder: (ctx, index) {
                              final completedItem = completedList[index];
                              return requestCard(completedItem, false);
                            },
                            itemCount: completedList.length ,
                          ),
                          // rejectedItem
                          rejectedList.isEmpty ?  Column(
                              children: <Widget>[
                                SizedBox( height: 20,),
                                Text( translator.translate('noData'),  style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400),),
                                SizedBox( height: 20,),
                                Container( height: 300, child: SvgPicture.asset("assets/images/empty1.svg",)),
                              ]) :
                          ListView.builder(
                            itemBuilder: (ctx, index) {
                              final rejectedItem = rejectedList[index];
                              return requestCard(rejectedItem, false);
                            },
                            itemCount: rejectedList.length ,
                          ),
                          //canceledItem
                          canceledList.isEmpty ?  Column(
                              children: <Widget>[
                                SizedBox( height: 20,),
                                Text( translator.translate('noData'),  style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400),),
                                SizedBox( height: 20,),
                                Container( height: 300, child: SvgPicture.asset("assets/images/empty1.svg",)),
                              ]):
                          ListView.builder(
                            itemBuilder: (ctx, index) {
                              final canceledItem = canceledList[index];
                              return requestCard(canceledItem, false);
                            },
                            itemCount: canceledList.length ,
                          ),
                        ],
                      );
                    },  listener: (context, state) {
                      if (state is PendingListSuccessState) {
                        setState(() {
                          pendingList = state.requestListData.requests;
                          count = state.requestListData.count;
                        });
                      }
                      if (state is AssignedListSuccessState) {
                        print(state.requestListData);
                        setState(() {
                         assignedList = state.requestListData.requests;
                         count = state.requestListData.count;
                        });
                      }
                      if (state is ApprovedListSuccessState) {
                        print(state.requestListData);
                        setState(() {
                          approvedList = state.requestListData.requests;
                          count = state.requestListData.count;
                        });
                      }
                      if (state is CanceledListSuccessState) {
                        print(state.requestListData.requests);
                        setState(() {
                          canceledList = state.requestListData.requests;
                          count = state.requestListData.count;
                        });
                      }
                      if (state is CompletedListSuccessState) {
                        print(state.requestListData);
                        setState(() {
                          completedList = state.requestListData.requests;
                          count = state.requestListData.count;
                        });
                      }
                      if (state is RejectedListSuccessState) {
                        print(state.requestListData);
                        setState(() {
                          rejectedList = state.requestListData.requests;
                          count = state.requestListData.count;
                        });
                      }

                      if (state is RequestListLoadingState ) loadingAlertDialog(context);
                      if (state is RequestListSuccessState) Navigator.of(context).pop();
                      if (state is RequestListFailedState) Navigator.of(context).pop();

                      if (state is RequestReviewORCancelFailedState) {
                        Navigator.of(context).pop();
                        var msg = state.error.message;
                        showAlertDialog('error', msg, false);
                      }
                      if (state is ReviewRequestSuccessState) {
                            Navigator.pop(context);
                        var successData = state.successData;
                        var msg = (translator.currentLanguage == 'en' ) ? successData.msgEN : successData.msgAR;
                          showAlertDialog('success', msg, true);
                            _bloc.add(GetCompletedDataEvent());

                      }
                      if (state is CancelRequestSuccessState) {
                        Navigator.pop(context);
                        var successData = state.successData;
                        var msg = (translator.currentLanguage == 'en' ) ? successData.msgEN : successData.msgAR;
                        showAlertDialog('success', msg, true);
                        _bloc.add(GetPendingDataEvent());

                      }
                    })
                  ),
                ],
              )
          ),
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
  changeTab(int value) {
    switch(value) {
      case 0:
        _bloc.add(GetPendingDataEvent());
        break;
      case 1:
        _bloc.add(GetApprovedDataEvent());
        break;
      case 2:
        _bloc.add(GetCompletedDataEvent());
        break;
      case 3:
        _bloc.add(GetRejectedDataEvent());
        break;
      case 4:
        _bloc.add(GetCanceledDataEvent());
        break;
    }
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

