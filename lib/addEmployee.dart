import 'dart:io';

import 'package:flutter/material.dart';
//import 'package:flutter/src/widgets/framework.dart';
//import 'package:flutter/src/widgets/placeholder.dart';
//import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sample/db/function/dbFunction.dart';
import 'package:sample/db/model/dataModel.dart';

class AddEmployee extends StatefulWidget {
  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  final _nameController = TextEditingController();

  final _ageController = TextEditingController();

  final _emailController = TextEditingController();

  final _phoneController = TextEditingController();

  XFile? _image;

  getImage() async {
    final image =
        await ImagePicker.platform.getImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 198, 127, 122),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 223, 164, 160),
                          width: 2.5)),
                  filled: true,
                  fillColor: Colors.grey[300],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: 'Name',
                  hintStyle: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _ageController,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 223, 164, 160),
                          width: 2.5)),
                  filled: true,
                  fillColor: Colors.grey[300],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: 'Age',
                  hintStyle: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 223, 164, 160),
                          width: 2.5)),
                  filled: true,
                  fillColor: Colors.grey[300],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: 'Email',
                  hintStyle: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _phoneController,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Color.fromARGB(255, 223, 164, 160),
                    width: 2.5,
                  )),
                  filled: true,
                  fillColor: Colors.grey[300],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: 'Phone',
                  hintStyle: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    border: Border.all(color: Colors.blueAccent, width: 2),
                  ),
                  child: _image == null
                      ? Container()
                      : Image.file(
                          File(_image!.path),
                        ),
                ),
                FloatingActionButton(
                  onPressed: getImage,
                  child: Icon(
                    Icons.camera,
                    size: 50,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(),
                  onPressed: () {
                    AddemployeeClicked();
                  },
                  icon: Icon(
                    Icons.add,
                    size: 60,
                  ),
                  label: Text('Add new'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future AddemployeeClicked() async {
    final _name = _nameController.text.trim();
    final _age = _ageController.text.trim();
    final _email = _emailController.text.trim();
    final _phone = _phoneController.text.trim();
    if (_name.isEmpty || _age.isEmpty || _email.isEmpty || _phone.isEmpty) {
      return;
    }

    final _employee = EmployeeModel(
      name: _name,
      age: _age,
      email: _email,
      phone: _phone,
      imageUrl: _image!.path,
    );
    addEmployee(_employee);
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text("New Employee Added"),
          duration: Duration(seconds: 2),
        ),
      );
  }
}
