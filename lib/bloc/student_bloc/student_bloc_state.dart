part of 'student_bloc_bloc.dart';

abstract class StudentBlocState extends Equatable {
  // const StudentBlocState();
  
  @override
  List<Object> get props => [];
}


// Initial
class StudentStateInitial extends StudentBlocState {}


// Loading
class StudentStateLoading extends StudentBlocState {}


// Edit
class StudentStateEdit  extends StudentBlocState {
  final List<StudentModel> students;

  StudentStateEdit({required this.students});
}


//Your
class StudentStateYourStudent extends StudentBlocState{
  final List<StudentModel> students;

  StudentStateYourStudent({required this.students});
}

// New 
class NewStudentState extends StudentBlocEvent {}