import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weak_five_studentlist_main/bloc/student_bloc/student_bloc_bloc.dart';

import '../bloc/image_bloc/image_bloc.dart';

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
  
  dynamic image;

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
                BlocBuilder<ImageBloc, ImageState>(
                  builder: (context, state) {
                    if (state is ImageLoadingState) {
                      return const CircleAvatar(radius: 70,child: CircularProgressIndicator(),);
                    }else if(state is ImageLoadedState){
                      image = state.imageFile.path;
                      return CircleAvatar(
                        radius: 70,
                        backgroundImage: FileImage(File(state.imageFile.path)),
                      );
                    }else if(state is ImageErrorState){
                      return Text(state.errorMessage);
                    }else{
                      return  CircleAvatar(
                        radius: 70,
                        backgroundImage: FileImage(File(widget.image)),
                      );
                    }
                  },
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // getPhoto();
                    BlocProvider.of<ImageBloc>(context).add(GetImageEvent());
                  },
                  icon: const Icon(Icons.photo),
                  label: const Text('Edit Image'),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
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
                    BlocProvider.of<ImageBloc>(context).add(RemoveImageEvent());
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
    // final studentmodel = StudentModel(
    //     photo: image,
    //     name: studentName.text.trim(),
    //     age: studentAge.text.trim(),
    //     phoneNumber: studentPhone.text.trim(),
    //     address: studentAddress.text.trim());
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
          photo: image,
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
