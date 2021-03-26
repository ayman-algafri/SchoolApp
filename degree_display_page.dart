import 'package:flutter/material.dart';

class DegreeDisplay extends StatefulWidget {
  @override
  _DegreeDisplayState createState() => _DegreeDisplayState();
}

class _DegreeDisplayState extends State<DegreeDisplay> {






  var _changeHeight1 = true;
  var _objectName = 'اختر اسم المادة';
  var _heightContainer1 = 0.0;
  List<String> _myObjectx = [
    'الرياضيات','العلوم','التربية الاسلامية','القران الكريم','الاجتماعيات',
  ];

  var _changeHeight2 = true;
  var _monthName = 'اختر اسم الشهر';
  var _heightContainer2 = 0.0;
  List<String> _myMonths = [
    'الشهر الاول','الشهر الثاني','الشهر الثالث','الشهر الرابع','الشهر الخامس','الشهر السادس',
    'الشهر السابع','الشهر الثامن','الشهر التاسع','الشهر العاشر','الشهر الحادي عشر','الشهر الثاني عشر',
  ];


  @override
  Widget build(BuildContext context) {
    final _style1 = TextStyle(
        fontWeight: FontWeight.bold
    );
    TextStyle _style2 = Theme.of(context).textTheme.button.copyWith(color: Color(0xFFf4c06a),
        fontWeight: FontWeight.bold ,fontSize: 18);
    final _style3 = TextStyle(

        fontWeight: FontWeight.bold
    );

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          centerTitle: true,
          leading: IconButton(
            onPressed: (){},
            icon: Icon(Icons.dehaze,color: Colors.grey,),
          ),
          title: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('خلود',style: Theme.of(context).textTheme.subtitle.copyWith(fontWeight: FontWeight.bold),),
                Text('الصف الرابع',style: Theme.of(context).textTheme.caption.copyWith(fontWeight: FontWeight.bold),),
              ],
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: CircleAvatar(
                backgroundColor: Colors.grey[300],
                child: Icon(Icons.person_outline),
              ),
              onPressed: (){},
            )
          ],
        ),

        body: Stack(
          children: <Widget>[
            ListView(
              children: <Widget>[
                Card(
                    margin: EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    color: Color(0xFFf4c06a),
                    child: Container(
                      padding: EdgeInsets.only(top: 5,bottom: 5),
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.event_note,color: Colors.grey[800],),
                          SizedBox(width: 10,),
                          Text('درجة اعمال الفصل',
                            style: Theme.of(context).textTheme.title.copyWith(color: Colors.grey[800],fontWeight: FontWeight.bold),)
                        ],
                      ),
                    )
                ),
                Card(
                    margin: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                    shape: RoundedRectangleBorder(side: BorderSide(
                        color: Color(0xFFf4c06a),
                        width: 2
                    ),borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          title: Text(_objectName,style: TextStyle(
                              fontWeight: FontWeight.bold
                          ),),
                          trailing: _changeHeight1 ? Icon(Icons.expand_more) : Icon(Icons.expand_less),
                          onTap: (){
                            setState(() {
                              _changeHeight1 ? _heightContainer1 = 200.0 : _heightContainer1 = 0.0;
                              _changeHeight1 = !_changeHeight1;
                            });
                          },
                        ),
                        AnimatedContainer(
                          duration: Duration(milliseconds: 400),
                          curve: Curves.ease,
                          height: _heightContainer1,
                          child: ListView.builder(
                            itemCount: _myObjectx.length,
                            itemBuilder: (context, index) => Column(
                              children: <Widget>[
                                ListTile(title: Text(_myObjectx[index]),
                                  onTap: (){
                                    setState(() {
                                      _objectName = _myObjectx[index];
                                      _changeHeight1 ? _heightContainer1 = 200.0 : _heightContainer1 = 0.0;
                                      _changeHeight1 = !_changeHeight1;
                                    });
                                  },),
                                Divider(height: 0,)
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                ),

                Card(
                  margin: EdgeInsets.only(right: 20,left: 20,top: 20,bottom: 5),
                  child: Column(
                    children: <Widget>[
                  
                      Divider(height: 0,),
                      ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text('حضور',style: _style1,),Text('شفهي',style:  _style1,),
                            Text('واجبات',style:  _style1,),Text('تحريري',style: _style1,),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Card(
                    margin: EdgeInsets.only(right: 20,left: 20,top: 0,),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text('20',style: _style2,),Text('20',style: _style2,)
                              ,Text('10',style: _style2,),Text('50',style: _style2,),
                            ],
                          ),
                        ),
                        Divider(height: 0,endIndent: 20,indent: 20,),
                        ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text('18',style: _style3,),Text('19',style: _style3),
                              Text('10',style: _style3),Text('42',style: _style3),
                            ],
                          ),
                        ),
                      ],
                    )
                ),
              ],
            ),
            Positioned(
                bottom: 0,
                child: Container(

                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 0.5,
                            offset: Offset(0, 0.4)
                        )
                      ]
                  ),

                  padding: EdgeInsets.only(top: 5),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      InkWell(
                        onTap: (){
                          //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>StudentPage()));
                        },
                        child: Container(
                            padding: EdgeInsets.symmetric(vertical: 3,horizontal: 10),
                            child: Column(
                              children: <Widget>[
                                Icon(Icons.home,size: 20,),
                                Text('الرئيسية',style: TextStyle(
                                  fontSize: 12
                                ),),
                              ],
                            )
                        ),
                      ),
                      InkWell(
                        onTap: (){},
                        child: Container(
                            padding: EdgeInsets.symmetric(vertical: 3,horizontal: 10),
                            child: Column(
                              children: <Widget>[
                                Icon(Icons.notifications,size: 20,),
                                Text('الاشعارات',style: TextStyle(
                                                        fontSize: 12
                                                        ),),
                              ],
                            )
                        ),
                      ),
                    ],
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}