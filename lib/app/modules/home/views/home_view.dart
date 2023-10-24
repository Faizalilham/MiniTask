import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

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
          return controller.listTaskRemote.isEmpty
              ? Center(
                  child: Lottie.asset(
                                        "assets/loading.json",
                                        height: 80,
                                        width: 80),
                )
              : ListView.builder(
                  itemCount: controller.listTaskRemote.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Get.toNamed(Routes.DETAIL,
                            arguments: controller.listTaskRemote[index]);
                      },
                      child: Card(
                        margin:  const EdgeInsets.all(10),
                        elevation: 10,
                        shadowColor: Colors.grey,
                          child: ListTile(
                            contentPadding: const  EdgeInsets.all(10),
                                leading:CachedNetworkImage(
                                    imageUrl: controller.listTaskRemote[index]['photo'],
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      width: 80.0,
                                      height: 80.0,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                    placeholder: (context, url) => Lottie.asset(
                                        "assets/loading.json",
                                        height: 50,
                                        width: 50),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                ),
                                title: Text(
                                    controller.listTaskRemote[index]['name']),
                                subtitle: Text(controller.listTaskRemote[index]
                                    ['description']),
                                trailing: const Icon(
                                    Icons.keyboard_arrow_right_outlined),
                              )),
                    );
                  },
                );
        }));
  }
}
