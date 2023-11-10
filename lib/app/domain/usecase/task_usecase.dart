import 'package:task_mobile/app/domain/entity/task_request_remote.dart';
import 'package:task_mobile/app/domain/entity/task_request_local.dart';
import 'package:task_mobile/app/domain/repository/task_repository.dart';

class TaskUseCase {
  TaskRepository taskRepository;

  TaskUseCase(this.taskRepository);

  Future<List<TaskRequestLocal>> getAllTaskExecute() => taskRepository.getAllTask();

  Future<String> insertTaskExecute(TaskRequestLocal task) =>
      taskRepository.insertTask(task);

  Future<List<TaskRequestRemote>> getAllTaskRemoteExecute() =>
      taskRepository.getAllTaskRemote();

  Future<String> insertTaskRemoteExecute(TaskRequestRemote taskRequest) =>
      taskRepository.insertTaskRemote(taskRequest);

  Future<String> insertTaskCacheExecute(TaskRequestLocal task) =>
      taskRepository.insertTaskCache(task);

  Future<void> deleteTaskCacheExecute() => taskRepository.deleteTaskCache();

  Future<List<TaskRequestLocal>> getAllTaskCacheExecute() =>
      taskRepository.getAllTaskCache();

  Future<String> insertImageRemoteExecute(String pathImage) =>
      taskRepository.insertImageRemote(pathImage);
}
