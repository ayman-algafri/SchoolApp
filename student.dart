import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:j/grade.dart';
import 'package:j/login_screen.dart';

import 'degree_display_page.dart';
import 'homework.dart';
import 'model.dart';
import 'note.dart';

class Student extends StatefulWidget {
  String _currentName;
  Student(this._currentName);
  @override
  _StudentState createState() => _StudentState();
}

class _StudentState extends State<Student> {
  String _currentEmail;

  StreamSubscription<Event> _onUserAddedSubscription;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _onUserAddedSubscription = userReference.child('Users').onChildAdded.listen(_onUserAdded);
    FirebaseAuth.instance.currentUser().then((user){_currentEmail = user.email;});
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
    double _height = MediaQuery.of(context).size.height * 0.20;
    double _width = MediaQuery.of(context).size.width * 0.40;
    return Directionality(
        textDirection: TextDirection.rtl,
        child:  Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
            icon: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 4.0,
                    width: 18.0,
                    decoration: BoxDecoration(
                      color: Color(0xFFf4c06a),
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Container(
                    height: 4.0,
                    width: 12.0,
                    decoration: BoxDecoration(
                      color: Color(0xFFf4c06a),
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                  ),
                ],
              ),
            ),
            onPressed: (){
            },
            tooltip: 'فتح القائمة الجانبية',
          ),
          title: Text(widget._currentName,style: Theme.of(context).textTheme.title.copyWith(color: Colors.black)),
          actions: <Widget>[
            IconButton(
              icon: CircleAvatar(
                backgroundColor: Colors.grey[200],
                child: Icon(FontAwesomeIcons.userAlt,size: 15,color: Colors.grey[600],),
              ),
              onPressed: (){
                showModalBottomSheet(context: context, builder: (_){
                return Directionality(
                  textDirection: TextDirection.rtl,
                                  child: Container(
                    child: ListTile(
                      leading: Icon(FontAwesomeIcons.doorOpen,size: 18,color: Colors.grey[400],),
                      title: Text('تسجيل الخروج'),
                      onTap: ()async{
                        await FirebaseAuth.instance.signOut().then((_){
                          Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(builder: (_) => LoginScreen()), (Route<dynamic> route) => false );
                        });
                      },
                    ),
                  ),
                );
              });
              },
            )
          ],
          ),
          body: ListView(
                children: <Widget>[
                  SizedBox(height: 50,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                    Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: InkWell(
                        child: Container(
                        height: _height,
                        width: _width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Icon(FontAwesomeIcons.bookMedical,color: Color(0xFFf4c06a),size: 50,),
                            //Image.asset('lib/assets/book.png',color: Colors.orangeAccent,height: 60,width: 60,),
                            Text('الواجبات',style: Theme.of(context).textTheme.headline.copyWith(fontFamily:'Cairo',color: Color(0xFFf4c06a),fontWeight: FontWeight.w500),)
                          ],
                        ),
                      ),
                      onTap: (){
                        String _currentNameClass = _getCurrentClass();
                        Navigator.of(context).push(CupertinoPageRoute(builder: (_) => Homework(_currentNameClass)));
                      },
                      borderRadius: BorderRadius.circular(10),
                      )
                    ),
                    Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: InkWell(
                        child: Container(
                        height: _height,
                        width: _width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Icon(FontAwesomeIcons.chartBar,color: Color(0xFFf4c06a),size: 50,),
                            //Image.asset('lib/assets/im1.png',color: Colors.orangeAccent,height: 100,width: 100,),
                            Text('الدرجات',style: Theme.of(context).textTheme.headline.copyWith(fontFamily:'Cairo',color: Color(0xFFf4c06a),fontWeight: FontWeight.w500),)
                          ],
                        ),
                      ),
                      onTap: (){
                        Navigator.of(context).push(CupertinoPageRoute(builder: (_) => DegreeDisplay()));
                      },
                      borderRadius: BorderRadius.circular(10),
                      )
                    ),
                  ],
                  ),
                  SizedBox(height: 50,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                    Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: InkWell(
                        child: Container(
                        height: _height,
                        width: _width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Icon(FontAwesomeIcons.checkSquare,color: Color(0xFFf4c06a),size: 50,),
                            //Image.asset('lib/assets/im6.png',color: Colors.orangeAccent,height: 60,width: 60,),
                            Text('تحضير الطالب',style: Theme.of(context).textTheme.headline.copyWith(fontFamily:'Cairo',color: Color(0xFFf4c06a),fontWeight: FontWeight.w500),)
                          ],
                        ),
                      ),
                      onTap: (){},
                      borderRadius: BorderRadius.circular(10),
                      )
                    ),
                    Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: InkWell(
                        child: Container(
                        height: _height,
                        width: _width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Icon(FontAwesomeIcons.notesMedical,color: Color(0xFFf4c06a),size: 50,),
                            //Image.asset('lib/assets/im4.png',color: Colors.orangeAccent,height: 60,width: 60,),
                            Text('الملاحضات',style: Theme.of(context).textTheme.headline.copyWith(fontFamily:'Cairo' ,color: Color(0xFFf4c06a),fontWeight: FontWeight.w500),)
                          ],
                        ),
                      ),
                      onTap: (){
                        String _currentNameClass = _getCurrentClass();
                        Navigator.of(context).push(CupertinoPageRoute(builder: (_) => Note(_currentNameClass)));
                      },
                      borderRadius: BorderRadius.circular(10),
                      )
                    ),
                  ],
                  )
                ],
              )
        )
      );
  }

      String _getId(){
      for(int i=0 ; i<_allUser.length ; i++){
        if(_currentEmail == _allUser[i].emailUser){
        return _allUser[i].stuId;
      }
      }
      return '';
    }

    String _getCurrentClass(){
      for(int i=0 ; i<_allUser.length ; i++){
        if(_currentEmail == _allUser[i].emailUser){
        return _allUser[i].classNameUser;
      }
      }
      return '';
    }

  var userReference = FirebaseDatabase.instance.reference();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _onUserAddedSubscription.cancel();
  }
}
