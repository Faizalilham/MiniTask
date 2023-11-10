import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:task_mobile/app/domain/entity/task_request_remote.dart';
import 'package:task_mobile/app/domain/entity/task_request_local.dart';
import 'package:task_mobile/app/domain/usecase/task_usecase.dart';
import 'package:task_mobile/app/utils/utils.dart';

class HomeController extends GetxController {
  RxList<TaskRequestLocal> listTask = <TaskRequestLocal>[].obs;
  List<TaskRequestLocal> get taskList => listTask;

  RxList<TaskRequestRemote> listTaskRemote = <TaskRequestRemote>[].obs;
  List<TaskRequestRemote> get taskListRemote => listTaskRemote;

  late StreamSubscription<ConnectivityResult> subscription;

  final TaskUseCase taskUseCase = GetIt.I.get<TaskUseCase>();

  Rx<bool> isConnected = true.obs;
  bool autoPostExecuted = false;

  int count = 0;

  FutureOr<void> getAllTask() async {
    final resultTask = await taskUseCase.getAllTaskExecute();
    final resultCache = await taskUseCase.getAllTaskCacheExecute();
    final result = [...resultTask, ...resultCache];
    listTask(result);
    print(result);
    listTask.refresh();
  }

  FutureOr<void> insertTask(TaskRequestLocal task) async {
    final result = await taskUseCase.insertTaskExecute(task);
    print(result);
  }

  void updateConnectionStatus(ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.none) {
      showCustomSnackbar("Warning ", "No Connection", Colors.yellow, true);

      isConnected(false);
      Get.delete();
      getAllTask();
    } else {
      isConnected(true);
      Get.delete();
      autoPost();
      getAllTaskRemote();

      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }
    }
  }

  _loadData() async {
    await Get.find<HomeController>().getAllTaskRemote();
    autoPost();
  }

  Future<void> autoPost() async {
    if (isConnected.value && !autoPostExecuted) {
      autoPostExecuted = true;

      String post = "";
      final result = await taskUseCase.getAllTaskCacheExecute();
      print("${result.length} haihai");
      if (result.isNotEmpty) {
        for (int i = 0; i < result.length; i++) {
          print("perulangan ke $i");
          final element = result[i];
          post = await taskUseCase.insertTaskRemoteExecute(TaskRequestRemote(
              id: element.id,
              meetingTittle: element.meetingTittle,
              meetingLocation: element.meetingLocation,
              meetingNotes: element.meetingNotes,
              meetingParticipants: element.meetingParticipants,
              latitude: element.latitude,
              longitude: element.longitude,
              photo: element.photo,
              date: element.date,
              address: element.address));
        }
      }

      if (post != "") showCustomSnackbar("Success", post, Colors.green, false);
      await taskUseCase.deleteTaskCacheExecute();
      await getAllTaskRemote();
    }
  }

  Future<void> loadData() async {
    if (isConnected.value) {
      await getAllTaskRemote();
    } else {
      await getAllTask();
    }
  }

  FutureOr<void> getAllTaskRemote() async {
    final result = await taskUseCase.getAllTaskRemoteExecute();

    listTaskRemote(result);
    listTaskRemote.refresh();
    for (TaskRequestRemote taskData in result) {
      final task = TaskRequestLocal(
          id: taskData.id,
          meetingTittle: taskData.meetingTittle,
          meetingLocation: taskData.meetingLocation,
          meetingNotes: taskData.meetingNotes,
          meetingParticipants: taskData.meetingParticipants,
          latitude: taskData.latitude,
          longitude: taskData.longitude,
          photo: taskData.photo,
          date: taskData.date,
          address: taskData.address);
      await insertTask(task);
    }
  }

  @override
  void onInit() async {
    subscription =
        Connectivity().onConnectivityChanged.listen(updateConnectionStatus);
    updateConnectionStatus(await Connectivity().checkConnectivity());

    if (isConnected.value) {
      count++;
      Get.snackbar("$count", "message",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          colorText: Colors.black,
          borderRadius: 10);
    }
    super.onInit();
  }
}
