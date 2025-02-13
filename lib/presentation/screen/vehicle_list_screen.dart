import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/Vehicle/vehicle_bloc.dart';
import '../../data/model/vehicle_model.dart';
import '../../data/repository/vehicle_repository.dart';
import '../widgets/shimmer_effect.dart';
import '../widgets/vehicle_detail_screen.dart';

class VehicleListScreen extends StatelessWidget {
  const VehicleListScreen({super.key});

  Color _getVehicleColor(Vehicle vehicle) {
    int currentYear = DateTime.now().year;
    int age = currentYear - vehicle.year;
    if (vehicle.mileage >= 15) {
      return (age <= 5) ? Colors.green : Colors.amber;
    }
    return Colors.red;
  }

  IconData _getVehicleIcon(String name) {
    if (name.toLowerCase().contains('car')) {
      return Icons.directions_car;
    } else if (name.toLowerCase().contains('bike')) {
      return Icons.two_wheeler;
    } else if (name.toLowerCase().contains('truck')) {
      return Icons.local_shipping;
    }
    return Icons.directions_car; // Default
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Vehicle List'),
          backgroundColor: Colors.blueAccent,
        ),
        body: BlocProvider(
          create: (context) =>
              VehicleBloc(VehicleRepository())..add(FetchVehicles()),
          child: BlocBuilder<VehicleBloc, VehicleState>(
            builder: (context, state) {
              if (state is VehicleLoading) {
                return ShimmerEffect();
              } else if (state is VehicleLoaded) {
                return Container(
                  color: const Color.fromARGB(179, 210, 203, 203),
                  child: ListView.builder(
                    itemCount: state.vehicles.length,
                    itemBuilder: (context, index) {
                      final vehicle = state.vehicles[index];
                      return Card(
                        elevation: 4,
                        margin: const EdgeInsets.all(8),
                        color: _getVehicleColor(vehicle),
                        child: ListTile(
                          leading: Icon(
                            _getVehicleIcon(vehicle.type),
                            size: 30,
                            color: Colors.white,
                          ),
                          title: Text(
                            vehicle.name,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          subtitle: Text(
                            'Mileage: ${vehicle.mileage} km/l | Year: ${vehicle.year}',
                            style: const TextStyle(color: Colors.white70),
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios,
                              color: Colors.white),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    VehicleDetailScreen(vehicle: vehicle),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                );
              } else if (state is VehicleError) {
                return Center(child: Text(state.message));
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
