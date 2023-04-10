part of 'student_bloc_bloc.dart';

abstract class StudentBlocEvent extends Equatable {
  // const StudentBlocEvent();

  @override
  List<Object> get props => [];
}

//Initial event
class StudentInitialEvent extends StudentBlocEvent {}

//add event
class StudentAddEvent extends StudentBlocEvent {
  final String name, age, phoneNumber, address, photo;

  StudentAddEvent(
      {required this.name,
      required this.age,
      required this.phoneNumber,
      required this.address,
      required this.photo});
}

//edit event
class StudentEditEvent extends StudentBlocEvent {
  final String name, age, phoneNumber, address, photo;
  final int id;

  StudentEditEvent(
      {required this.name,
      required this.age,
      required this.phoneNumber,
      required this.address,
      required this.photo,
      required this.id});
}

//delete event
class StudentDeleteEvent extends StudentBlocEvent {
  final int id;

  StudentDeleteEvent({required this.id});  
}

// //image edit
// class StudentDp extends StudentBlocEvent{
//   final String image;

//   StudentDp({required this.image});
// }