import 'dart:io';
// import 'dart:js_util';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weak_five_studentlist_main/widgets/student_cards.dart';
import 'package:weak_five_studentlist_main/widgets/student_details.dart';

import '../bloc/student_bloc/student_bloc_bloc.dart';
// import '../db/functions/db_functions.dart';
// import '../db/model/data_model.dart';
import '../db/model/data_model.dart';
import 'edit_students.dart';

class WidgetStudentList extends StatelessWidget {
  const WidgetStudentList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentBlocBloc, StudentBlocState>(
      builder: (context, state) {
        if (state is StudentStateInitial) {
          return Container();
        } else if (state is StudentStateYourStudent) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (context, index) {
              final data = state.students[index];
              return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => WidgetStudentDetails(
                            photo: data.photo,
                            name: data.name,
                            age: data.age,
                            address: data.address,
                            phone: data.phoneNumber,
                            index: index)));
                  },
                  onLongPress: () {
                    bottumSheetMain(context, data, index);
                  },
                  child: WidgetStudentCart(
                    name: data.name,
                    imagePath: data.photo,
                  ));
            },
            itemCount: state.students.length,
          );
          // ListView.separated(
          //     itemBuilder: (context, index) {
          //       final data = state.students[index];
          //       return
          //           // padding: const EdgeInsets.all(8.0),
          //           ListTile(
          //               onTap: () {
          //                 Navigator.of(context).push(MaterialPageRoute(
          //                     builder: (ctx) => WidgetStudentDetails(
          //                         photo: data.photo,
          //                         name: data.name,
          //                         age: data.age,
          //                         address: data.address,
          //                         phone: data.phoneNumber,
          //                         index: index)));
          //               },
          //               leading: CircleAvatar(
          //                 radius: 30,
          //                 backgroundImage: FileImage(File(data.photo)),
          //               ),
          //               title: Text(data.name),
          //               trailing: Row(
          //                 mainAxisSize: MainAxisSize.min,
          //                 children: [
          //                   IconButton(
          //                     onPressed: () {
          //                       Navigator.of(context).push(MaterialPageRoute(
          //                           builder: (ctx) => WidgetEiditStudent(
          //                               image: data.photo,
          //                               photo: '',
          //                               name: data.name,
          //                               age: data.age,
          //                               address: data.address,
          //                               phone: data.phoneNumber,
          //                               index: index)));
          //                     },
          //                     icon: const Icon(Icons.edit),
          //                     color: Colors.brown,
          //                   ),
          //                   IconButton(
          //                     onPressed: () {
          //                       showDialog(
          //                           context: context,
          //                           builder: (ctx1) {
          //                             return AlertDialog(
          //                               backgroundColor: Colors.brown,
          //                               title: const Text(
          //                                 'Sure',
          //                                 style: TextStyle(color: Colors.white),
          //                               ),
          //                               content: Text(
          //                                 'Delete ${data.name.toUpperCase()} ?',
          //                                 style: const TextStyle(
          //                                     color: Colors.white),
          //                               ),
          //                               actions: [
          //                                 TextButton(
          //                                     onPressed: () {
          //                                       BlocProvider.of<
          //                                                   StudentBlocBloc>(
          //                                               context)
          //                                           .add(StudentDeleteEvent(
          //                                               id: index));
          //                                       Navigator.of(ctx1).pop();
          //                                     },
          //                                     child: const Text(
          //                                       'Yes',
          //                                       style: TextStyle(
          //                                           color: Colors.white),
          //                                     )),
          //                                 TextButton(
          //                                     onPressed: () {
          //                                       Navigator.of(ctx1).pop();
          //                                     },
          //                                     child: const Text(
          //                                       'No',
          //                                       style: TextStyle(
          //                                           color: Colors.white),
          //                                     ))
          //                               ],
          //                             );
          //                           });
          //                     },
          //                     icon: const Icon(Icons.delete),
          //                     color: Colors.brown,
          //                   ),
          //                 ],
          //               ));
          //     },
          //     separatorBuilder: (context, index) {
          //       return const Divider();
          //     },
          //     itemCount: state.students.length);
        } else if (state is StudentStateLoading) {
          return const CircularProgressIndicator();
        } else {
          return const Text('Error while getting data');
        }
      },
    );
    // ValueListenableBuilder(
    //     valueListenable: studentListNotifier,
    //     builder:
    //         (BuildContext ctx, List<StudentModel> studentList, Widget? child) {
    //       return ListView.separated(
    //           itemBuilder: (ctx, index) {
    //             final data = studentList[index];
    //             return Padding(
    //               padding: const EdgeInsets.all(8.0),
    //               child: ListTile(
    //                   onTap: () {
    //                     Navigator.of(context).push(MaterialPageRoute(
    //                         builder: (ctx) => WidgetStudentDetails(
    //                             photo: data.photo,
    //                             name: data.name,
    //                             age: data.age,
    //                             address: data.address,
    //                             phone: data.phoneNumber,
    //                             index: index)));
    //                   },
    //                   leading: CircleAvatar(
    //                     radius: 30,
    //                     backgroundImage: FileImage(File(data.photo)),
    //                   ),
    //                   title: Text(data.name),
    //                   trailing: Row(
    //                     mainAxisSize: MainAxisSize.min,
    //                     children: [
    //                       IconButton(
    //                         onPressed: () {
    //                           Navigator.of(context).push(MaterialPageRoute(
    //                               builder: (ctx) => WidgetEiditStudent(
    //                                   image: data.photo,
    //                                   photo: '',
    //                                   name: data.name,
    //                                   age: data.age,
    //                                   address: data.address,
    //                                   phone: data.phoneNumber,
    //                                   index: index)));
    //                         },
    //                         icon: const Icon(Icons.edit),
    //                         color: Colors.brown,
    //                       ),
    //                       IconButton(
    //                         onPressed: () {
    //                           showDialog(
    //                               context: ctx,
    //                               builder: (ctx1) {
    //                                 return AlertDialog(
    //                                   backgroundColor: Colors.brown,
    //                                   title: const Text(
    //                                     'Sure',
    //                                     style: TextStyle(color: Colors.white),
    //                                   ),
    //                                   content: Text(
    //                                     'Delete ${data.name.toUpperCase()} ?',
    //                                     style: const TextStyle(
    //                                         color: Colors.white),
    //                                   ),
    //                                   actions: [
    //                                     TextButton(
    //                                         onPressed: () {
    //                                           deleteStudent(index);
    //                                           Navigator.of(ctx1).pop();
    //                                         },
    //                                         child: const Text(
    //                                           'Yes',
    //                                           style: TextStyle(
    //                                               color: Colors.white),
    //                                         )),
    //                                     TextButton(
    //                                         onPressed: () {
    //                                           Navigator.of(ctx1).pop();
    //                                         },
    //                                         child: const Text(
    //                                           'No',
    //                                           style: TextStyle(
    //                                               color: Colors.white),
    //                                         ))
    //                                   ],
    //                                 );
    //                               });
    //                         },
    //                         icon: const Icon(Icons.delete),
    //                         color: Colors.brown,
    //                       ),
    //                     ],
    //                   )),
    //             );
    //           },
    //           separatorBuilder: (ctx, index) {
    //             return const Divider();
    //           },
    //           itemCount: studentList.length);
    //     });
  }

  Future<void> bottumSheetMain(
      BuildContext ctx, StudentModel value, int index) {
    return showModalBottomSheet(
      context: ctx,
      builder: (context) {
        return SizedBox(
          height: 100,
          width: double.infinity,
          // color: Colors.amber,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton.icon(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (ctx) => WidgetEiditStudent(
                            image: value.photo,
                            photo: '',
                            name: value.name,
                            age: value.age,
                            address: value.address,
                            phone: value.phoneNumber,
                            index: index)));
                  },
                  icon: const Icon(Icons.edit),
                  label: const Text('Edit')),
              TextButton.icon(
                  onPressed: () {
                    showDialog(
                        context: ctx,
                        builder: (ctx1) {
                          return AlertDialog(
                            backgroundColor: Colors.brown,
                            title: const Text(
                              'Sure',
                              style: TextStyle(color: Colors.white),
                            ),
                            content: Text(
                              'Delete ${value.name.toUpperCase()} ?',
                              style: const TextStyle(color: Colors.white),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    BlocProvider.of<StudentBlocBloc>(context)
                                        .add(StudentDeleteEvent(id: index));
                                    Navigator.of(ctx1).pop();
                                    Navigator.of(ctx).pop();
                                  },
                                  child: const Text(
                                    'Yes',
                                    style: TextStyle(color: Colors.white),
                                  )),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(ctx1).pop();
                                  },
                                  child: const Text(
                                    'No',
                                    style: TextStyle(color: Colors.white),
                                  ))
                            ],
                          );
                        });
                  },
                  icon: const Icon(Icons.delete),
                  label: const Text('Delete')),
            ],
          ),
        );
      },
    );
    ;
  }
}
