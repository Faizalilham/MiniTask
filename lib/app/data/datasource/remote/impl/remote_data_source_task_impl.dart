import 'dart:async';
import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task_mobile/app/data/datasource/remote/remote_data_source_task.dart';
import 'package:task_mobile/app/data/models/task_model.dart';
import 'package:task_mobile/app/utils/utils.dart';

class RemoteDataSourceTaskImpl extends RemoteDataSourceTask {
  final supabase = Supabase.instance;

  @override
  Future<List<Map<String, dynamic>>> getAllTask() async {
    try {
      final result = await supabase.client
          .from('task')
          .select<List<Map<String, dynamic>>>();
      print(result);
      return result;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  @override
  Future<String> insertTask(TaskModel entity) async {
    try {
      await supabase.client
          .from("task")
          .insert(entity.toJsonRemote())
          .execute();
      return 'Adding data successfully';
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<String> insertImage(String pathImage) async {
    try {
      final file = File(pathImage);
      final fileName = fileUploadName(pathImage);
      final storageResponse =
          await supabase.client.storage.from('images').upload(fileName, file);
      final a = await storageResponse;
      final String publicUrl =
          await supabase.client.storage.from('images').getPublicUrl(fileName);
      return publicUrl;
    } catch (e) {
      throw e;
    }
  }
}
