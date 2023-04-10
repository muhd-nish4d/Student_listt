import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../db/functions/db_functions.dart';
import '../../db/model/data_model.dart';

part 'student_bloc_event.dart';
part 'student_bloc_state.dart';

class StudentBlocBloc extends Bloc<StudentBlocEvent, StudentBlocState> {
  final StudentDatabase studentDatabase;
  List<StudentModel> student = [];
  StudentBlocBloc(this.studentDatabase) : super(StudentStateInitial()) {
    on<StudentInitialEvent>((event, emit) async {
      emit(StudentStateLoading());
      await _getStudents();
      emit(StudentStateYourStudent(students: student));
    });
    on<StudentAddEvent>((event, emit) async {
      emit(StudentStateLoading());
      await _addStudent(
          name: event.name,
          age: event.age,
          phoneNumber: event.phoneNumber,
          address: event.address,
          photo: event.photo);
      await _getStudents();
      emit(StudentStateYourStudent(students: student));
    });
    on<StudentEditEvent>((event, emit) async {
      emit(StudentStateLoading());
      await _updateStudent(
          name: event.name,
          id: event.id,
          age: event.age,
          phoneNumber: event.phoneNumber,
          address: event.address,
          photo: event.photo);
      await _getStudents();
      emit(StudentStateYourStudent(students: student));
    });
    on<StudentDeleteEvent>((event, emit) async {
      emit(StudentStateLoading());
      await _removeFromList(id: event.id);
      await _getStudents();
      emit(StudentStateYourStudent(students: student));
    });
  }

  // //Streamer function
  // Stream<StudentBlocState> _mapInitialEventToState() async* {
  //   yield StudentStateLoading();
  //   await _getStudents();
  //   yield StudentStateYourStudent(students: student);
  // }

  // Stream<StudentBlocState> _mapAddEventToState(
  //     {required String name,
  //     required String age,
  //     required String phoneNumber,
  //     required String address,
  //     required String photo}) async* {
  //   yield StudentStateLoading();
  //   await _addStudent(
  //       address: address,
  //       age: age,
  //       name: name,
  //       phoneNumber: phoneNumber,
  //       photo: photo);
  //   yield StudentStateYourStudent(students: student);
  // }

  // Stream<StudentBlocState> _mapEditEventToState(
  //     {required String name,
  //     required int id,
  //     required String age,
  //     required String phoneNumber,
  //     required String address,
  //     required String photo}) async* {
  //   yield StudentStateLoading();
  //   await _updateStudent(
  //       address: address,
  //       age: age,
  //       id: id,
  //       name: name,
  //       phoneNumber: phoneNumber,
  //       photo: photo);
  //   yield StudentStateYourStudent(students: student);
  // }

  // Stream<StudentBlocState> _mapDeleteEventToState({required int id}) async* {
  //   yield StudentStateLoading();
  //   await _removeFromList(id: id);
  // }

  //Helping function
  Future<void> _getStudents() async {
    await studentDatabase.getAllStudents().then((value) {
      student = value;
    });
  }

  Future<void> _addStudent(
      {required String name,
      required String age,
      required String phoneNumber,
      required String address,
      required String photo}) async {
    await studentDatabase.addStudent(StudentModel(
      // id: DateTime.now().toString(),
        name: name,
        age: age,
        phoneNumber: phoneNumber,
        address: address,
        photo: photo));
  }

  Future<void> _updateStudent(
      {required String name,
      required int id,
      required String age,
      required String phoneNumber,
      required String address,
      required String photo}) async {
    await studentDatabase.editStudent(
        id,
        StudentModel(
            name: name,
            age: age,
            phoneNumber: phoneNumber,
            address: address,
            photo: photo));
  }

  Future<void> _removeFromList({required id}) async {
    await studentDatabase.deleteStudent(id);
    await _getStudents();
  }
}

//hu