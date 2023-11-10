import 'dart:async';


import 'package:task_mobile/app/data/models/remote/task_remote_model.dart';
import 'package:task_mobile/app/data/models/remote/task_response_model.dart';

abstract class RemoteDataSourceTask {
  Future<String> insertTask(TaskRemoteModel taskRequestModel);

  Future<List<TaskModel>> getAllTask();

  Future<String> insertImage(String pathImage);
}
