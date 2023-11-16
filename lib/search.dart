import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:sample/db/model/dataModel.dart';

import 'detailedEmployee.dart';

class SearchEmployee extends SearchDelegate<EmployeeModel> {
 // final employeeDB = Hive.openBox<EmployeeModel>("employee_db");
  final Box<EmployeeModel> EmployeeModelBox;
  SearchEmployee(this.EmployeeModelBox);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.pop(context),
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = EmployeeModelBox.values
        .where((EmployeeModel) =>
            EmployeeModel.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => DetailedEmployee(
                  name: results[index].name,
                  age: results[index].age,
                  email: results[index].email,
                  phone: results[index].phone,
                  imageUrl: results[index].imageUrl,
                ),
              ),
            );
          },
          title: Text(results[index].name),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = EmployeeModelBox.values
        .where((EmployeeModel) =>
            EmployeeModel.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestions[index].name),
          onTap: () {
            query = suggestions[index].name;
            showResults(context);
          },
        );
      },
    );
  }
}
