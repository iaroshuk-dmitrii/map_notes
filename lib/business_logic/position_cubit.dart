import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

class PositionCubit extends Cubit<PositionState> {
  PositionCubit() : super(const PositionInitialState());

  Future<void> getPosition() async {
    LocationPermission locationPermission = await Geolocator.checkPermission();
    emit(const PositionLoadingState());
    if (locationPermission == LocationPermission.denied || locationPermission == LocationPermission.deniedForever) {
      await Geolocator.requestPermission();
    }
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      emit(PositionLoadedState(latitude: position.latitude, longitude: position.longitude));
    } catch (e) {
      emit(const PositionErrorState());
    }
  }
}

abstract class PositionState extends Equatable {
  const PositionState();

  @override
  List<Object> get props => [];
}

class PositionInitialState extends PositionState {
  const PositionInitialState();
}

class PositionLoadingState extends PositionState {
  const PositionLoadingState();
}

class PositionLoadedState extends PositionState {
  final double latitude;
  final double longitude;

  const PositionLoadedState({required this.latitude, required this.longitude});
}

class PositionErrorState extends PositionState {
  const PositionErrorState();
}
