
import 'package:flutter/material.dart';

import '../../data/model/vehicle_model.dart';

class VehicleDetailScreen extends StatelessWidget {
  final Vehicle vehicle;
  const VehicleDetailScreen({super.key, required this.vehicle});

  IconData _getVehicleIcon(String name) {
    if (name.toLowerCase().contains('car')) {
      return Icons.directions_car;
    } else if (name.toLowerCase().contains('bike')) {
      return Icons.two_wheeler;
    } else if (name.toLowerCase().contains('truck')) {
      return Icons.local_shipping;
    }
    return Icons.directions_car; // Default icon
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(vehicle.name),
        backgroundColor: Colors.blueAccent,
      ),
      backgroundColor: const Color.fromARGB(250, 210, 203, 203),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Vehicle Icon with Animation
              Hero(
                tag: vehicle.name, // Smooth transition effect
                child: Icon(
                  _getVehicleIcon(vehicle.type),
                  size: 100,
                  color: Colors.blueAccent,
                ),
              ),
              const SizedBox(height: 20),

              // Animated Vehicle Details
              TweenAnimationBuilder(
                duration: const Duration(milliseconds: 700),
                tween: Tween<double>(begin: 0, end: 1),
                builder: (context, double opacity, child) {
                  return Opacity(
                    opacity: opacity,
                    child: child,
                  );
                },
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDetailRow(
                            Icons.directions_car, 'Vehicle Name', vehicle.name),
                        _buildDetailRow(
                            Icons.speed, 'Mileage', '${vehicle.mileage} km/l'),
                        _buildDetailRow(Icons.calendar_today, 'Year',
                            vehicle.year.toString()),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blueAccent, size: 28),
          const SizedBox(width: 12),
          Text(
            '$title: ',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 16, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
