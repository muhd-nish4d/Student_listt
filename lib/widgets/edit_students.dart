import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weak_five_studentlist_main/bloc/student_bloc/student_bloc_bloc.dart';
// import 'package:weak_five_studentlist_main/db/functions/db_functions.dart';
import 'package:weak_five_studentlist_main/db/model/data_model.dart';

class WidgetEiditStudent extends StatefulWidget {
  final String image;
  final String name;
  final String age;
  final String address;
  final String phone;
  final int index;

  const WidgetEiditStudent(
      {super.key,
      required String photo,
      required this.name,
      required this.age,
      required this.address,
      required this.phone,
      required this.index,
      required this.image});

  @override
  State<WidgetEiditStudent> createState() => _WidgetEiditStudentState();
}

class _WidgetEiditStudentState extends State<WidgetEiditStudent> {
  TextEditingController studentName = TextEditingController();
  TextEditingController studentAge = TextEditingController();
  TextEditingController studentAddress = TextEditingController();
  TextEditingController studentPhone = TextEditingController();

  @override
  void initState() {
    super.initState();
    studentName = TextEditingController(text: widget.name);
    studentAge = TextEditingController(text: widget.age);
    studentPhone = TextEditingController(text: widget.phone);
    studentAddress = TextEditingController(text: widget.address);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: ListView(
          children: [
            const SizedBox(
              height: 40,
            ),
            Column(
              children: [
                CircleAvatar(
                  radius: 70,
                  backgroundImage: FileImage(File(widget.image)),
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
            TextFormField(
              controller: studentName,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                          topRight: Radius.circular(25))),
                  hintText: 'Enter name Here',
                  label: Text('Name')),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * .2,
                  child: TextFormField(
                    maxLength: 2,
                    keyboardType: TextInputType.number,
                    controller: studentAge,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(25))),
                        hintText: 'XX',
                        label: Text('Age')),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .68,
                  child: TextFormField(
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    controller: studentPhone,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(25),
                                bottomRight: Radius.circular(25))),
                        hintText: 'XXXXXXXXXX',
                        label: Text('Phone')),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: studentAddress,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                          bottomLeft: Radius.circular(25))),
                  hintText: 'Text Address',
                  label: Text('Address')),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    onEditButtonClicked();
                  },
                  icon: const Icon(Icons.thumb_up),
                  label: const Text('OK'),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> onEditButtonClicked() async {
    final studentmodel = StudentModel(
        photo: widget.image,
        name: studentName.text.trim(),
        age: studentAge.text.trim(),
        phoneNumber: studentPhone.text.trim(),
        address: studentAddress.text.trim());
    final eName = studentName.text;
    final eAge = studentAge.text;
    final ephone = studentPhone.text;
    final eAddress = studentAddress.text;
    if (eName.isEmpty || eAge.isEmpty || ephone.isEmpty || eAddress.isEmpty) {
      showSnackbarMessage(context);
    } else {
      BlocProvider.of<StudentBlocBloc>(context).add(StudentEditEvent(
          name: eName,
          age: eAge,
          phoneNumber: ephone,
          address: eAddress,
          photo: widget.image,
          id: widget.index));
      // editStudent(widget.index, studentmodel);
      Navigator.of(context).pop();
    }
  }
}

Future<void> showSnackbarMessage(BuildContext context) async {
  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(30),
      content: Text('Items are Requierd')));
}
