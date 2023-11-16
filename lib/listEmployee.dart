import 'dart:io';

import 'package:flutter/material.dart';
//import 'package:flutter/src/widgets/framework.dart';
//import 'package:flutter/src/widgets/placeholder.dart';
import 'package:sample/db/function/dbFunction.dart';
import 'package:sample/db/model/dataModel.dart';
import 'package:sample/detailedEmployee.dart';
import 'package:sample/editEmployee.dart';

class ListEmployee extends StatefulWidget {
  const ListEmployee({super.key});

  @override
  State<ListEmployee> createState() => _ListEmployeeState();
}

class _ListEmployeeState extends State<ListEmployee> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: EmployeListNotifier,
      builder:
          (BuildContext ctx, List<EmployeeModel> employeeList, Widget? child) {
        return ListView.separated(
          itemBuilder: (ctx, index) {
            final data = employeeList[index];
            return ListTile(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => DetailedEmployee(
                      name: data.name,
                      age: data.age,
                      email: data.email,
                      phone: data.phone,
                      imageUrl: data.imageUrl,
                    ),
                  ),
                );
              },
              contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 0),
              title: Text(
                data.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              leading: CircleAvatar(
                backgroundImage: FileImage(
                  File(data.imageUrl!),
                ),
              ),
              trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => EditEmployee(
                          index: index,
                          name: data.name,
                          age: data.age,
                          email: data.email,
                          phone: data.phone,
                          imageUrl: data.imageUrl,
                        ),
                      ),
                    );
                  },
                  icon: Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: () {
                    ScaffoldMessenger.of(ctx)
                      ..removeCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(
                          content: Text("User Deleted"),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    deleteEmployee(index);
                  },
                  icon: Icon(
                    Icons.delete,
                  ),
                ),
              ]),
            );
          },
          separatorBuilder: (ctx, index) {
            return Divider();
          },
          itemCount: employeeList.length,
        );
      },
    );
  }
}
