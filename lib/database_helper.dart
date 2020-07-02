import 'dart:io';

import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'model/contact.dart';

class DatabaseHelper{

  static final  _databaseName="lastRandomdb.db";
  static final _databaseVersion = 1;
  static final table = "Randomdb";
  static final columnEmail = "email";
  static final columnName = "name";

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;

  Future<Database> get database async{
    if(database != null) return database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
      var databasepath = await getDatabasesPath();
      String path = join(databasepath,_databaseName);

      //check existing
    var exists = await databaseExists(path);
    if(!exists){
      print("copy database start");
      try{
        await Directory(dirname(path)).create(recursive: true);
      }catch(_){
        //copy
        ByteData data = await rootBundle.load(join("assets",_databaseName));
        List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

        //write
        await File(path).writeAsBytes(bytes, flush: true);
      }
    }else{
      print("opening exsisting database");
    }

    return await openDatabase(path,version: _databaseVersion);
  }

    //crud


Future<List> getAllContacts() async{
    Database db = await instance.database;
    final List<Map<String, dynamic>> map = await db.query(table, orderBy: columnName);
    return List.generate(map.length, (index){
      return Contact.fromMap(map[index]);
    });

}

Future<int> getCount() async{
  Database db = await instance.database;
  return Sqflite.firstIntValue(await db.rawQuery("SELECT COUNT(EMAIL) FROM $table"));
}


}