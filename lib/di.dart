import 'package:get_it/get_it.dart';
import 'package:task_mobile/app/data/datasource/helper/task_database_helper.dart';
import 'package:task_mobile/app/data/datasource/local/impl/local_data_source_task_impl.dart';
import 'package:task_mobile/app/data/datasource/local/local_data_source_task.dart';
import 'package:task_mobile/app/data/repository/task_repository_impl.dart';
import 'package:task_mobile/app/domain/repository/task_repository.dart';
import 'package:task_mobile/app/domain/usecase/task_usecase.dart';

final locator = GetIt.instance;

void init() {
  locator.registerLazySingleton(() => TaskUseCase(locator()));

  locator.registerLazySingleton<TaskRepository>(
      () => TaskRepositoryImpl(localDataSourceTask: locator()));

  locator.registerLazySingleton<LocalDataSourceTask>(
      () => LocalDataSourceTaskImpl(taskDatabaseHelper: locator()));

  locator.registerLazySingleton<TaskDatabaseHelper>(() => TaskDatabaseHelper());
}
