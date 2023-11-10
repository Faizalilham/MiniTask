import 'package:get/get.dart';
import 'package:task_mobile/app/domain/entity/task_request_local.dart';
import 'package:task_mobile/app/domain/entity/task_request_remote.dart';

class DetailController extends GetxController {
  final args = Get.arguments;
  TaskRequestRemote? taskObject;
  TaskRequestLocal? taskMap;

  @override
  void onInit() {
    super.onInit();

    if (args is TaskRequestRemote) {
      taskObject = args as TaskRequestRemote;
    } else if (args is TaskRequestLocal) {
      taskMap = args as TaskRequestLocal;
    }
  }
}
