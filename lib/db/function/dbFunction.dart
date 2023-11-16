import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sample/db/model/dataModel.dart';

ValueNotifier<List<EmployeeModel>> EmployeListNotifier = ValueNotifier([]);
Future<void> addEmployee(EmployeeModel value) async {
  final employeeDB =
      await Hive.openBox<EmployeeModel>("employee_db"); //data base open
  final _id = await employeeDB.add(value); //values added to data Base
  value.id = _id;
  EmployeListNotifier.value.add(value); //added values to EmployeeListNotifier
  EmployeListNotifier.notifyListeners(); //notified the listeners
}

Future<void> getallEmployees() async {
  final employeeDB = await Hive.openBox<EmployeeModel>("employee_db");
  EmployeListNotifier.value.clear(); //cleared the current notifier
  EmployeListNotifier.value.addAll(employeeDB.values); //added list to notifier
  EmployeListNotifier.notifyListeners();
}

Future<void> deleteEmployee(int id) async {
  final employeeDB = await Hive.openBox<EmployeeModel>("employee_db");
  await employeeDB.deleteAt(id);
  getallEmployees();
}
