part of 'image_bloc.dart';

abstract class ImageState extends Equatable {
  const ImageState();
  
  @override
  List<Object> get props => [];
}

class ImageInitial extends ImageState {}

class ImageLoadingState extends ImageState {}

class ImageLoadedState extends ImageState {
  final File imageFile;

  const ImageLoadedState(this.imageFile);
}

class ImageErrorState extends ImageState {
  final String errorMessage;

  const ImageErrorState(this.errorMessage);
}