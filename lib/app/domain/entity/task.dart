import 'package:equatable/equatable.dart';

class Task extends Equatable{

  final int? id;
  final String name;
  final String description;
  final int quantity;
  final String latitude;
   final String longitude;
  final String photo;
  final String date;

  const Task(
      { this.id,
      required this.name,
      required this.description,
      required this.latitude,
      required this.longitude,
      required this.photo,
      required this.date,
      required this.quantity});
      
  @override
  List<Object?> get props => [id,name,description,quantity,latitude,longitude,photo,date];

}