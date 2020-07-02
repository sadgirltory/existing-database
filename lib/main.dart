
import 'package:flutter/material.dart';
import 'package:workingwithexistingsqlite/database_helper.dart';
import 'package:workingwithexistingsqlite/model/contact.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  DatabaseHelper databaseHelper = DatabaseHelper.instance;
  List<Contact> contactList = new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    databaseHelper.getAllContacts().then((rows) {
          setState(() {
            rows.forEach((row) {
              contactList.add(Contact.map(row));
            });
          });
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(
          child: ListView.builder(
            itemCount: contactList.length,
            padding: const EdgeInsets.all(14.0),
            itemBuilder: (context, index){
              return Column(
                children: <Widget>[
                  Divider(height: 5.0,),
                  Material(color: Colors.white,child:
                    ListTile(
                      title: Text("${contactList[index].name}", style: TextStyle(color: Colors.black, fontSize: 20),),
                      subtitle:  Text("${contactList[index].email}", style: TextStyle(color: Colors.black, fontSize: 20),),
                    ),)
                ],
              );
            },
          ),
      ),
  
    );
  }
}
