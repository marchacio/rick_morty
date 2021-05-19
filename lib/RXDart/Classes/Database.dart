import 'package:rxdart/rxdart.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {

  ///This is the rxdart database instance
  BehaviorSubject<Database> _database = BehaviorSubject<Database>();

  ///The getter of [_database], this is the entire database
  Database get database => _database.value;

  void updateDatabase(Database newDatabase) => _database.add(newDatabase);

}