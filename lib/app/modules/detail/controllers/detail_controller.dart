import 'package:get/get.dart';
import 'package:task_mobile/app/domain/entity/task.dart';

class DetailController extends GetxController {
  final Task task = Get.arguments as Task;

  @override
  void onInit() {
    super.onInit();
  }
}
