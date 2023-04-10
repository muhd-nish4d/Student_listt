import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

part 'image_event.dart';
part 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  ImageBloc() : super(ImageInitial()) {
    on<GetImageEvent>((event, emit) async{
      emit(ImageLoadingState());
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        emit(ImageLoadedState(File(pickedFile.path)));
      }else{
        emit(const ImageErrorState('No image selected'));
      }
    });
  }
}
