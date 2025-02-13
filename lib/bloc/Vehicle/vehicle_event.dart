part of 'vehicle_bloc.dart';

abstract class VehicleEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadVehicles extends VehicleEvent {}

class FetchVehicles extends VehicleEvent {}
