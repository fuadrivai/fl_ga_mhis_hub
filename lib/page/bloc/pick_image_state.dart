part of 'pick_image_bloc.dart';

final class PickImageState extends Equatable {
  final bool isLoading, isError, isSuccess;
  final String? errorMessage;
  final AttendanceLog? log;
  const PickImageState({
    this.isLoading = false,
    this.isError = false,
    this.isSuccess = false,
    this.errorMessage,
    this.log,
  });
  PickImageState copyWith({
    bool? isLoading,
    bool? isError,
    bool? isSuccess,
    String? errorMessage,
    AttendanceLog? log,
  }) {
    return PickImageState(
      errorMessage: errorMessage ?? this.errorMessage,
      isError: isError ?? this.isError,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      log: log ?? this.log,
    );
  }

  @override
  List<Object?> get props => [errorMessage, isLoading, isError, isSuccess, log];
}
