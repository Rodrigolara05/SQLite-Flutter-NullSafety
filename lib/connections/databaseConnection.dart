import 'package:flutter_application_1/entities/note.dart';
import 'package:sqflite/sqflite.dart';

class NoteDatabase {
  Database? db;
  String databaseName = 'notes_DB_v2.db';
  String tableName = 'notes';

  initDB() async {
    db = await openDatabase(databaseName, version: 1,
    onCreate: (Database data, int version){
      data.execute("CREATE TABLE " + tableName +" (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "
          "description TEXT,"
          "date TEXT)");
    } );
    print("DB Inicializada");
  }

  insert(Note object) async{
    db!.insert(tableName, object.toMap());
  }

  update(Note object) async{
    db!.update(tableName,object.toMap(),where: "id=?",whereArgs: [object.id]);
  }
  
  delete(Note object) async{
    db!.delete(tableName,where: "id=?",whereArgs: [object.id]);
  }
  
  Future<List<Note>> getAll() async{
    print("Listar");
    List<Map<String,dynamic>> results = await db!.query(tableName);
    return results.map((map) => Note.fromMap(map)).toList();
  }

}
