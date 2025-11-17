part of 'pick_image_bloc.dart';

abstract class PickImageEvent extends Equatable {
  const PickImageEvent();
}

class OnInit extends PickImageEvent {
  const OnInit();
  @override
  List<Object?> get props => [];
}
