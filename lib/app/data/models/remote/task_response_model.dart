import 'package:equatable/equatable.dart';
import 'package:task_mobile/app/domain/entity/task_request_remote.dart';

class TaskModel extends Equatable {
  final int id;
  final String meetingTittle;
  final String meetingLocation;
  final String meetingNotes;
  final String meetingParticipants;
  final String latitude;
  final String longitude;
  final String photo;
  final String date;
  final String address;

  const TaskModel(
      {required this.id,
      required this.meetingTittle,
      required this.meetingLocation,
      required this.meetingNotes,
      required this.meetingParticipants,
      required this.latitude,
      required this.longitude,
      required this.photo,
      required this.date,
      required this.address});

  TaskRequestRemote toEntity() => TaskRequestRemote(
      id: id,
      meetingTittle: meetingTittle,
      meetingLocation: meetingLocation,
      meetingNotes: meetingNotes,
      meetingParticipants: meetingParticipants,
      latitude: latitude,
      longitude: longitude,
      photo: photo,
      date: date,
      address: address
      );

  factory TaskModel.fromEntity(TaskRequestRemote task) => TaskModel(
      id: task.id,
      meetingTittle: task.meetingTittle,
      meetingLocation: task.meetingLocation,
      meetingNotes: task.meetingNotes,
      meetingParticipants: task.meetingParticipants,
      latitude: task.latitude,
      longitude: task.longitude,
      photo: task.photo,
      date: task.date,
      address: task.address);

  factory TaskModel.fromMap(Map<String, dynamic> map) => TaskModel(
      id: map['id'],
      meetingTittle: map['title'],
      meetingLocation: map['location'],
      meetingNotes: map['notes'],
      meetingParticipants: map['participants'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      photo: map['image_url'],
      date: map['date'],
      address: map['address']
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'tittle': meetingTittle,
        'location': meetingLocation,
        'notes': meetingNotes,
        'participants' : meetingParticipants,
        'latitude': latitude,
        'longitude': longitude,
        'photo': photo,
        'date': date,
        'meetingNotes': meetingNotes,
        'address': address,
      };

  Map<String, dynamic> toJsonRemote() => {
        'meetingTittle': meetingTittle,
        'meetingLocation': meetingLocation,
        'latitude': latitude,
        'longitude': longitude,
        'photo': photo,
        'date': date,
        'meetingNotes': meetingNotes,
        'address': address
      };

  @override
  List<Object?> get props => [
        id,
        meetingTittle,
        meetingLocation,
        meetingNotes,
        latitude,
        longitude,
        photo,
        date,
        address
      ];
}
