import 'package:fixa/fixa_main_routes.dart';
import 'dart:io';

class DatabaseService {
  DatabaseService._privateConstructor();
  static final DatabaseService instance = DatabaseService._privateConstructor();

  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documensDirectory = await getApplicationDocumentsDirectory();
    String path = join(documensDirectory.path, 'fixa.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE assignedWorkers(
        id INTEGER PRIMARY KEY,
        worker_id INTEGER,
        project_id INTEGER,
        assigned_worker_id INTEGER,
        first_name TEXT,
        is_verified TEXT,
        gender TEXT,
        district TEXT,
        last_name TEXT,
        nid_number TEXT,
        phone_number TEXT,
        rates TEXT,
        services INTEGER,
        country_id TEXT,
        phone_numbers TEXT,
        phone_numbers_masked TEXT,
        date_of_birth TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE newworkers(
        id INTEGER PRIMARY KEY,
        service_id INTEGER,
        daily_rate TEXT,
        firstname TEXT,
        lastname TEXT,
        gender TEXT,
        district TEXT,
        nida TEXT,
        phone TEXT,
        country_id TEXT,
        phone_numbers TEXT,
        phone_numbers_masked TEXT,
        date_of_birth TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE attendanceWorkers(
        id INTEGER PRIMARY KEY,
        worker_id INTEGER,
        project_id INTEGER,
        assigned_worker_id INTEGER,
        first_name TEXT,
        district TEXT,
        last_name TEXT,
        nid_number TEXT,
        phone_number TEXT,
        rates TEXT,
        service_id INTEGER
      )
    ''');
  }

  // insert into assignedWorkers_tbl
  Future<int> addWorkers({required List<Map<String, dynamic>> rows}) async {
    Database db = await instance.database;

    Batch batch = db.batch();

    for (Map<String, dynamic> row in rows) {
      batch.insert("assignedWorkers", row);
    }
    batch.commit(noResult: true);
    // var response = await db.insert('assignedWorkers', worker.toJson());
    return 1;
  }

  // read from assigned_workers_tbl
  Future<List<AssignedWorkers>> getAllAssingedWorkerSaved(
      {required int projectId}) async {
    Database db = await instance.database;

    var response = await db.query('assignedWorkers',
        where: 'project_id=?', whereArgs: [projectId], orderBy: 'id DESC');
    List<AssignedWorkers> workers = response.isNotEmpty
        ? response.map((c) => AssignedWorkers.fromJson(c)).toList()
        : [];
    return workers;
  }

  // insert into attendanceWorkers_tbl
  Future<int> addAttendanceWorkers(
      {required AttendanceRecordedWorkers worker}) async {
    Database db = await instance.database;
    var response = await db.insert('attendanceWorkers', worker.toJson());
    return response;
  }

  // remove worker_saved
  Future<int> removeAttendedWorkerSaved({required int id}) async {
    Database db = await instance.database;
    return await db.delete('attendanceWorkers', where: 'id=?', whereArgs: [id]);
  }

  // empty attendanceWorkers table
  deleteAttendanceWorkers(
      {required int projectId, required int serviceId}) async {
    Database db = await instance.database;
    await db.delete('attendanceWorkers',
        where: 'project_id=? AND service_id=?',
        whereArgs: [projectId, serviceId]);
  }

  // read from attendanceWorkers_tbl
  Future<List<AttendanceRecordedWorkers>> getAllAttendanceWorkerSaved(
      {required int projectId, required int serviceId}) async {
    Database db = await instance.database;
    if (serviceId == 0) {
      var response = await db.query('attendanceWorkers',
          where: 'project_id=?',
          whereArgs: [projectId],
          orderBy: 'id');
      List<AttendanceRecordedWorkers> workers = response.isNotEmpty
          ? response.map((c) => AttendanceRecordedWorkers.fromJson(c)).toList()
          : [];
      return workers;
    } else {
      var response = await db.query('attendanceWorkers',
          where: 'project_id=? AND service_id=?',
          whereArgs: [projectId, serviceId],
          orderBy: 'id');
      List<AttendanceRecordedWorkers> workers = response.isNotEmpty
          ? response.map((c) => AttendanceRecordedWorkers.fromJson(c)).toList()
          : [];
      return workers;
    }
  }
  

  // read from assigned_workers_tbl
  Future<List<AssignedWorkers>> getAssingedWorkerSaved() async {
    Database db = await instance.database;
    var response = await db.query('assignedWorkers', orderBy: 'id DESC');
    List<AssignedWorkers> workers = response.isNotEmpty
        ? response.map((c) => AssignedWorkers.fromJson(c)).toList()
        : [];
    return workers;
  }

  // read from assigned_workers_tbl
  Future<List<AssignedWorkers>> getAssingedWorkerProjectIdSaved(
      {required int projectId, required int assignedWorkerId}) async {
    Database db = await instance.database;
    var response = await db.query('assignedWorkers',
        where: 'project_id=? AND assigned_worker_id=?',
        whereArgs: [projectId, assignedWorkerId],
        orderBy: 'id DESC');
    List<AssignedWorkers> workers = response.isNotEmpty
        ? response.map((c) => AssignedWorkers.fromJson(c)).toList()
        : [];
    return workers;
  }

  // update worker
  Future<int> updateWorker(
      {required int id, required AssignedWorkers worker}) async {
    Database db = await instance.database;
    return await db.update('assignedWorkers', worker.toJson(),
        where: 'id=?', whereArgs: [id]);
  }

  // insert into newworkers_tbl
  Future<int> addRegisteredWorkers(
      {required Map<String, Object?> worker}) async {
    Database db = await instance.database;
    var response = await db.insert('newworkers', worker);
    return response;
  }

  // read from newworkers_tbl
  Future<List<Map<String, Object?>>> getAllRegisteredWorkerSaved() async {
    Database db = await instance.database;
    var response = await db.query('newworkers',orderBy: 'id');
    List<Map<String, Object?>> workers = response;
    return workers;
  }

   Future<List<Map<String, Object?>>> getAllRegisteredWorkerSavedByServiceId(
      {required int serviceId}) async {
    Database db = await instance.database;
    var response = await db.query('newworkers',
        where: 'service_id=?', whereArgs: [serviceId], orderBy: 'id');
    List<Map<String, Object?>> workers = response;
    return workers;
  }

  // empty table
  delete({required String tableName}) async {
    Database db = await instance.database;
    await db.delete(tableName);
  }

  // empty table by serviceId
  deleteByServiceId({required String tableName, required int serviceId}) async {
    Database db = await instance.database;
    if(serviceId == 0){
    await db.delete(tableName);
    }else {
    await db.delete(tableName, where: 'service_id=?', whereArgs: [serviceId]);
    }
  }
}
