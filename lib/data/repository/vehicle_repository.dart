import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/vehicle_model.dart';

class VehicleRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Vehicle>> fetchVehicles() async {
    try {
      final querySnapshot = await _firestore.collection('vehicles').get();
      return querySnapshot.docs
          .map((doc) => Vehicle.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('Failed to load vehicles: $e');
    }
  }
}
