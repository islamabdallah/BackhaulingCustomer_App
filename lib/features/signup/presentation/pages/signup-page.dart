import 'dart:ui';
import 'package:customerapp/core/constants.dart';
import 'package:customerapp/features/login/presentation/pages/login-page.dart';
import 'package:customerapp/features/share/loading-dialog.dart';
import 'package:customerapp/features/signup/presentation/bloc/signup-bloc.dart';
import 'package:customerapp/features/signup/presentation/bloc/signup-state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:customerapp/features/login/data/models/user.dart';
import 'package:customerapp/features/login/presentation/bloc/login-events.dart';
import 'package:customerapp/features/login/presentation/bloc/login-state.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../../home.dart';

class SignUpWidget extends StatefulWidget {
  static const routeName = ' SignUpWidget';

  SignUpWidgetState createState() =>  SignUpWidgetState();
}

class  SignUpWidgetState extends State< SignUpWidget> {
  SignUpBloc _bloc;
  TextEditingController companyNameController = TextEditingController();
  TextEditingController companyPhoneController = TextEditingController();
  TextEditingController companyAddressController = TextEditingController();
  TextEditingController companyIndustryController = TextEditingController();
  TextEditingController contactEmailController = TextEditingController();
  TextEditingController contactNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController contactPhoneController = TextEditingController();

  bool _userNameValidate = false;
  UserModel user = new UserModel(email: '');
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _clicked = false;
  Item selectedUser;
  List<Item> users = <Item>[
    const Item('Android','Android'),
    const Item('Flutter','Flutter'),
    const Item('ReactNative','ReactNative'),
    const Item('iOS','iOS'),
  ];

