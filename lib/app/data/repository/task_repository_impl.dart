import 'package:task_mobile/app/data/datasource/local/local_data_source_task.dart';
import 'package:task_mobile/app/data/models/task_model.dart';
import 'package:task_mobile/app/domain/entity/task.dart';
import 'package:task_mobile/app/domain/repository/task_repository.dart';
import 'package:task_mobile/app/utils/exception.dart';

class TaskRepositoryImpl implements TaskRepository {
  final LocalDataSourceTask localDataSourceTask;

  const TaskRepositoryImpl({
    required this.localDataSourceTask,
  });

  @override
  Future<List<Task>> getAllTask() async {
    final result = await localDataSourceTask.getAllTask();
    return result.map((e) => e.toEntity()).toList();
  }

  @override
  Future<String> insertTask(Task task) async {
    try {
      final result =
          await localDataSourceTask.insertTask(TaskModel.fromEntity(task));
      return result;
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
