import 'dart:io';

import 'package:flutter/material.dart';

class DetailedEmployee extends StatelessWidget {
  final String name;
  final String age;
  final String email;
  final String phone;
  final String? imageUrl;
  DetailedEmployee({
    required this.name,
    required this.age,
    required this.email,
    required this.phone,
    this.imageUrl,
  }) : super(key: GlobalKey());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee Details'),
      ),
      body: SafeArea(
        child: Container(
          height: 800,
          width: 400,
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(),
            color: Colors.grey[300],
            child: ListView(
              padding: EdgeInsets.fromLTRB(15, 10, 10, 5),
              children: [
                Text(
                  name.toString(),
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  age.toString(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  email.toString(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  phone.toString(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Image.file(
                    File(imageUrl!),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
