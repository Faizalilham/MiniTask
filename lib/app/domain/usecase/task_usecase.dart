import 'package:task_mobile/app/domain/entity/task.dart';
import 'package:task_mobile/app/domain/repository/task_repository.dart';

class TaskUseCase {
  TaskRepository taskRepository;

  TaskUseCase(this.taskRepository);

  Future<List<Task>> getAllTaskExecute() => taskRepository.getAllTask();

  Future<String> insertTaskExecute(Task task) =>
      taskRepository.insertTask(task);
}