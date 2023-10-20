import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:task_mobile/app/components/card_task.dart';
import 'package:task_mobile/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('HomeView'),
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.task),
            onPressed: () {
              Get.toNamed(Routes.ADDS);
            }),
        body: Obx(() {
          return controller.listTask.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: controller.listTask.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Get.toNamed(Routes.DETAIL, arguments: controller.listTask[index]);
                      },
                      child: Card(
                          child: Container(
                              padding: const EdgeInsets.all(10),
                              child: ListTile(
                                leading: ClipOval(
                                  child: Image.file(
                                    File(controller.listTask[index].photo),
                                    width:
                                        50, 
                                    height:
                                        50,
                                    fit: BoxFit
                                        .cover,
                                  ),
                                ),
                                title: Text(controller.listTask[index].name),
                                subtitle: Text(controller.listTask[index].description),
                                trailing: const Icon(Icons.keyboard_arrow_right_outlined),
                              ))),
                    );
                    
                  },
                );
        }));
  }
}
