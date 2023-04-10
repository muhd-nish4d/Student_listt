import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weak_five_studentlist_main/db/functions/db_functions.dart';
import 'package:weak_five_studentlist_main/widgets/student_details.dart';
import 'package:weak_five_studentlist_main/widgets/student_list.dart';

import '../bloc/student_bloc/student_bloc_bloc.dart';
import '../db/model/data_model.dart';

class WidgetSearch extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return
        // return ValueListenableBuilder(
        //     valueListenable: studentListNotifier,
        //     builder:
        //         (BuildContext ctx, List<StudentModel> studentList, Widget? child) {
        //       return ListView.builder(
        //         itemBuilder: (ctx, index) {
        //           final data = studentList[index];
        //           if (data.name.toLowerCase().contains(
        //                 query.toLowerCase(),
        //               )) {
        //             return Column(
        //               children: [
        //                 ListTile(
        //                   onTap: () {
        //                     Navigator.of(context).push(MaterialPageRoute(
        //                         builder: (ctx) => const WidgetStudentList()));
        //                   },
        //                   title: Text(data.name),
        //                   leading: CircleAvatar(
        //                     radius: 30,
        //                     backgroundImage: FileImage(File(data.photo)),
        //                   ),
        //                 ),
        //                 const Divider()
        //               ],
        //             );
        //           } else {
        //             return Container();
        //           }
        //         },
        //         itemCount: studentList.length,
        //       );
        //     });
        BlocBuilder<StudentBlocBloc, StudentBlocState>(
      builder: (context, state) {
        if (state is StudentStateYourStudent) {
          return ListView.builder(
            itemBuilder: (ctx, index) {
              final data = state.students[index];
              if (data.name
                  .toLowerCase()
                  .contains(query.toLowerCase().trim())) {
                return Column(
                  children: [
                    ListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => WidgetStudentDetails(
                                name: data.name,
                                age: data.age,
                                address: data.address,
                                phone: data.phoneNumber,
                                index: index,
                                photo: data.photo)));
                      },
                      title: Text(data.name),
                      leading: CircleAvatar(
                        backgroundImage: FileImage(File(data.photo)),
                      ),
                    ),
                    const Divider()
                  ],
                );
              } else {
                return Container();
              }
            },
            itemCount: state.students.length,
          );
        } else {
          return Container();
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return BlocBuilder<StudentBlocBloc, StudentBlocState>(
      builder: (context, state) {
        if (state is StudentStateYourStudent) {
          return ListView.builder(
            itemBuilder: (ctx, index) {
              final data = state.students[index];
              if (data.name
                  .toLowerCase()
                  .contains(query.toLowerCase().trim())) {
                return Column(
                  children: [
                    ListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => WidgetStudentDetails(
                                name: data.name,
                                age: data.age,
                                address: data.address,
                                phone: data.phoneNumber,
                                index: index,
                                photo: data.photo)));
                      },
                      title: Text(data.name),
                      leading: CircleAvatar(
                        backgroundImage: FileImage(File(data.photo)),
                      ),
                    ),
                    const Divider()
                  ],
                );
              } else {
                return Container();
              }
            },
            itemCount: state.students.length,
          );
        } else {
          return Container();
        }
      },
    );
  }
}
