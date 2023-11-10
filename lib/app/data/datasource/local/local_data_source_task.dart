import 'dart:async';


import 'package:task_mobile/app/data/models/local/task_local_model.dart';
import 'package:task_mobile/app/data/models/remote/task_response_model.dart';

abstract class LocalDataSourceTask {
  FutureOr<String> insertTask(TaskLocalModel entity);

  FutureOr<List<TaskLocalModel>> getAllTask();

  Future<String> insertTaskCache(TaskLocalModel task);

  Future<void> deleteTaskCache();

  Future<List<TaskLocalModel>> getAllTaskCache();
}
