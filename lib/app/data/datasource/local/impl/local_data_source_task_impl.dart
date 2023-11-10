import 'dart:async';

import 'package:task_mobile/app/data/datasource/helper/task_database_helper.dart';
import 'package:task_mobile/app/data/datasource/local/local_data_source_task.dart';
import 'package:task_mobile/app/data/models/local/task_local_model.dart';
import 'package:task_mobile/app/utils/exception.dart';

class LocalDataSourceTaskImpl extends LocalDataSourceTask {
  final TaskDatabaseHelper taskDatabaseHelper;

  LocalDataSourceTaskImpl({required this.taskDatabaseHelper});

  @override
  FutureOr<String> insertTask(TaskLocalModel entity) async {
    try {
      await taskDatabaseHelper.insertTask(entity);
      return 'Adding data successfully';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  FutureOr<List<TaskLocalModel>> getAllTask() async {
    try {
      final result = await taskDatabaseHelper.getTasks();
      print("hoho $result");
      return result.map((e) => TaskLocalModel.fromMap(e)).toList();
    } catch (e) {
      print(e.toString());
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<void> deleteTaskCache() {
    return taskDatabaseHelper.deleteAllTasksCache();
  }

  @override
  Future<String> insertTaskCache(TaskLocalModel task) async {
    try {
      await taskDatabaseHelper.insertTaskCache(task);
      return "Add data successfully";
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<List<TaskLocalModel>> getAllTaskCache() async {
    try {
      final result = await taskDatabaseHelper.getTasksCache();
      return result.map((e) => TaskLocalModel.fromMap(e)).toList();
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
