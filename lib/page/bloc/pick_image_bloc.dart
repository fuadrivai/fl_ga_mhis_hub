import 'package:equatable/equatable.dart';
import 'package:fl_ga_mhis_hub/model/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'pick_image_event.dart';
part 'pick_image_state.dart';

class PickImageBloc extends Bloc<PickImageEvent, PickImageState> {
  PickImageBloc() : super(PickImageState()) {
    on<OnInit>(_onInit);
  }

  void _onInit(OnInit event, Emitter<PickImageState> emit) async {
    emit(state.copyWith(isLoading: true, isError: false, isSuccess: false));
  }
}
