part of 'image_bloc.dart';

abstract class ImageEvent extends Equatable {
  const ImageEvent();

  @override
  List<Object> get props => [];
}

class GetImageEvent extends ImageEvent {}

class RemoveImageEvent extends ImageEvent {}