import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:j/model.dart';
import 'package:j/shared.dart';

class AddNote extends StatefulWidget {
  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  String _contentNote = '';
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
  //
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
            Text('إضافة ملاحظة',style: Theme.of(context).textTheme.title.copyWith(color: Colors.grey,fontWeight: FontWeight.bold),),
            SizedBox(width: 10,),
            Icon(FontAwesomeIcons.pencilAlt,color: Colors.grey,size: 18,)
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
                                _contentNote = text;
                              });
                            },
                            cursorColor: Color(0xFFf4c06a),
                            keyboardType: TextInputType.multiline,
                            maxLines: 20,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'اكتب الملاحظة ...',
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
                          addNote(
                            new Notes(_currentEmail, _currentNameUser, _contentNote,_currentObjectName,_currentClassName, DateTimeFormat.getFormatTime(), DateTimeFormat.getFormatDate())
                          );
                          Navigator.of(context).pop();
                          },
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          child: Text('نشر الملاحظة',style: Theme.of(context).textTheme.button.copyWith(color: Colors.white),),
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
  var noteReference = FirebaseDatabase.instance.reference();
  DatabaseReference getNoteReference() {
    noteReference = noteReference.root();
    return noteReference;
  }

  void addNote(Notes notes) {
    noteReference = getNoteReference();
    noteReference.child('Notes').push().set(notes.toSnapshot());
  }

  //----------------------------------------------------------------------------
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _onNoteAddedSubscription.cancel();
    _onUserAddedSubscription.cancel();
  }
  //----------------------------------------------------------------------------
}