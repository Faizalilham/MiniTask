import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:task_mobile/app/domain/entity/task.dart';
import 'package:task_mobile/app/domain/usecase/task_usecase.dart';

class HomeController extends GetxController {

  RxList<Task> listTask = <Task>[].obs;
   List<Task> get taskList => listTask;

  final TaskUseCase taskUseCase = GetIt.I.get<TaskUseCase>();

  FutureOr<void> getAllTask() async {
    final result = await taskUseCase.getAllTaskExecute();
    print(result); // Tambahkan ini
    listTask(result);
    listTask.refresh();
  }

  @override
  void onInit() {
    getAllTask();
    print(taskList);
    super.onInit();
  }
}
