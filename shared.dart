import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const InputDecoration decoration1 = InputDecoration(
  border: InputBorder.none,
  hintStyle: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 14
  ),
  prefixIcon: Icon(Icons.lock_outline ,color: Colors.grey,),
);

const InputDecoration decoration2 = InputDecoration(
  border: InputBorder.none,
  hintStyle: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 14
  ),
);

const ShapeBorder shapeBorder =  RoundedRectangleBorder(borderRadius: BorderRadius.only(
    topRight: Radius.circular(5),
    topLeft: Radius.circular(5),
    bottomLeft: Radius.circular(5),
    bottomRight: Radius.circular(5)
));

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class DateTimeFormat {

  static String getFormatDate(){
    String _formatedDate = DateFormat.yMMMd().format(DateTime.now());
    return _formatedDate;
  }

  static String getFormatTime(){
    String _formatedTime = DateFormat.jm().format(DateTime.now());
    return _formatedTime;
  }

  static String getFormatDeadLine(DateTime deadLine){
    String _formatedDeadLine = DateFormat.yMMMd().format(deadLine);
    return _formatedDeadLine;
  }

}