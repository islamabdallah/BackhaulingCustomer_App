import 'package:customerapp/core/constants.dart';
import 'package:customerapp/core/sqllite/sqlite_api.dart';
import 'package:customerapp/features/locationList/presentation/pages/locations-page.dart';
import 'package:customerapp/features/login/data/models/user.dart';
import 'package:customerapp/features/login/presentation/pages/login-page.dart';
import 'package:customerapp/features/profile/presentation/pages/profile.dart';
import 'package:customerapp/features/request/presentation/pages/request-page.dart';
import 'package:customerapp/features/requestList/presentation/pages/request-list.dart';
import 'package:customerapp/features/trips/presentation/pages/trips.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../home.dart';

class NavigationDrawer extends StatefulWidget {

  NavigationDrawerState createState() => NavigationDrawerState();
}

class NavigationDrawerState extends State<NavigationDrawer> {
   String currentLanguage = translator.currentLanguage;
   final  List<Map<String, String>>  languages = [{'name': 'arabic', 'value': 'ar' }, {'name': 'english', 'value': 'en' }];
   UserModel userModel = new UserModel();

   @override
  void initState() {
    // TODO: implement initState
     currentUser();
    super.initState();
  }

  void choiceLanguage(lang) {
    translator.setNewLanguage(
      context,
      newLanguage: lang,
      remember: true,
      restart: true,
    );
  }

  currentUser() async{
    var data =  await DBHelper.getData('cemex_user');
    setState(() {
      if (data.length > 0) userModel = UserModel.fromJson(data[0]);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
           UserAccountsDrawerHeader(
            accountName: Text(userModel?.userName ?? 'No Data'),
            accountEmail: Text(userModel?.email ?? ''),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.orange,
              child: Text(
//                userModel?.email.substring(0,1).toUpperCase() ??
                 'A',
                style: TextStyle(fontSize: 40.0),
              ),
            ),

          ),

          ListTile(
            leading: Icon(Icons.person, color: Colors.blue,),
            title: Text(translator.translate('myAccount'),
                style: TextStyle(fontFamily: FONT_FAMILY, fontWeight: FontWeight.w400,)),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, ProfileWidget.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.home,color: Colors.blue,),
           title: Text(translator.translate('homeTitle'),
               style: TextStyle(fontFamily: FONT_FAMILY, fontWeight: FontWeight.w400,)),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, HomeWidget.routeName);
            },
          ),
          ListTile(
            leading:   Icon(Icons.local_shipping,color: Colors.blue,),
            title: Text(translator.translate('requestHeader'),
                style: TextStyle(fontFamily: FONT_FAMILY, fontWeight: FontWeight.w400,)),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, RequestWidget.routeName);
            },
          ),
          ListTile(
            leading:   Icon(Icons.featured_play_list,color: Colors.blue,),
            title: Text(translator.translate('requestList'),
                style: TextStyle(fontFamily: FONT_FAMILY, fontWeight: FontWeight.w400,)),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, RequestListWidget.routeName);
            },
          ),
          ListTile(
            leading:   Icon(Icons.place,color: Colors.blue,),
            title: Text(translator.translate('locations'),
                style: TextStyle(fontFamily: FONT_FAMILY, fontWeight: FontWeight.w400,)),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, LocationsWidget.routeName);
            },
          ),
          ListTile(
            leading:   Icon(Icons.map,color: Colors.blue,),
            title: Text(translator.translate('truckMap'),
                style: TextStyle(fontFamily: FONT_FAMILY, fontWeight: FontWeight.w400,)),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, TripsWidget.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.language,color: Colors.blue,),
            title: PopupMenuButton<String>(
              child: Text(translator.translate('language'),style: TextStyle(fontFamily: FONT_FAMILY, fontWeight: FontWeight.w400,)),
              onSelected: choiceLanguage,
              initialValue: currentLanguage,
              itemBuilder: (BuildContext context) {
              return languages.map((Map<String, String> lang) {
                return PopupMenuItem<String>(
                  value: lang['value'],
                  child: Text(translator.translate(lang['name']) ,
                      style: TextStyle(fontFamily: FONT_FAMILY, fontWeight: FontWeight.w400,)),
                );
              }).toList();
              },),
            onTap: () {
         //     Navigator.pop(context);
            },
          ),
          Divider(),
          ListTile(
            leading:   Icon(Icons.logout,color: Colors.red,),
            title: Text(translator.translate('logout'),
                style: TextStyle(fontFamily: FONT_FAMILY, fontWeight: FontWeight.w400,)),
            onTap: () {
              DBHelper.deleteUser(userModel.id);
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, LoginWidget.routeName);
            },
          ),
        ],
      ),
    );
  }
  
}