  @override
  void initState() {
    _bloc =  SignUpBloc(BaseSignUpState());
    print(translator.currentLanguage);
    super.initState();
  }
// validate Email
  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return  translator.translate('emailError');
    else
      return null;
  }

  String validatePassword(String value) {
    if (value.isEmpty)
      return  translator.translate('passwordError');
    else
      return null;
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
      return Scaffold(
//      appBar: AppBar(
//      title: Text(translator.translate('signUp'),style: TextStyle(fontFamily: FONT_FAMILY)),
//      centerTitle: true,
//    ),
    backgroundColor: Colors.white,
    body:SingleChildScrollView(
    child: Column(
          children: <Widget>[
                        ClipPath(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                  color: Colors.blue,
                  child: Center(
          child: Container(
          height: 100,
          padding: EdgeInsets.only(top:50.0),
          /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
          child: Text(translator.translate('signUp'),style: TextStyle(fontFamily: FONT_FAMILY, color: Colors.white , fontWeight: FontWeight.w400, fontSize: 25))
          ),
    ),
                ),
                clipper: CustomClipPath(),
              ),
//            Padding(
//              padding: const EdgeInsets.only(top: 30.0),
//              child: Center(
//                child: Container(
//                    width: 200,
//                    height: 125,
//                    /*decoration: BoxDecoration(
//                        color: Colors.red,
//                        borderRadius: BorderRadius.circular(50.0)),*/
//                    child: Image.asset('assets/images/cemex.jpg')),
//              ),
//            ),
            BlocConsumer(
                cubit: _bloc,
                builder: (context, state) {
                  if (state is  SignUpFailedState) {
                    if (_clicked) {
                      _clicked = false;
                      Navigator.pop(context);
                    }
                  }

                  return Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Card(
                            child: Column(
                            children: <Widget>[
                              Padding(
                                //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      labelText: translator.translate('companyName'),
                                      hintText: translator.translate('companyName'),
                                      labelStyle: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w600)
                                  ),
                                  style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400, ),
                                  keyboardType: TextInputType.text,
                                  controller: companyNameController,
                                  validator: (value) => value == null ? translator.translate('required') : null,

                                ),
                              ),
                              Padding(
                                //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10.0),
                                child: TextFormField(
                                  decoration: InputDecoration(

                                      labelText: translator.translate('companyPhone'),
                                      hintText: translator.translate('companyPhone'),
                                      labelStyle: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w600)
                                  ),
                                  style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400, ),
                                  keyboardType: TextInputType.phone,
                                  controller: companyPhoneController,
                                  validator: (value) => value == null ? translator.translate('required') : null,

                                ),
                              ),
                              Padding(
                                //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: TextFormField(
                                  decoration: InputDecoration(

                                      labelText: translator.translate('companyAddress'),
                                      hintText: translator.translate('companyAddress'),
                                      labelStyle: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w600)
                                  ),
                                  style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400, ),
                                  keyboardType: TextInputType.text,
                                  controller: companyAddressController,
                                  validator: (value) => value == null ? translator.translate('required') : null,

                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10.0),
                                  child:DropdownButtonFormField<Item>(
                                    decoration: InputDecoration(
                                        labelText: translator.translate('companyIndustry'),
                                        hintMaxLines: 1,
                                        labelStyle: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w600)
                                    ),
                                    style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400, color: Colors.black45),
                                    validator: (value) => value == null ? translator.translate('required') : null,
                                    // iconSize: 40.0,
                                    value: selectedUser,
                                    isExpanded: true,
                                    onChanged: (Item value) {
                                      setState(() {
                                        selectedUser = value;
                                      });
                                    },
                                    items: users.map((Item user) {
                                      return  DropdownMenuItem<Item>(
                                        value: user,
                                        child: Row(
                                          children: <Widget>[
                                            Text(user.name ,
                                              style:  TextStyle(fontWeight: FontWeight.w400, color: Colors.black45, fontFamily: FONT_FAMILY),
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList(),) ,
                              ),
                              Padding(
                                //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child:Row(children: [
                                    Expanded(
                                      flex: 1,
                                      child:   TextFormField(
                                          decoration: InputDecoration(

                                              labelText: translator.translate('contactName'),
                                              hintText: translator.translate('contactName'),
                                              labelStyle: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w600)
                                          ),
                                          style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400, ),
                                          keyboardType: TextInputType.text,
                                          controller: contactNameController,
                                        validator: (value) => value == null ? translator.translate('required') : null,

                                      ),),

                                    SizedBox(width:20.0),
                                    Expanded(
                                      flex: 1,
                                      child:  TextFormField(
                                        decoration: InputDecoration(

                                            labelText: translator.translate('contactPhone'),
                                            hintText: translator.translate('contactPhone'),
                                            labelStyle: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w600)
                                        ),
                                        style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400, ),
                                        keyboardType: TextInputType.phone,
                                        controller: contactPhoneController,
                                        validator: (value) => value == null ? translator.translate('required') : null,

                                      ),
                                    ),
                                  ],)
                              ),
                              Padding(
                                //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10.0),
                                child: TextFormField(
                                  decoration: InputDecoration(

                                      labelText: translator.translate('contactEmail'),
                                      hintText: translator.translate('contactEmail'),
                                      labelStyle: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w600)
                                  ),
                                  style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400, ),
                                  keyboardType: TextInputType.emailAddress,
                                  controller: contactEmailController,
                                  validator: validateEmail,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15,),
                                child: TextFormField(
                                  decoration: InputDecoration(

                                      labelText: translator.translate('password'),
                                      hintText: translator.translate('passwordHint'),
                                      labelStyle: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w600)
                                  ),
                                  style: TextStyle(fontFamily: FONT_FAMILY,fontWeight: FontWeight.w400, ),
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: true,
                                  controller: passwordController,
                                  validator: validatePassword,
                                  onChanged: (String val) {
                                    this.user?.password = passwordController.text.toString();
                                  },
                                ),
                              ),
                             SizedBox(
                                height: 15,
                             ),
                  ]),
                    color: Colors.white,
                    elevation: 0,
                          )
                          ),

                          if (state is  SignUpFailedState)  Padding(
                              padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 5, bottom: 5),
                              child:Align(child: Text(state.error.message,
                                style: TextStyle(color: Colors.red, fontFamily: FONT_FAMILY,fontWeight: FontWeight.w600),),
                            alignment: Alignment.centerRight,
                          )),
                          Container(
                            margin: EdgeInsets.only(top: 40),
                            height: 50,
                            width: MediaQuery.of(context).size.width - 30.0,
                            decoration: BoxDecoration(  color: Colors.blue, borderRadius: BorderRadius.circular(5),),
                            child: FlatButton(
                              onPressed: () {
                                if (!_formKey.currentState.validate()) {
                                  return;
                                }
                                if (_formKey.currentState.validate()) {
                                  setState(() {
                                    _clicked = true;
                                  });
                                  _bloc.add(LoginEvent(userModel: this.user));
                                  loadingAlertDialog(context);
                                }

                              },
                              child: Text(
                                translator.translate('save'),
                                style: TextStyle(color: Colors.white,  fontFamily: FONT_FAMILY,fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ]),
                  );
                },
                listener: (context, state) {
                  if (state is LoginSuccessState) {
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, HomeWidget.routeName);
                  }


                }),

            SizedBox(
              height: 30,
            ),
            Padding(
                padding: const EdgeInsets.only(left: 3.0, right: 3.0, top: 3, bottom: 3),
                child:Align(
                  child:FlatButton(
                    onPressed: () {
                      Navigator.pushNamed(context, LoginWidget.routeName);
                    },
                    child: Text(translator.translate('haveAccount'),
                      style: TextStyle(  fontFamily: FONT_FAMILY,fontWeight: FontWeight.w600),
                    ),
                  ),
                  alignment: Alignment.bottomCenter,
                )),
          ],
        ),
      ),
    );
  }
}
class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(size.width/4, size.height
        - 40, size.width/2, size.height-20);
    path.quadraticBezierTo(3/4*size.width, size.height,
        size.width, size.height-30);
    path.lineTo(size.width, 0);
    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class Item {
  const Item(this.name,this.value);
  final String name;
  final String value;
}