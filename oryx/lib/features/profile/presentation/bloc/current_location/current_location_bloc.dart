import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../../../core/blocs/event_transformer.dart';
import '../../../domain/usecase/get_current_location.dart';

part 'current_location_event.dart';
part 'current_location_state.dart';

class CurrentLocationBloc extends Bloc<CurrentLocationEvent, CurrentLocationState> {
  final GetCurrentLocation getCurrentLocation;

  CurrentLocationBloc({required this.getCurrentLocation}) : super(const CurrentLocationState()) {
    on<CurrentLocationRequested>(_currentLocationRequested, transformer: Transformer.throttleDroppable());
  }

  FutureOr<void> _currentLocationRequested(CurrentLocationRequested event, Emitter<CurrentLocationState> emit) async {
    debugPrint('CurrentLocationBloc --> CurrentLocationStatus Before getCurrentLocation --> ${state.status}');
    Either<Failure, Position> result = await getCurrentLocation(NoParams());
    debugPrint('CurrentLocationBloc --> CurrentLocationStatus After getCurrentLocation --> ${state.status}');
    result.fold(
      (failure) {
        String message = '';
        if(failure is DeviceFailure) {
          message = failure.message;
        } else if(failure is NoPermissionFailure) {
          message = "No Permission Granted!";
        } else {
          message = "Data fetching failed. Please try again later!";
        }
        debugPrint('CurrentLocationBloc --> CurrentLocationStatus.failure $message');
        emit(state.copyWith(
          status: CurrentLocationStatus.failure,
          failureMessage: message.contains('PlatformException(PERMISSION_DENIED') ? "No Permission Granted!" : message,
        ));
      },
      (data) {
        debugPrint('CurrentLocationBloc --> CurrentLocationStatus.success ${data.latitude} ${data.longitude}');
        emit(state.copyWith(
          status: CurrentLocationStatus.success,
          currentLocationData: data,
        ));
      },
    );
  }
}
