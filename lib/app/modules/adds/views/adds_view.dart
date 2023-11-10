import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:task_mobile/app/domain/entity/task_request_remote.dart';
import 'package:task_mobile/app/domain/entity/task_request_local.dart';
import 'package:task_mobile/app/utils/utils.dart';

import '../controllers/adds_controller.dart';

class AddsView extends GetView<AddsController> {
  const AddsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.handleLocationPermission(context);
    controller.getCurrentPosition(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text("Add Task"),
          actions: [
            IconButton(
              onPressed: () async {
                if (controller.formKey.currentState!.validate()) {
                  FocusManager.instance.primaryFocus?.unfocus();
                  if (controller.pathImage.value.isNotEmpty &&
                      controller.latitude.isNotEmpty &&
                      controller.longitude.isNotEmpty) {
                    controller.insertTask(TaskRequestRemote(
                        id: 0,
                        meetingTittle: controller.tittle.text.toString(),
                        meetingLocation: controller.location.text.toString(),
                        latitude: controller.latitude.value,
                        longitude: controller.longitude.value,
                        photo: controller.pathImage.value,
                        date: controller.date.text.toString(),
                        meetingNotes: controller.notes.text.toString(),
                        meetingParticipants: controller.participants.text.toString(),
                        address: controller.currentAddress.value));
                  }
                } else {
                  showCustomSnackbar("Warning", "All data must be filled in",
                      Colors.yellow, false);
                }
              },
              icon: const Icon(Icons.upload),
              tooltip: "Unggah",
            ),
          ],
        ),
        body: Stack(
          children: [
            Obx(() {
              return Visibility(
                  visible: controller.isLoading.value,
                  child: Container(
                    color: Colors.black.withOpacity(0.8),
                    child: Center(
                      child: Lottie.asset("assets/loading.json",
                          height: 80, width: 80),
                    ),
                  ));
            }),
            Container(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Obx(() {
                      return Form(
                          key: controller.formKey,
                          child: Column(
                            children: [
                              InkWell(
                                onTap: controller.isLoading.value
                                    ? null
                                    : () {
                                        showCustomBottomSheet(
                                            context, controller);
                                      },
                                child: Container(
                                  width: double.infinity,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.blue, // Warna garis tepi
                                      width: 2.0, // Lebar garis tepi
                                    ),
                                  ),
                                  child: Center(
                                    child:
                                        controller.selectedImage.value != null
                                            ? Image.file(
                                                controller.selectedImage.value!)
                                            : Image.asset("assets/image.png",
                                                height: 60, width: 60),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 50),
                              TextFormField(
                                enabled: !controller.isLoading.value,
                                controller: controller.tittle,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Kolom tittle tidak boleh kosong';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    hintText: "tittle",
                                    border: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    suffixIcon: InkWell(
                                        onTap: () {
                                          controller.tittle.clear();
                                        },
                                        child: const Icon(Icons.clear))),
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                enabled: !controller.isLoading.value,
                                controller: controller.location,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Kolom location tidak boleh kosong';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    border: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    hintText: "location",
                                    suffixIcon: InkWell(
                                        onTap: () {
                                          controller.location.clear();
                                        },
                                        child: const Icon(Icons.clear))),
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                maxLines: 8,
                                enabled: !controller.isLoading.value,
                                controller: controller.notes,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Kolom notes tidak boleh kosong';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                    hintText: "notes",
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    ),
                              ),
                              const SizedBox(height:20),
                              TextFormField(
                                maxLines: 8,
                                enabled: !controller.isLoading.value,
                                controller: controller.participants,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Kolom participants tidak boleh kosong';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                    hintText: "participants",
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    ),
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                enabled: !controller.isLoading.value,
                                controller: controller.date,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Kolom name tidak boleh kosong';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    hintText: "Date",
                                    border: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    suffixIcon: InkWell(
                                        onTap: () {},
                                        child: InkWell(
                                          onTap: () async {
                                            final DateTime? dateTime =
                                                await showDatePicker(
                                                    context: context,
                                                    initialDate: controller
                                                        .selectedDate.value,
                                                    firstDate: DateTime(2000),
                                                    lastDate: DateTime(3000));
                                            if (dateTime != null) {
                                              controller.selectedDate.value =
                                                  dateTime;
                                              controller.date.text = controller
                                                  .formatDate(dateTime);
                                            }
                                          },
                                          child:
                                              const Icon(Icons.calendar_today),
                                        ))),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ));
                    }))),
          ],
        ));
  }
}
