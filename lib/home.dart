import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hive/hive.dart';
import 'package:sample/addEmployee.dart';
import 'package:sample/db/function/dbFunction.dart';
import 'package:sample/db/model/dataModel.dart';
import 'package:sample/listEmployee.dart';
import 'package:sample/search.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final EmployeeModelBox = Hive.box<EmployeeModel>("employee_db");
  @override
  Widget build(BuildContext context) {
    getallEmployees();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 179, 121, 116),
        title: Text(
          "Search",
          style: TextStyle(color: Colors.black, fontSize: 25),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => showSearch(
                context: context, delegate: SearchEmployee(EmployeeModelBox)),
            icon: Padding(
              padding: EdgeInsets.only(right: 35),
              child: Icon(
                Icons.search,
                color: Colors.black,
                size: 30,
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            AddEmployee(),
            Expanded(child: ListEmployee()),
          ],
        ),
      ),
    );
  }
}
