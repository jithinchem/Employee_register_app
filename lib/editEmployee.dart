import 'dart:io';

import 'package:flutter/material.dart';
//import 'package:flutter/src/widgets/framework.dart';
//import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:sample/addEmployee.dart';
//import 'package:sample/db/function/dbFunction.dart';
import 'package:sample/db/model/dataModel.dart';
//import 'package:sample/detailedEmployee.dart';
import 'package:sample/home.dart';
//import 'package:sample/listEmployee.dart';

class EditEmployee extends StatefulWidget {
  const EditEmployee(
      {super.key,
      required this.name,
      required this.age,
      required this.email,
      required this.phone,
      this.imageUrl,
      required this.index});
  final String name;
  final String age;
  final String email;
  final String phone;
  final String? imageUrl;
  final int index;

  @override
  State<EditEmployee> createState() => _EditEmployeeState();
}

class _EditEmployeeState extends State<EditEmployee> {
  final _nameController = TextEditingController();

  final _ageController = TextEditingController();

  final _emailController = TextEditingController();

  final _phoneController = TextEditingController();

  String? _image;

  getImage() async {
    final image =
        await ImagePicker.platform.getImage(source: ImageSource.gallery);
    setState(() {
      _image = image!.path;
    });
  }

  @override
  void initState() {
    _nameController.text = widget.name.toString();
    _ageController.text = widget.age.toString();
    _emailController.text = widget.email.toString();
    _phoneController.text = widget.phone.toString();
    _image = widget.imageUrl;
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _emailController.dispose();
    _phoneController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Employee'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[300],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: widget.name.toString(),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _ageController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[300],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: widget.age.toString(),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[300],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: widget.email.toString(),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[300],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: widget.phone.toString(),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 253, 254, 255),
                      border: Border.all(color: Colors.blueAccent, width: 2),
                    ),
                    child: _image == null
                        ? Container(
                            child: Image.file(
                              File(widget.imageUrl.toString()),
                            ),
                          )
                        : Image.file(
                            File(_image!),
                          ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  FloatingActionButton(
                    onPressed: getImage,
                    child: Icon(
                      Icons.camera,
                      size: 50,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(),
                    onPressed: () {
                      ScaffoldMessenger.of(context)
                        ..removeCurrentSnackBar()
                        ..showSnackBar(
                          SnackBar(
                            content: Text("Employee Updated"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      Hive.box<EmployeeModel>("employee_DB").putAt(
                        widget.index,
                        EmployeeModel(
                          name: _nameController.text,
                          age: _ageController.text,
                          email: _emailController.text,
                          phone: _phoneController.text,
                          imageUrl: _image!,
                        ),
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Home(),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.update,
                      size: 60,
                    ),
                    label: Text('Update'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
