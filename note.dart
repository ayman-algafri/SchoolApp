import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'model.dart';

class Note extends StatefulWidget {
  String _className;
  Note(this._className);
  @override
  _NoteState createState() => _NoteState();
}

class _NoteState extends State<Note> {
  bool _changeNote = true;
  Color _color1 = Color(0xFFf4c06a);
  Color _color2 = Colors.white;
  String _currentEmail;

    StreamSubscription<Event> _onNoteAddedSubscription;
    StreamSubscription<Event> _onUserAddedSubscription;

    @override
  void initState() {
    // TODO: implement initState
    super.initState();
        _onNoteAddedSubscription = noteReference.child('Notes').onChildAdded.listen(_onNoteAdded);
    _onUserAddedSubscription = userReference.child('Users').onChildAdded.listen(_onUserAdded);
    FirebaseAuth.instance.currentUser().then((user){_currentEmail = user.email;});
  }

    List<Notes> _allNote = new List();
  void _onNoteAdded(Event event) {
    Notes notes = new Notes.fromSnapshot(event.snapshot);
    setState(() {
      _allNote.add(notes);
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
            Text('الملاحظات',style: Theme.of(context).textTheme.title.copyWith(color: Colors.grey,fontWeight: FontWeight.bold),),
            SizedBox(width: 10,),
            Icon(FontAwesomeIcons.pencilAlt,color: Colors.grey,size: 18,)
          ],),
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(25),
                  width: double.infinity,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: InkWell(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(50),
                              topRight: Radius.circular(50)
                            ),
                            onTap: (){
                              setState(() {
                                this._color1 = Color(0xFFf4c06a);
                                this._color2 = Colors.white;
                                this._changeNote = true;
                              });
                            },
                          child: Container(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: _color1,
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(50),
                              topRight: Radius.circular(50)
                            ),
                            border: Border.all(color: Color(0xFFf4c06a),width: 2)
                          ),
                          child: Text('ملاحظات قديمة',style: Theme.of(context).textTheme.title,),
                        ),
                        )
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: (){
                            setState(() {
                                this._color1 = Colors.white;
                                this._color2 = Color(0xFFf4c06a);
                                this._changeNote = false;
                              });
                          },
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(50),
                              topLeft: Radius.circular(50)),
                          child: Container(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: _color2,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(50),
                              topLeft: Radius.circular(50)
                            ),
                            border: Border.all(color: Color(0xFFf4c06a),width: 2)
                          ),
                          child: Text('ملاحظات جديدة',style: Theme.of(context).textTheme.title,),
                        ),
                        )
                      ),
                      
                    ],
                  )
                ),
               Expanded(
                 child: Container(
                   child:  ListView.builder(
                  itemCount: _allNote.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context , index) {
                    if(widget._className == _allNote[index].classNote){
                      return Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(15)),
                      margin: EdgeInsets.symmetric(horizontal: 25,vertical: 5),
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Icon(FontAwesomeIcons.bookMedical,color: Colors.orangeAccent.withOpacity(0.5),),
                          backgroundColor: Colors.transparent,
                          ),
                        title: Text(_allNote[index].objectNote),
                        subtitle: Text(_allNote[index].content),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(_allNote[index].dateNote,textDirection: TextDirection.ltr,),
                            Text(_allNote[index].timeNote,textDirection: TextDirection.ltr,)
                          ],
                        ),
                      ),
                    );
                    }
                    return Container();
                  },
                ),
                 ),
               )
          ],
        ),
      ),
    );
  }
  var noteReference = FirebaseDatabase.instance.reference();
  var userReference = FirebaseDatabase.instance.reference();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _onNoteAddedSubscription.cancel();
    _onUserAddedSubscription.cancel();
  }
}