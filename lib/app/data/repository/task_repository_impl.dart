import 'dart:async';

import 'package:task_mobile/app/data/datasource/local/local_data_source_task.dart';
import 'package:task_mobile/app/data/datasource/remote/remote_data_source_task.dart';
import 'package:task_mobile/app/data/models/local/task_local_model.dart';
import 'package:task_mobile/app/data/models/remote/task_remote_model.dart';
import 'package:task_mobile/app/domain/entity/task_request_remote.dart';
import 'package:task_mobile/app/domain/entity/task_request_local.dart';
import 'package:task_mobile/app/domain/repository/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final LocalDataSourceTask localDataSourceTask;
  final RemoteDataSourceTask remoteDataSourceTask;

  const TaskRepositoryImpl(
      {required this.localDataSourceTask, required this.remoteDataSourceTask});

  @override
  Future<List<TaskRequestLocal>> getAllTask() async {
    final result = await localDataSourceTask.getAllTask();
    return result.map((e) => e.toEntity()).toList();
  }

  @override
  Future<String> insertTask(TaskRequestLocal task) async {
    try {
      final result =
          await localDataSourceTask.insertTask(TaskLocalModel.fromEntity(task));
      return result;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  @override
  Future<List<TaskRequestRemote>> getAllTaskRemote() async {
    final result = await remoteDataSourceTask.getAllTask();
    return result.map((e) => e.toEntity()).toList();
  }

 

  @override
  Future<void> deleteTaskCache() {
    return localDataSourceTask.deleteTaskCache();
  }

  @override
  Future<String> insertTaskCache(TaskRequestLocal task) {
    return localDataSourceTask.insertTaskCache(TaskLocalModel.fromEntity(task));
  }

  @override
  Future<List<TaskRequestLocal>> getAllTaskCache() async {
    final result = await localDataSourceTask.getAllTaskCache();
    return result.map((e) => e.toEntity()).toList();
  }

  @override
  Future<String> insertImageRemote(String pathImage) {
    return remoteDataSourceTask.insertImage(pathImage);
  }

  @override
  Future<String> insertTaskRemote(TaskRequestRemote taskRequest) {
    return remoteDataSourceTask.insertTask(TaskRemoteModel.fromEntity(taskRequest));
  }
}
