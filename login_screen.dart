import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:j/shared.dart';
import 'package:j/student.dart';
import 'package:j/teacher.dart';

import 'model.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormState>();
  String _email,_password;
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _icon = true;
  bool _loading = false;

  StreamSubscription<Event> _onUserAddedSubscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _onUserAddedSubscription = userReference.child('Users').onChildAdded.listen(_onUserAdded);
  }
  //
  List<Users> _allUser = new List();
  void _onUserAdded(Event event) {
    Users users = new Users.fromSnapshot(event.snapshot);
    setState(() {
      _allUser.add(users);
    });
  }
  //
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              SizedBox(height: 100,),
              Container(
                height: 150,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: Image.asset('lib/assets/cover.png',).image,
                    fit: BoxFit.cover
                  )
                ),
              ),
              SizedBox(height: 180,),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.grey[300])),
                      margin:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: TextFormField(
                          onChanged: (val) {
                            setState(() {
                              _email = val;
                            });
                          },
                          validator: (un)=>un.isEmpty
                              ? '        ادخل البريد الالكتروني'
                              : !un.contains('@gmail')
                              ? '        البريد الالكتروني يجب ان يحتوي على gmail@'
                              : !un.contains('.com')
                              ? '        البريد الالكتروني يجب أن ينتهي ب com.'
                              : null,
                          keyboardType: TextInputType.emailAddress,
                          cursorColor: Color(0xFFf4c06a),
                          decoration: decoration1.copyWith(
                            hintText: 'البريد الالكتروني',
                            prefixIcon: Icon(FontAwesomeIcons.userSecret,size: 20,color: Color(0xFFf4c06a)),
                          )
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.grey[300])),
                      margin:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: TextFormField(
                          onChanged: (val) {
                            setState(() {
                              _password = val;
                            });
                          },
                          validator: (password)=>password.isEmpty
                              ? '        ادخل كلمة المرور'
                              : password.length < 6
                              ? '        كلمة المرور يجب ان تحتوي على 6 عناصر على الاقل'
                              : null,
                          keyboardType: TextInputType.text,
                          cursorColor: Color(0xFFf4c06a),
                          obscureText: _icon,
                          decoration: decoration1.copyWith(
                              hintText: 'كلمة المرور',
                              prefixIcon: Icon(FontAwesomeIcons.key,size: 20,color: Color(0xFFf4c06a),),
                              suffixIcon: IconButton(
                                onPressed: (){
                                  setState(() {
                                    _icon = !_icon;
                                  });
                                },
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                icon: _icon ? Icon(FontAwesomeIcons.eye ,color: Colors.grey,size: 20,) : Icon(FontAwesomeIcons.eyeSlash ,color: Colors.grey,size: 20,),
                              )
                          )
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    color: Color(0xFFf4c06a),
                    onPressed: () async {
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: _email, password: _password
                        ).then((user){
                          if(user.user != null){
                            _checkTypeOfUser(_email);
                          }
                        });
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: Text(
                       'تسجيل الدخول',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white,fontFamily: 'Cairo'),
                      ),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    onPressed: () {},
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: Text(
                        'نسيت كلمة المرور',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, color: Color(0xFFf4c06a),fontFamily: 'Cairo'),
                      ),
                    ),
                    highlightColor: Colors.cyan.withOpacity(0.3),
                    splashColor: Colors.cyan.withOpacity(0.1),
                  )
                ],
              ),
              
            ],
          ),
        )
      ),
    );
  }
  //----------------------------------------------------------------------------
   _checkTypeOfUser(String email){
    for(int i=0 ; i<_allUser.length ; i++){
      if(email == _allUser[i].emailUser && _allUser[i].typeUser == false){
        Navigator.of(context).pushAndRemoveUntil(
          CupertinoPageRoute(builder: (_) => Student(_allUser[i].nameUser))
        ,
          (Route<dynamic> route) => false
        );
      }
      else if(email == _allUser[i].emailUser && _allUser[i].typeUser == true){
        Navigator.of(context).pushAndRemoveUntil(
            CupertinoPageRoute(builder: (_) => Teacher(_allUser[i].nameUser))
            ,
                (Route<dynamic> route) => false
        );
      }
    }
  }
  //----------------------------------------------------------------------------
  var userReference = FirebaseDatabase.instance.reference();
  //----------------------------------------------------------------------------
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _onUserAddedSubscription.cancel();
  }
  //----------------------------------------------------------------------------
}
