import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:j/model.dart';
import 'package:j/shared.dart';

class AddHW extends StatefulWidget {
  String _objectName;
  AddHW(this._objectName);
  @override
  _AddHWState createState() => _AddHWState();
}

class _AddHWState extends State<AddHW> {
  String _contentHW = '';
  String _currentEmail;

      StreamSubscription<Event> _onHwAddedSubscription;
    StreamSubscription<Event> _onUserAddedSubscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _onHwAddedSubscription = hwReference.child('HWs').onChildAdded.listen(_onHwAdded);
    _onUserAddedSubscription = userReference.child('Users').onChildAdded.listen(_onUserAdded);
    FirebaseAuth.instance.currentUser().then((user){_currentEmail = user.email;});
  }
  //
  List<HWs> _allHW = new List();
  void _onHwAdded(Event event) {
    HWs hWs = new HWs.fromSnapshot(event.snapshot);
    setState(() {
      _allHW.add(hWs);
    });
  }
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
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            Text('إضافة واجب',style: Theme.of(context).textTheme.title.copyWith(color: Colors.grey,fontWeight: FontWeight.bold),),
            SizedBox(width: 10,),
            Icon(FontAwesomeIcons.plus,color: Colors.grey,size: 18,)
          ],),
        ),
          body: ListView(
            children: <Widget>[
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.87,
                  child: Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                          padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                        width: double.infinity,
                         decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Color(0xFFf4c06a),width: 2)
                          ),
                          child: Text(widget._objectName,style: Theme.of(context).textTheme.subhead),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                          padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                             color: Colors.grey[200],
                          ),
                          child: TextFormField(
                            onChanged: (text){
                              setState(() {
                                _contentHW = text;
                              });
                            },
                            cursorColor: Color(0xFFf4c06a),
                            keyboardType: TextInputType.multiline,
                            maxLines: 20,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'اكتب الواجب ...',
                              hintStyle: Theme.of(context).textTheme.title.copyWith(color: Colors.grey[600])
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                        child: RaisedButton(
                          onPressed: (){
                          String _currentNameUser = _getCurrentName();
                          String _currentObjectName = _getCurrentObject();
                          String _currentClassName = _getCurrentClass();
                          addHw(
                            new HWs(_currentEmail, _currentNameUser, _contentHW, _currentObjectName, _currentClassName,DateTimeFormat.getFormatTime(), DateTimeFormat.getFormatDate())
                          );
                          Navigator.of(context).pop();
                          },
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          child: Text('نشر الواجب',style: Theme.of(context).textTheme.button.copyWith(color: Colors.white),),
                          color: Color(0xFFf4c06a),
                        ),
                      )
                    ],
                  ),
                ),
              ),

            ],
          ),
      ),
    );
  }

        String _getCurrentClass(){
      for(int i=0 ; i<_allUser.length ; i++){
        if(_currentEmail == _allUser[i].emailUser){
        return _allUser[i].classNameUser;
      }
      }
      return '';
    }

    String _getCurrentObject(){
      for(int i=0 ; i<_allUser.length ; i++){
        if(_currentEmail == _allUser[i].emailUser){
        return _allUser[i].objectNameUser;
      }
      }
      return '';
    }

    String _getCurrentName(){
    for(int i=0 ; i<_allUser.length ; i++){
      if(_currentEmail == _allUser[i].emailUser){
        return _allUser[i].nameUser;
      }
    }
    return '';
  }
      //----------------------------------------------------------------------------
    var userReference = FirebaseDatabase.instance.reference();
  var hwReference = FirebaseDatabase.instance.reference();
  DatabaseReference getHwReference() {
    hwReference = hwReference.root();
    return hwReference;
  }

  void addHw(HWs hWs) {
    hwReference = getHwReference();
    hwReference.child('HWs').push().set(hWs.toSnapshot());
  }

  //----------------------------------------------------------------------------
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _onHwAddedSubscription.cancel();
    _onUserAddedSubscription.cancel();
  }
  //----------------------------------------------------------------------------
}