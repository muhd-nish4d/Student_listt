import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:weak_five_studentlist_main/bloc/student_bloc/student_bloc_bloc.dart';
import 'package:weak_five_studentlist_main/db/functions/db_functions.dart';
import 'package:weak_five_studentlist_main/screens/home_screens.dart';

import 'bloc/image_bloc/image_bloc.dart';
import 'db/model/data_model.dart';

Future<void> main() async {
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(StudentModelAdapter().typeId)) {
    Hive.registerAdapter(StudentModelAdapter());
  }
  runApp(BlocProvider(
    create: (context) => StudentBlocBloc(StudentDatabase()),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<StudentBlocBloc>(context).add(StudentInitialEvent());
    // BlocProvider.of<ImageBloc>(context).add(GetImageEvent());
    return MultiBlocProvider(
        providers: [
          // BlocProvider<StudentBlocBloc>(
          //   create: (context) => StudentBlocBloc(StudentDatabase()),
          // ),
          BlocProvider<ImageBloc>(
            create: (context) => ImageBloc(),
          )
        ],
        child: MaterialApp(
          title: 'Students List',
          theme: ThemeData(primarySwatch: Colors.brown),
          home: const ScreenHome(),
        ));
  }
}
