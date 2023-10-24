import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:task_mobile/app/domain/entity/task.dart';
import 'package:task_mobile/app/domain/usecase/task_usecase.dart';
import 'package:task_mobile/app/utils/utils.dart';

class HomeController extends GetxController {
  RxList<Task> listTask = <Task>[].obs;
  List<Task> get taskList => listTask;

  RxList<Map<String, dynamic>> listTaskRemote = <Map<String, dynamic>>[].obs;
  List<Map<String, dynamic>> get taskListRemote => listTaskRemote;

  late StreamSubscription<ConnectivityResult> subscription;

  final TaskUseCase taskUseCase = GetIt.I.get<TaskUseCase>();

  FutureOr<void> getAllTask() async {
    final result = await taskUseCase.getAllTaskExecute();
    print(result); // Tambahkan ini
    listTask(result);
    listTask.refresh();
  }

  void updateConnectionStatus(ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.none) {
      showCustomSnackbar("Warning ", "No Connection", Colors.yellow, true);
    } else {
      getAllTask();
      getAllTaskRemote();
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }
    }
  }

  FutureOr<void> getAllTaskRemote() async {
    final result = await taskUseCase.getAllTaskRemoteExecute();
    print(result); // Tambahkan ini
    listTaskRemote(result);
    listTask.refresh();
  }

  @override
  void onInit() {
    subscription =
        Connectivity().onConnectivityChanged.listen(updateConnectionStatus);
    
    print(taskList);
    super.onInit();
  }
}
