import 'dart:io';
import 'package:employee/utils/app_extension.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Employee {
  final int? id;
  final String? name, role, toDate, fromDate;
  Employee({this.id, this.fromDate, this.name, this.role, this.toDate});

  Employee.fromDbMap(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'],
        role = map['role'],
        toDate = map['toDate'],
        fromDate = map['fromDate'];
  Map<String, dynamic> toDbMap() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['name'] = name;
    map['role'] = role;
    map['toDate'] = toDate;
    map['fromDate'] = fromDate;
    return map;
  }
}

class DatabaseManager extends GetxController {
  static const _databaseName = "Employee.db";
  List<Employee> employee = [];
  late Database _database;
  RxString role = ''.obs;
  RxString toDate = ''.obs;
  RxString fromDate = ''.obs;

  // Creates and opens the database.
  initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  // Creates the database structure
  Future _onCreate(
    Database db,
    int version,
  ) async {
    await db.execute('''
          CREATE TABLE Employee (
            id INTEGER PRIMARY KEY,
            name TEXT NOT NULL,
            role TEXT NOT NULL,
            toDate TEXT,
            fromDate TEXT
          )
          ''');
    print('table created');
  }

  Future<List<Employee>> fetchAllEmployee() async {
    Database dbclient = _database;
    List<Map<String, dynamic>> maps = await dbclient.query('Employee');
    if (maps.isNotEmpty) {
      var a = maps.map((map) => Employee.fromDbMap(map)).toList();
      employee.addAll(a);
      return a;
    }

    return [];
  }

  Future<int> addEmployee(Employee employee) async {
    Database dbclient = _database;
    return dbclient.insert(
      'Employee',
      employee.toDbMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> updateEmployee(Employee newemployee) async {
    Database dbclient = _database;

    var a = dbclient.update(
      'Employee',
      newemployee.toDbMap(),
      where: 'id = ?',
      whereArgs: [newemployee.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    fetchAllEmployee();
    return a;
  }

  Future<int> deleteemployee(int id) async {
    Database dbclient = _database;
    var a = dbclient.delete(
      'Employee',
      where: 'id = ?',
      whereArgs: [id],
    );
    fetchAllEmployee();
    return a;
  }
}
