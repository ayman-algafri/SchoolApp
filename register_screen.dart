import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:j/shared.dart';
import 'model.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String _name,_class,_object,_email,_password = '';
  int _group = 0;
  String _id = '';

  
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
        body: ListView(
          children: <Widget>[
            SizedBox(height: 150,),
            Container(
               decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.grey[300])),
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: RadioListTile(
                groupValue: _group,
                onChanged: (val){
                  setState(() {
                    _group = val;
                  });
                },
                value: 0,
                activeColor: Color(0xFFf4c06a),
                title: Text('استاذ'),
              )
            ),
            Container(
               decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.grey[300])),
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: RadioListTile(
                groupValue: _group,
                onChanged: (val){
                  setState(() {
                    _group = val;
                  });
                },
                value: 1,
                activeColor: Color(0xFFf4c06a),
                title: Text('طالب'),
              )
            ),
            _group == 1 ? Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.grey[300])),
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextFormField(
                  onChanged: (val) {
                    setState(() {
                      _id = val;
                    });
                  },
                
                  keyboardType: TextInputType.text,
                  cursorColor: Color(0xFFf4c06a),
                  decoration: decoration1.copyWith(
                    hintText: 'رقم الطالب',
                    prefixIcon: Icon(
                      FontAwesomeIcons.objectGroup,
                      size: 20,
                      color: Color(0xFFf4c06a),
                    ),
                  )),
            ) : Container(),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.grey[300])),
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextFormField(
                  onChanged: (val) {
                    setState(() {
                      _name = val;
                    });
                  },
                
                  keyboardType: TextInputType.text,
                  cursorColor: Color(0xFFf4c06a),
                  decoration: decoration1.copyWith(
                    hintText: 'الاسم',
                    prefixIcon: Icon(
                      FontAwesomeIcons.userSecret,
                      size: 20,
                      color: Color(0xFFf4c06a),
                    ),
                  )),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.grey[300])),
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextFormField(
                  onChanged: (val) {
                    setState(() {
                      _class = val;
                    });
                  },
                
                  keyboardType: TextInputType.text,
                  cursorColor: Color(0xFFf4c06a),
                  decoration: decoration1.copyWith(
                    hintText: 'الفصل',
                    prefixIcon: Icon(
                      FontAwesomeIcons.mailBulk,
                      size: 20,
                      color: Color(0xFFf4c06a),
                    ),
                  )),
            ),
            _group == 0 ? Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.grey[300])),
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextFormField(
                  onChanged: (val) {
                    setState(() {
                      _object = val;
                    });
                  },
                
                  keyboardType: TextInputType.text,
                  cursorColor: Color(0xFFf4c06a),
                  decoration: decoration1.copyWith(
                    hintText: 'المادة',
                    prefixIcon: Icon(
                      FontAwesomeIcons.objectGroup,
                      size: 20,
                      color: Color(0xFFf4c06a),
                    ),
                  )),
            ) : Container(),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.grey[300])),
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextFormField(
                  onChanged: (val) {
                    setState(() {
                      _email = val;
                    });
                  },
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: Colors.cyan,
                  decoration: decoration1.copyWith(
                    hintText: 'البريد الالكتروني',
                    prefixIcon: Icon(
                      FontAwesomeIcons.userSecret,
                      size: 20,
                      color: Colors.cyan,
                    ),
                  )),
            ),
             Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.grey[300])),
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextFormField(
                  onChanged: (val) {
                    setState(() {
                      _password = val;
                    });
                  },
                  keyboardType: TextInputType.text,
                  cursorColor: Colors.cyan,
                  decoration: decoration1.copyWith(
                    hintText: 'كلمة المرور',
                    prefixIcon: Icon(
                      FontAwesomeIcons.userSecret,
                      size: 20,
                      color: Colors.cyan,
                    ),
                  )),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child:RaisedButton(
                onPressed: ()async{
                  await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password)
                  .then((user){
                    if(user.user != null){
                      addUser(
                        new Users(_group == 0 ? true : false , _name, _email, _class, _password,
                         false, DateTimeFormat.getFormatTime(), DateTimeFormat.getFormatDate(),
                         objectNameUser: _object
                         )
                      );
                    }
                  });
                },
                color: Color(0xFFf4c06a),
                child: Text('حفظ البيانات استاذ',style:TextStyle(fontFamily: 'Cairo',fontWeight: FontWeight.bold)),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child:RaisedButton(
                onPressed: ()async{
                  await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password)
                  .then((user){
                    if(user.user != null){
                      addUser(
                        new Users(_group == 0 ? true : false , _name, _email, _class, _password,
                         false, DateTimeFormat.getFormatTime(), DateTimeFormat.getFormatDate(),
                         stuId: _id
                         )
                      );
                    }
                  });
                },
                color: Color(0xFFf4c06a),
                child: Text('حفظ البيانات طالب',style:TextStyle(fontFamily: 'Cairo',fontWeight: FontWeight.bold) ,),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //----------------------------------------------------------------------------
  bool _checkIfEmailExisting() {
    for (int i = 0; i < _allUser.length; i++) {
      if (_email == _allUser[i].emailUser) {
        return true;
      }
    }
    return false;
  }

  //----------------------------------------------------------------------------
  var userReference = FirebaseDatabase.instance.reference();
  DatabaseReference getUserReference() {
    userReference = userReference.root();
    return userReference;
  }

  void addUser(Users users) {
    userReference = getUserReference();
    userReference.child('Users').push().set(users.toSnapshot());
  }

  //----------------------------------------------------------------------------
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _onUserAddedSubscription.cancel();
  }
  //----------------------------------------------------------------------------
}
