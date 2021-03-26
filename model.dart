import 'package:firebase_database/firebase_database.dart';
class Users {
  //
  String uidUser;
  bool typeUser;
  String nameUser;
  String emailUser;
  String classNameUser;
  String passwordUser;
  bool statusAccount;
  String createdAtTimeUser;
  String createdAtDateUser;
  //
  String objectNameUser;
  String stuId;
  //
  Users(
      this.typeUser,this.nameUser,this.emailUser,this.classNameUser,this.passwordUser,
      this.statusAccount,this.createdAtTimeUser,this.createdAtDateUser,{this.objectNameUser,this.uidUser,this.stuId}
      );
  //
  Users.map(dynamic obj) {
    //
    this.uidUser = obj['UidUser'];
    this.typeUser = obj['TypeUser'];
    this.nameUser = obj['NameUser'];
    this.emailUser = obj['EmailUser'];
    this.classNameUser = obj['ClassNameUser'];
    this.passwordUser = obj['PasswordUser'];
    this.statusAccount = obj['StatusAccount'];
    this.createdAtTimeUser = obj['CreatedAtTimeUser'];
    this.createdAtDateUser = obj['CreatedAtDateUser'];
    //
    this.objectNameUser = obj['ObjectNameUser'];
    this.stuId = obj['StuId'];
    //
  }
  //
  Users.fromSnapshot(DataSnapshot snapshot) {
    //
    uidUser = snapshot.key;
    typeUser = snapshot.value['TypeUser'];
    nameUser = snapshot.value['NameUser'];
    emailUser = snapshot.value['EmailUser'];
    classNameUser = snapshot.value['ClassNameUser'];
    passwordUser = snapshot.value['PasswordUser'];
    statusAccount = snapshot.value['StatusAccount'];
    createdAtTimeUser = snapshot.value['CreatedAtTimeUser'];
    createdAtDateUser = snapshot.value['CreatedAtDateUser'];
    //
    objectNameUser = snapshot.value['ObjectNameUser'];
    stuId = snapshot.value['StuId'];
    //
  }
  //
  toSnapshot() {
    var value = {
      "TypeUser" : typeUser,
      "NameUser" : nameUser,
      "EmailUser" : emailUser,
      "ClassNameUser" : classNameUser,
      "PasswordUser" : passwordUser,
      "StatusAccount" : statusAccount,
      "CreatedAtTimeUser" : createdAtTimeUser,
      "CreatedAtDateUser" : createdAtDateUser,
      //
      "ObjectNameUser" : objectNameUser,
      "StuId" : stuId,
      //
    };
    return value;
  }
//
} // end class users
class Grades {
  String uidGrade;
  String emailOwnerGrade;
  String nameOwnerGrade;
  String studentId;
  String object;
  String className;
  String grade;
  int type;
  Grades(this.emailOwnerGrade,this.nameOwnerGrade,this.studentId,this.object,this.className,this.grade,this.type,{this.uidGrade});
    Grades.map(dynamic obj) {
    //
    this.uidGrade = obj['UidGrade'];
    this.emailOwnerGrade = obj['EmailOwnerGrade'];
    this.nameOwnerGrade = obj['NameOwnerGrade'];
    this.studentId = obj['StudentId'];
    this.object = obj['Object'];
    this.className = obj['ClassName'];
    this.grade = obj['Grade'];
    this.type = obj['Type'];
    //
  }
    Grades.fromSnapshot(DataSnapshot snapshot) {
    //
    uidGrade = snapshot.key;
    emailOwnerGrade = snapshot.value['EmailOwnerGrade'];
    nameOwnerGrade = snapshot.value['NameOwnerGrade'];
    studentId = snapshot.value['StudentId'];
    object = snapshot.value['Object'];
    className = snapshot.value['ClassName'];
    grade = snapshot.value['Grade'];
    type = snapshot.value['Type'];
    //
  }
    toSnapshot() {
    var value = {
      "EmailOwnerGrade" : emailOwnerGrade,
      "NameOwnerGrade" : nameOwnerGrade,
      "StudentId" : studentId,
      "Object" : object,
      "ClassName" : className,
      "Grade" : grade,
      "Type" : type,
      //
    };
    return value;
  }
}
class HWs {
  String uidHw;
  String emailOwnerHw;
  String nameOwnerHw;
  String content;
  String objectHw;
  String classHw;
  String timeHw;
  String dateHw;
  HWs(this.emailOwnerHw,this.nameOwnerHw,this.content,this.objectHw,this.classHw,this.timeHw,this.dateHw,{this.uidHw});
      HWs.map(dynamic obj) {
    //
    this.uidHw = obj['UidHw'];
    this.emailOwnerHw = obj['EmailOwnerHw'];
    this.nameOwnerHw = obj['NameOwnerHw'];
    this.content = obj['Content'];
    this.objectHw = obj['ObjectOw'];
    this.classHw = obj['ClassHw'];
    this.timeHw = obj['TimeHw'];
    this.dateHw = obj['DateHw'];
    //
  }
    HWs.fromSnapshot(DataSnapshot snapshot) {
    //
    uidHw = snapshot.key;
    emailOwnerHw = snapshot.value['EmailOwnerHw'];
    nameOwnerHw = snapshot.value['NameOwnerHw'];
    content = snapshot.value['Content'];
    objectHw = snapshot.value['ObjectHw'];
    classHw = snapshot.value['ClassHw'];
    timeHw = snapshot.value['TimeHw'];
    dateHw = snapshot.value['DateHw'];
    //
  }
    toSnapshot() {
    var value = {
      "EmailOwnerHw" : emailOwnerHw,
      "NameOwnerHw" : nameOwnerHw,
      "Content" : content,
      "ObjectHw" : objectHw,
      "ClassHw" : classHw,
      "TimeHw" : timeHw,
      "DateHw" : dateHw,
      //
    };
    return value;
  }
}

class Notes {
  String uidNote;
  String emailOwnerNote;
  String nameOwnerNote;
  String content;
  String objectNote;
  String classNote;
  String timeNote;
  String dateNote;
  Notes(this.emailOwnerNote,this.nameOwnerNote,this.content,this.objectNote,this.classNote,this.timeNote,this.dateNote,{this.uidNote});
      Notes.map(dynamic obj) {
    //
    this.uidNote = obj['UidNote'];
    this.emailOwnerNote = obj['EmailOwnerNote'];
    this.nameOwnerNote = obj['NameOwnerNote'];
    this.content = obj['Content'];
    this.objectNote = obj['ObjectNote'];
    this.classNote = obj['ClassNote'];
    this.timeNote = obj['TimeNote'];
    this.dateNote = obj['DateNote'];
    //
  }
    Notes.fromSnapshot(DataSnapshot snapshot) {
    //
    uidNote = snapshot.key;
    emailOwnerNote = snapshot.value['EmailOwnerNote'];
    nameOwnerNote = snapshot.value['NameOwnerNote'];
    content = snapshot.value['Content'];
    objectNote = snapshot.value['ObjectNote'];
    classNote = snapshot.value['ClassNote'];
    timeNote = snapshot.value['TimeNote'];
    dateNote = snapshot.value['DateNote'];
    //
  }
    toSnapshot() {
    var value = {
      "EmailOwnerNote" : emailOwnerNote,
      "NameOwnerNote" : nameOwnerNote,
      "Content" : content,
      "ObjectNote" : objectNote,
      "ClassNote" : classNote,
      "TimeNote" : timeNote,
      "DateNote" : dateNote,
      //
    };
    return value;
  }
}
