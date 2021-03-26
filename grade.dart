import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:j/model.dart';

class Grade extends StatefulWidget {
  String _id;
  Grade(this._id);
  @override
  _GradeState createState() => _GradeState();
}

class _GradeState extends State<Grade> {
  String _typeGrade = 'رياضيات';
    bool _isShow = false;
  double _heightContainer = 0.0;
    String _currentEmail;

    StreamSubscription<Event> _onGradeAddedSubscription;
    StreamSubscription<Event> _onUserAddedSubscription;

    @override
  void initState() {
    // TODO: implement initState
    super.initState();
        _onGradeAddedSubscription = gradeReference.child('Grades').onChildAdded.listen(_onGradeAdded);
    _onUserAddedSubscription = userReference.child('Users').onChildAdded.listen(_onUserAdded);
    FirebaseAuth.instance.currentUser().then((user){_currentEmail = user.email;});
  }

    List<Grades> _allGrade = new List();
  void _onGradeAdded(Event event) {
    Grades grades = new Grades.fromSnapshot(event.snapshot);
    setState(() {
      _allGrade.add(grades);
    });
  }
    List<Users> _allUser = new List();
  void _onUserAdded(Event event) {
    Users users = new Users.fromSnapshot(event.snapshot);
    setState(() {
      _allUser.add(users);
    });
  }
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
            Text('درجاتي',style: Theme.of(context).textTheme.title.copyWith(color: Colors.grey,fontWeight: FontWeight.bold),),
            SizedBox(width: 10,),
            Icon(FontAwesomeIcons.chartLine,color: Colors.grey,size: 18,)
          ],),
        ),
        body: ListView.builder(
                   itemCount: _allGrade.length,
                   itemBuilder: (context , index) {
                     if(widget._id == _allGrade[index].studentId){
                       return Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 5),
                margin: EdgeInsets.all(25),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Color(0xFFf4c06a),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(FontAwesomeIcons.stickyNote),
                    SizedBox(width: 10,),
                    Text('درجة اعمال الفصل',style: Theme.of(context).textTheme.title,)
                  ],
                )
              ),
              Card(
                        margin:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Column(
                          mainAxisSize:MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              onTap: (){
                                setState(() {
                                    _isShow ? _heightContainer = 0.0 : _heightContainer = 150.0;
                                    _isShow = !_isShow;
                                  });
                              },
                              title: Text(_typeGrade),
                              trailing: _isShow ? Icon(Icons.expand_less) : Icon(Icons.expand_more),
                            ),
                            AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.ease,
                              height: _heightContainer,
                              child: ListView(
                                physics: BouncingScrollPhysics(),
                                children: <Widget>[
                                  ListTile(
                                    title: Text('رياضيات'),
                                    onTap: (){
                                      setState(() {
                                        _typeGrade = 'رياضيات';
                                        _isShow ? _heightContainer = 0.0 : _heightContainer = 150.0;
                                    _isShow = !_isShow;
                                      });
                                    },
                                  ),
                                  ListTile(
                                    title: Text('تربية اسلامية'),
                                    onTap: (){
                                      setState(() {
                                        _typeGrade = 'تربية اسلامية';
                                        _isShow ? _heightContainer = 0.0 : _heightContainer = 150.0;
                                    _isShow = !_isShow;
                                      });
                                    },
                                  ),
                                  ListTile(
                                    title: Text('لغة انجليزية'),
                                    onTap: (){
                                      setState(() {
                                        _typeGrade = 'لغة انجليزية';
                                        _isShow ? _heightContainer = 0.0 : _heightContainer = 150.0;
                                    _isShow = !_isShow;
                                      });
                                    },
                                  ),
                                  ListTile(
                                    title: Text('قران كريم'),
                                    onTap: (){
                                      setState(() {
                                        _typeGrade = 'قران كريم';
                                        _isShow ? _heightContainer = 0.0 : _heightContainer = 150.0;
                                    _isShow = !_isShow;
                                      });
                                    },
                                  ),
                                  ListTile(
                                    title: Text('اجتماعيات'),
                                    onTap: (){
                                      setState(() {
                                        _typeGrade = 'اجتماعيات';
                                        _isShow ? _heightContainer = 0.0 : _heightContainer = 150.0;
                                    _isShow = !_isShow;
                                      });
                                    },
                                  ),
                                  ListTile(
                                    title: Text('علوم'),
                                    onTap: (){
                                      setState(() {
                                        _typeGrade = 'علوم';
                                        _isShow ? _heightContainer = 0.0 : _heightContainer = 150.0;
                                     _isShow = !_isShow;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      ),
                      Card(
                        margin:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Column(
                          children: <Widget>[
                            ListTile(title: Center(child: Text(_typeGrade),),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text('شفوي',style: Theme.of(context).textTheme.title.copyWith(color: Color(0xFFf4c06a),fontWeight: FontWeight.bold)),
                                Text('تحريري',style: Theme.of(context).textTheme.title.copyWith(color: Color(0xFFf4c06a),fontWeight: FontWeight.bold)),
                                Text('واجبات',style: Theme.of(context).textTheme.title.copyWith(color: Color(0xFFf4c06a),fontWeight: FontWeight.bold)),
                                Text('حضور',style: Theme.of(context).textTheme.title.copyWith(color: Color(0xFFf4c06a),fontWeight: FontWeight.bold)),
                              ],
                            ),
                            SizedBox(height: 10,)
                          ],
                        ),
                      ),
                      Card(
                        margin:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 15,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text('20',style: Theme.of(context).textTheme.title.copyWith(color: Color(0xFFf4c06a),fontWeight: FontWeight.bold,fontSize: 30)),
                                Text('50',style: Theme.of(context).textTheme.title.copyWith(color: Color(0xFFf4c06a),fontWeight: FontWeight.bold,fontSize: 30)),
                                Text('20',style: Theme.of(context).textTheme.title.copyWith(color: Color(0xFFf4c06a),fontWeight: FontWeight.bold,fontSize: 30)),
                                Text('10',style: Theme.of(context).textTheme.title.copyWith(color: Color(0xFFf4c06a),fontWeight: FontWeight.bold,fontSize: 30)),
                              ],
                            ),
                            Divider(height: 20,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text('20',style: Theme.of(context).textTheme.title.copyWith(fontWeight: FontWeight.bold,fontSize: 25)),
                                Text('50',style: Theme.of(context).textTheme.title.copyWith(fontWeight: FontWeight.bold,fontSize: 25)),
                                Text('20',style: Theme.of(context).textTheme.title.copyWith(fontWeight: FontWeight.bold,fontSize: 25)),
                                Text('10',style: Theme.of(context).textTheme.title.copyWith(fontWeight: FontWeight.bold,fontSize: 25)),
                              ],
                            ),
                            SizedBox(height: 15,)
                          ],
                        ),
                      )
            ],
          );
                     }
                     return Container();
                   },
        ),
      ),
    );
  }
    var userReference = FirebaseDatabase.instance.reference();
  var gradeReference = FirebaseDatabase.instance.reference();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _onGradeAddedSubscription.cancel();
    _onUserAddedSubscription.cancel();
  }
}