import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:task_mobile/app/domain/entity/task.dart';
import 'package:task_mobile/app/domain/usecase/task_usecase.dart';

class HomeController extends GetxController {

  RxList<Task> listTask = <Task>[].obs;
  List<Task> get taskList => listTask;

  RxList<Map<String,dynamic>> listTaskRemote = <Map<String,dynamic>>[].obs;
  List<Map<String, dynamic>> get taskListRemote => listTaskRemote;

  final TaskUseCase taskUseCase = GetIt.I.get<TaskUseCase>();

  FutureOr<void> getAllTask() async {
    final result = await taskUseCase.getAllTaskExecute();
    print(result); // Tambahkan ini
    listTask(result);
    listTask.refresh();
  }

  FutureOr<void> getAllTaskRemote() async {
    final result = await taskUseCase.getAllTaskRemoteExecute();
    print(result); // Tambahkan ini
    listTaskRemote(result);
    listTask.refresh();
  }

  @override
  void onInit() {
    getAllTask();
    getAllTaskRemote();
    print(taskList);
    super.onInit();
  }
}
