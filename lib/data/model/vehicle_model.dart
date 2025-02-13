import 'package:equatable/equatable.dart';

class Vehicle extends Equatable {
  final String id;
  final String name;
  final String type;
  final double mileage;
  final int year;

  const Vehicle({
    required this.id,
    required this.name,
    required this.type,
    required this.mileage,
    required this.year,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      mileage: (json['mileage'] as num).toDouble(),
      year: json['year'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'mileage': mileage,
      'year': year,
    };
  }

  @override
  List<Object?> get props => [id, name, type, mileage, year];
}
