import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:task_mobile/app/domain/entity/task_request_remote.dart';
import 'package:task_mobile/app/domain/entity/task_request_local.dart';
import 'package:task_mobile/app/routes/app_pages.dart';

class TaskItemCard extends StatelessWidget {
  final TaskRequestRemote? taskData;
  final TaskRequestLocal? taskDatas;

  TaskItemCard(this.taskData,this.taskDatas);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.DETAIL, arguments: taskData ?? taskDatas);
      },
      child: taskData != null ? Card(
        margin: const EdgeInsets.all(10),
        elevation: 10,
        shadowColor: Colors.grey,
        child: ListTile(
          contentPadding: const EdgeInsets.all(10),
          leading: CachedNetworkImage(
            imageUrl: taskData!.photo,
            imageBuilder: (context, imageProvider) => Container(
              width: 80.0,
              height: 80.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            placeholder: (context, url) =>
                Lottie.asset("assets/loading.json", height: 50, width: 50),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          title: Text(taskData!.meetingTittle),
          subtitle: Text(taskData!.meetingLocation),
          trailing: const Icon(Icons.keyboard_arrow_right_outlined),
        ),
      ) : Card(
              margin: const EdgeInsets.all(10),
              elevation: 10,
              shadowColor: Colors.grey,
              child: ListTile(
                contentPadding: const EdgeInsets.all(10),
                leading: taskDatas!.photo.contains("http") ? CachedNetworkImage(
                  imageUrl: taskDatas!.photo,
                  imageBuilder: (context, imageProvider) => Container(
                    width: 80.0,
                    height: 80.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => Lottie.asset(
                      "assets/loading.json",
                      height: 50,
                      width: 50),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ): ClipOval(
                    child: Image.file(
                          File(taskDatas!.photo),
                          width: 80.0,
                          height: 80.0,
                        ),
                ),
                title: Text(taskDatas!.meetingTittle),
                subtitle: Text(taskDatas!.meetingLocation),
                trailing: const Icon(Icons.keyboard_arrow_right_outlined),
              ),
            ),
    );
  }
}
