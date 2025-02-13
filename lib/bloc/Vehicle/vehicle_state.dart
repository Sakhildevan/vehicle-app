part of 'vehicle_bloc.dart';

abstract class VehicleState extends Equatable {
  @override
  List<Object> get props => [];
}

class VehicleLoading extends VehicleState {}

class VehicleLoaded extends VehicleState {
  final List<Vehicle> vehicles;
  VehicleLoaded(this.vehicles);

  @override
  List<Object> get props => [vehicles];
}

class VehicleError extends VehicleState {
  final String message;
  VehicleError(this.message);

  @override
  List<Object> get props => [message];
}
