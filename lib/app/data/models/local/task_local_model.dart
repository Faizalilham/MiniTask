
import 'package:equatable/equatable.dart';
import 'package:task_mobile/app/domain/entity/task_request_local.dart';

class TaskLocalModel extends Equatable {
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

  const TaskLocalModel(
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

  TaskRequestLocal toEntity() => TaskRequestLocal(
      id: id,
      meetingTittle: meetingTittle,
      meetingLocation: meetingLocation,
      meetingNotes: meetingNotes,
      meetingParticipants: meetingParticipants,
      latitude: latitude,
      longitude: longitude,
      photo: photo,
      date: date,
      address: address);

  factory TaskLocalModel.fromEntity(TaskRequestLocal task) => TaskLocalModel(
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

  factory TaskLocalModel.fromMap(Map<String, dynamic> map) =>
      TaskLocalModel(
          id: map['id'],
          meetingTittle: map['title'],
          meetingLocation: map['location'],
          meetingNotes: map['notes'],
          meetingParticipants: map['participants'],
          latitude: map['latitude'],
          longitude: map['longitude'],
          photo: map['photo'],
          date: map['date'],
          address: map['address']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': meetingTittle,
        'location': meetingLocation,
        'notes': meetingNotes,
        'participants': meetingParticipants,
        'latitude': latitude,
        'longitude': longitude,
        'photo': photo,
        'date': date,
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
