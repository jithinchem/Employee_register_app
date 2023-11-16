import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sample/db/model/dataModel.dart';
import 'package:sample/home.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); //checking app is ready
  await Hive.initFlutter();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter<EmployeeModel>(EmployeeModelAdapter());
  await Hive.openBox<EmployeeModel>("employee_db");

  if (!Hive.isAdapterRegistered(EmployeeModelAdapter().typeId)) {
    Hive.registerAdapter(EmployeeModelAdapter());
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.white),
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}
