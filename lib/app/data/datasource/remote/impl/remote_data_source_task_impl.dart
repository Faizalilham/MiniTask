import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task_mobile/app/data/datasource/remote/remote_data_source_task.dart';
import 'package:task_mobile/app/data/models/remote/task_remote_model.dart';
import 'package:task_mobile/app/data/models/remote/task_response_model.dart';
import 'package:task_mobile/app/utils/exception.dart';
import 'package:task_mobile/app/utils/utils.dart';
import 'package:http/http.dart' as http;

class RemoteDataSourceTaskImpl extends RemoteDataSourceTask {
  final supabase = Supabase.instance;
  final baseUrl = "https://relieved-red-goldfish.cyclic.app";

  @override
  Future<List<TaskModel>> getAllTask() async {
    final response = await http.get(Uri.parse("$baseUrl/meetings"));
    if (response.statusCode == 200) {
      print(response.body);

      final data = json.decode(response.body) ;
      final  taskList = List<TaskModel>.from((data['data'] as List)
          .map((json) => TaskModel.fromMap(json))
          .toList());

      return taskList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> insertTask(TaskRemoteModel entity) async {
    // try {
    //   await supabase.client
    //       .from("task")
    //       .insert(entity.toJsonRemote())
    //       .execute();
    //   return 'Adding data successfully';
    // } catch (e) {
    //   throw e;
    // }
    final file = File(entity.photo);
    final bytes = await compileToBytes(file);
    final uri = Uri.parse("$baseUrl/create-meeting");
    var request = http.MultipartRequest('POST', uri);
    final fileName = fileUploadName(entity.photo);
    

    var multiPartFile =
        http.MultipartFile.fromBytes("image", bytes, filename: fileName);

    final Map<String, String> fields = {
      "title": entity.meetingTittle,
      "location": entity.meetingLocation,
      "notes": entity.meetingNotes,
      "participants": entity.meetingParticipants,
      "latitude": entity.latitude,
      "longitude": entity.longitude,
      "address": entity.address,
      "date": entity.date
    };

    request.files.add(multiPartFile);
    request.fields.addAll(fields);

    final http.StreamedResponse streamedResponse = await request.send();
    final int statusCode = streamedResponse.statusCode;

    final Uint8List responseList = await streamedResponse.stream.toBytes();
    final String responseData = String.fromCharCodes(responseList);

    print("heh $responseData");
    if (statusCode == 200) {
      final result = jsonDecode(responseData);
      return result['message'];
    } else {
      final err = jsonDecode(responseData);
      ;
      throw Exception(err['message']);
    }
  }

  @override
  Future<String> insertImage(String pathImage) {
    // TODO: implement insertImage
    throw UnimplementedError();
  }

  // @override
  // Future<String> insertImage(String pathImage) async {
  //   try {
  //     final file = File(pathImage);
  //     final fileName = fileUploadName(pathImage);
  //     final storageResponse =
  //         await supabase.client.storage.from('images').upload(fileName, file);
  //     final a = await storageResponse;
  //     final String publicUrl =
  //         await supabase.client.storage.from('images').getPublicUrl(fileName);
  //     return publicUrl;
  //   } catch (e) {
  //     throw e;
  //   }
  // }
}
