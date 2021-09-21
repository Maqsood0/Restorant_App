import 'package:connectivity/connectivity.dart';
//ignore: import_of_legacy_library_into_null_safe
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:restorant_app/Database/Database_helper.dart';
import 'package:restorant_app/Database/User.dart';
import 'package:http/http.dart' as http;

class SyncronizationData {
  static Future<bool> isInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      if (await DataConnectionChecker().hasConnection) {
        print("Mobile data detected & internet connection confirmed.");
        return true;
      } else {
        print('No internet :( Reason:');
        return false;
      }
    } else if (connectivityResult == ConnectivityResult.wifi) {
      if (await DataConnectionChecker().hasConnection) {
        print("wifi data detected & internet connection confirmed.");
        return true;
      } else {
        print('No internet :( Reason:');
        return false;
      }
    } else {
      print(
          "Neither mobile data or WIFI detected, not internet connection found.");
      return false;
    }
  }

  final conn = DatabaseHelper();

  Future<List> fetchAllInfo() async {
    print('fetch 1');
    final dbClient = await conn.db;
    List user = [];
    try {
      print('fetch 2');
      final maps = await dbClient.query(
        'User',
        columns: [conn.columnName, conn.columnEmail, conn.columnPassword],
      );
      for (var item in maps) {
        print('fetch 3');
        user.add((item));
      }
    } catch (e) {
      print(e.toString());
    }
    print('fetch 4');
    return user;
  }

  Future saveToMysqlWith(List user) async {
    for (var i = 0; i < user.length; i++) {
      Map<String, dynamic> data = {
        "FullName": user[i].FullName,
        "Email": user[i].Email,
        "Password": user[i].Password,
      };
      final response = await http.post(Uri.parse(''), body: data);
      if (response.statusCode == 200) {
        print("Saving Data ");
      } else {
        print(response.statusCode);
      }
    }
  }
}
