import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:buildingapp/JsonModels/users.dart'; // Ensure this path is correct


class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance; // Singleton pattern
  DatabaseHelper._internal();

  Database? _database; // Private database instance
  final String databaseName = "users.db";

  // SQL command to create the users table
  final String usersTable =
      "CREATE TABLE users (usrId INTEGER PRIMARY KEY AUTOINCREMENT, usrName TEXT UNIQUE, usrPassword TEXT)";

  // Initialize the database
  Future<Database> initDB() async {
    if (_database != null) return _database!; // Return existing database if initialized
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, databaseName);

    // Open the database and create it if it doesn't exist
    _database = await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute(usersTable);
    });
    return _database!;
  }

  // Login method
  Future<bool> login(Users user) async {
    final Database db = await initDB();
    try {
      // Query the database to check if the username and password match
      var result = await db.rawQuery(
          "SELECT * FROM users WHERE usrName = ? AND usrPassword = ?",
          [user.usrName, user.usrPassword]);
      return result.isNotEmpty; // Return true if the result is not empty
    } catch (e) {
      print("Login error: $e"); // Print error if occurs
      return false; // Return false in case of an error
    }
  }

  // Sign up method
  Future<int> signup(Users user) async {
    final Database db = await initDB();
    try {
      // Insert the new user into the users table
      return await db.insert('users', user.toMap());
    } catch (e) {
      print("Signup error: $e"); // Print error if occurs
      return -1; // Return -1 to indicate failure
    }
  }
}
