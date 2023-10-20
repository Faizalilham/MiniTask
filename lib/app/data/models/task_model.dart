import 'package:equatable/equatable.dart';
import 'package:task_mobile/app/domain/entity/task.dart';

class TaskModel extends Equatable {
  final int id;
  final String name;
  final String description;
  final int quantity;
  final String latitude;
  final String longitude;
  final String photo;
  final String date;

  const TaskModel(
      {required this.id,
      required this.name,
      required this.description,
      required this.latitude,
      required this.longitude,
      required this.photo,
      required this.date,
      required this.quantity});

  Task toEntity() => Task(
      id: id,
      name: name,
      description: description,
      quantity: quantity,
      latitude: latitude,
      longitude : longitude,
      photo: photo,
      date: date);

   factory TaskModel.fromEntity(Task task) => TaskModel(
      id: task.id ?? 3,
      name: task.name,
      description: task.description,
      quantity: task.quantity,
      latitude: task.latitude,
      longitude: task.longitude,
      photo: task.photo,
      date: task.date);    

   factory TaskModel.fromMap(Map<String, dynamic> map) => TaskModel(
        id: map['id'],
        name: map['name'],
        description: map['description'],
        quantity: map['quantity'],
        latitude: map['latitude'],
        longitude: map['longitude'],
        photo: map['photo'],
        date: map['date']
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'latitude': latitude,
        'longitude': longitude,
        'photo': photo,
        'date': date,
        'quantity': quantity,
      };

  @override
  List<Object?> get props =>
      [id, name, description, quantity, latitude,longitude, photo, date];
}
