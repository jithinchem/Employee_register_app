//import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
part 'dataModel.g.dart';

@HiveType(typeId: 1)
class EmployeeModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String age;
  @HiveField(3)
  final String email;
  @HiveField(4)
  final String phone;
  @HiveField(5)
  String? imageUrl;
  EmployeeModel({
    this.id,
    required this.name,
    required this.age,
    required this.email,
    required this.phone,
    required this.imageUrl,
  });
}
