import 'package:employee_directory_app/DB_Models/employeeCommonDetails_db_model.dart';
import 'package:employee_directory_app/Database/database.dart';
import 'package:sqflite/sqflite.dart';

class EmployeeDirectoryDAO {
  static final db = EmployeeDirectoryDatabase();

  static Future<int> addDbForEmployeeCommonDetails(
      EmployeeCommonDetails employeeCommonDetails) async {
    var client = await EmployeeDirectoryDatabase.db;
    return client.insert(
        'employeeCommonDetails', employeeCommonDetails.toMapForDb(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<EmployeeCommonDetails>>
      fetchAllForEmployeeCommonDetails() async {
    var client = await EmployeeDirectoryDatabase.db;
    var res = await client.query('employeeCommonDetails');

    if (res.isNotEmpty) {
      var types = res
          .map((assetTrackingMap) =>
              EmployeeCommonDetails.fromDb(assetTrackingMap))
          .toList();
      return types;
    }
    return [];
  }

  static Future<void> saveEmployeeDirectoryDetailsToDB(
      List<dynamic> employeeDirectoryDetails) async {
    await db.remove("employeeCommonDetails");
    for (int i = 0; i < employeeDirectoryDetails.length; i++) {
      print(".....................${employeeDirectoryDetails.length}");
      print(".....................${employeeDirectoryDetails[i]['id']}");
      var sync = new EmployeeCommonDetails.random(
        employeeDirectoryDetails[i]['id'] ?? "",
        employeeDirectoryDetails[i]['name'] ?? "",
        employeeDirectoryDetails[i]['username'] ?? "",
        employeeDirectoryDetails[i]['email'] ?? "",
        employeeDirectoryDetails[i]['profile_image'] ?? "",
        employeeDirectoryDetails[i]['address'] != null &&
                employeeDirectoryDetails[i]['address']['street'] != null
            ? employeeDirectoryDetails[i]['address']['street']
            : "",
        employeeDirectoryDetails[i]['address'] != null &&
                employeeDirectoryDetails[i]['address']['suite'] != null
            ? employeeDirectoryDetails[i]['address']['suite']
            : "",
        employeeDirectoryDetails[i]['address'] != null &&
                employeeDirectoryDetails[i]['address']['city'] != null
            ? employeeDirectoryDetails[i]['address']['city']
            : "",
        employeeDirectoryDetails[i]['address'] != null &&
                employeeDirectoryDetails[i]['address']['zipcode'] != null
            ? employeeDirectoryDetails[i]['address']['zipcode']
            : "",
        employeeDirectoryDetails[i]['address'] != null &&
                employeeDirectoryDetails[i]['address']['geo'] != null &&
                employeeDirectoryDetails[i]['address']['geo']['lat'] != null
            ? employeeDirectoryDetails[i]['address']['geo']['lat']
            : "",
        employeeDirectoryDetails[i]['address'] != null &&
                employeeDirectoryDetails[i]['address']['geo'] != null &&
                employeeDirectoryDetails[i]['address']['geo']['lng'] != null
            ? employeeDirectoryDetails[i]['address']['geo']['lng']
            : "",
        employeeDirectoryDetails[i]['phone'] ?? "",
        employeeDirectoryDetails[i]['website'] ?? "",
        employeeDirectoryDetails[i]['company'] != null &&
                employeeDirectoryDetails[i]['company']['name'] != null
            ? employeeDirectoryDetails[i]['company']['name']
            : "",
        employeeDirectoryDetails[i]['company'] != null &&
                employeeDirectoryDetails[i]['company']['catchPhrase'] != null
            ? employeeDirectoryDetails[i]['company']['catchPhrase']
            : "",
        employeeDirectoryDetails[i]['company'] != null &&
                employeeDirectoryDetails[i]['company']['bs'] != null
            ? employeeDirectoryDetails[i]['company']['bs']
            : "",
      );
      await addDbForEmployeeCommonDetails(sync);
    }
  }

  static Future<List<EmployeeCommonDetails>>
      displayEmployeeCommonDetailsFromDb() async {
    List<EmployeeCommonDetails> employeeDetails =
        await fetchAllForEmployeeCommonDetails();
    return employeeDetails;
  }
}
