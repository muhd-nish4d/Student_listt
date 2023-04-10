// import 'package:flutter/cupertino.dart';
// import 'package:hive_flutter/adapters.dart';

// import '../model/data_model.dart';

// ValueNotifier<List<StudentModel>> studentListNotifier = ValueNotifier([]);

// Future<void> addStudent(StudentModel value) async{
  
//   final studentDB = await Hive.openBox<StudentModel>('student_db');
//   final idDB = await studentDB.add(value);
//   value.id = idDB;
//   studentListNotifier.value.add(value);
//   // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
//   studentListNotifier.notifyListeners();
// }

// Future<void> getAllStudents() async {
//   final studentDB = await Hive.openBox<StudentModel>('student_db');
//   studentListNotifier.value.clear();
//   studentListNotifier.value.addAll(studentDB.values);
//   // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
//   studentListNotifier.notifyListeners();
// }

// Future<void> deleteStudent(int index) async{
//   final studentDB = await Hive.openBox<StudentModel>('student_db');
//   await studentDB.deleteAt(index);
//   getAllStudents();

// }

// Future<void> editStudent(int id, StudentModel value) async{
//   final studentDB = await Hive.openBox<StudentModel>('student_db');
//   studentDB.putAt(id, value);
//   getAllStudents();
// }


/* StudentModel = Note
studentOpenBox = noteBox
getAllStudent = getFullNote
*/
//
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weak_five_studentlist_main/db/model/data_model.dart';

class StudentDatabase{
  String boxName = 'student_db';
  // Open a box
  Future<Box<StudentModel>> studentOpenBox() async{
    var box = await Hive.openBox<StudentModel>(boxName);
    return box;
  }
  // Git Student details
  Future<List<StudentModel>> getAllStudents() async{
    final box = await studentOpenBox();
    List<StudentModel> students = box.values.toList();
    return students;
  }
  //Add Student
  Future<void> addStudent(StudentModel student) async{
    final box = await studentOpenBox();
    student.id = await box.add(student);
    // await box.add(student);
  }
  //Delete Student
  Future<void> deleteStudent(int index) async{
    final box = await studentOpenBox();
    await box.deleteAt(index);
  }
  //Update Student
  Future<void> editStudent(int id, StudentModel student)async{
    final box = await studentOpenBox();
    await box.putAt(id, student);
  }
}