part of 'current_location_bloc.dart';

enum CurrentLocationStatus { initial, loading, success, failure }

class CurrentLocationState extends Equatable {
  final CurrentLocationStatus status;
  final Position? currentLocationData;
  final String? failureMessage;

  const CurrentLocationState({
    this.status = CurrentLocationStatus.initial,
    this.currentLocationData,
    this.failureMessage,
  });

  @override
  List<Object?> get props => [
        status,
        currentLocationData,
        failureMessage,
      ];

  CurrentLocationState copyWith({
    CurrentLocationStatus? status,
    Position? currentLocationData,
    String? failureMessage,
  }) {
    return CurrentLocationState(
      status: status ?? this.status,
      currentLocationData: currentLocationData ?? this.currentLocationData,
      failureMessage: failureMessage ?? this.failureMessage,
    );
  }
}
