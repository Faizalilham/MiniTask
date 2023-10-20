import 'package:task_mobile/app/domain/entity/task.dart';

abstract class TaskRepository {

  Future<List<Task>> getAllTask();
  Future<String> insertTask(Task task);

}
