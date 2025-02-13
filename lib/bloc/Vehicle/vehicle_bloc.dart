import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../../data/model/vehicle_model.dart';
import '../../data/repository/vehicle_repository.dart';

part 'vehicle_event.dart';
part 'vehicle_state.dart';

class VehicleBloc extends Bloc<VehicleEvent, VehicleState> {
  final VehicleRepository vehicleRepository;

  VehicleBloc(this.vehicleRepository) : super(VehicleLoading()) {
    on<LoadVehicles>((event, emit) async {
      try {
        final vehicles = await vehicleRepository.fetchVehicles();
        emit(VehicleLoaded(vehicles));
      } catch (e) {
        emit(VehicleError(e.toString()));
      }
    });
    on<FetchVehicles>(_onFetchVehicles);
  }
}

Future<void> _onFetchVehicles(
    FetchVehicles event, Emitter<VehicleState> emit) async {
  try {
    emit(VehicleLoading());

    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('vehicles').get();
    List<Vehicle> vehicles = snapshot.docs.map((doc) {
      var data = doc.data() as Map<String, dynamic>;

      return Vehicle(
        name: data['name'] ?? 'Unknown Vehicle',
        type: data['type'] ?? 'car',
        mileage: (data['mileage'] ?? 0).toDouble(),
        year: (data['year'] ?? 0).toInt(),
        id: '',
      );
    }).toList();

    emit(VehicleLoaded(vehicles));
  } catch (error) {
    emit(VehicleError("Failed to load vehicles: $error"));
  }
}
