import 'package:equatable/equatable.dart';
import 'package:task_mobile/app/domain/entity/task_request_local.dart';

class TaskRequestRemote extends Equatable {
  final int id;
  final String meetingTittle;
  final String meetingLocation;
  final String meetingNotes;
  final String meetingParticipants;
  final String latitude;
  final String longitude;
  String photo;
  final String date;
  final String address;

  TaskRequestRemote(
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

  

  factory TaskRequestRemote.fromMap(Map<String, dynamic> map) =>
      TaskRequestRemote(
          id: map['id'],
          meetingTittle: map['tittle'],
          meetingLocation: map['location'],
          meetingNotes: map['notes'],
          meetingParticipants: map['participants'],
          latitude: map['latitude'],
          longitude: map['longitude'],
          photo: map['photo'],
          date: map['date'],
          address: map['address']);

  @override
  List<Object?> get props => [
        id,
        meetingTittle,
        meetingLocation,
        meetingNotes,
        meetingParticipants,
        latitude,
        longitude,
        photo,
        date,
        address
      ];
}
