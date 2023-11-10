import 'package:task_mobile/app/domain/entity/task_request_remote.dart';
import 'package:task_mobile/app/domain/entity/task_request_local.dart';

abstract class TaskRepository {
  Future<List<TaskRequestLocal>> getAllTask();
  Future<String> insertTask(TaskRequestLocal task);

  Future<List<TaskRequestRemote>> getAllTaskRemote();
  Future<String> insertTaskRemote(TaskRequestRemote taskRequest);
  Future<String> insertImageRemote(String pathImage);

  Future<String> insertTaskCache(TaskRequestLocal task);
  Future<void> deleteTaskCache();
  Future<List<TaskRequestLocal>> getAllTaskCache();
}
