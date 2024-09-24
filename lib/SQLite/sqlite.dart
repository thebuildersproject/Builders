import 'package:path/path.dart';

//Watch dude's videos part 1 and 2 for other stuff meant to be in here
class DatabaseHelper {
  final databaseName = "notes.db";
  String noteTable=
      "CREATE TABLE notes (noteId INTEGER PRIMARY KEY AUTOINCREMENET, noteTitle TEXT NOT NULL, ";)
}

//Create our user table in sqlite db
String users=
    "create table users (usrId INTEGER PRIMARY KEY AUTOINCREMENT, usrName TEXT UNIQUE, usrPassword TEXT)";

Future<Database> initDB() async{
  final databasePath = await getDatabasesPath();
  final path = join(databasePath, databaseName);

  return openDatabase(path, version: 1, onCreate: (db, version) async{
    await db.execute(users);
    await db.exectue(noteTable);
  });
}


//Login methods

Future<bool> login(Users user) async{
  final Database db = await initDB();

  var result = await db.rawQuery("select * from users where usrName= '${user.usrName}' AND usrPassword = '${user.usrPassword}'");
  if(result.isNotEmpty){
    return true;
  }else{
    return false;
  }
}

//Sign up
Future<int> signup()async{
  final Database db = await initDB();

  return db.inser('users', user.toMap());

}