import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:task_mobile/app/domain/entity/task.dart';

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
              onPressed: () {
                if (controller.formKey.currentState!.validate()) {
                  FocusManager.instance.primaryFocus?.unfocus();
                  if (controller.pathImage.value.isNotEmpty &&
                      controller.latitude.isNotEmpty &&
                      controller.longitude.isNotEmpty) {
                    controller.insertTask(Task(
                        name: controller.name.text.toString(),
                        description: controller.description.text.toString(),
                        latitude: controller.latitude.value,
                        longitude: controller.longitude.value,
                        photo: controller.pathImage.value,
                        date: controller.date.text.toString(),
                        quantity:
                            int.parse(controller.quantity.text.toString())));
                  }
                } else {
                  Get.snackbar("Warning", "All data must be filled in",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Color.fromARGB(255, 247, 198, 40),
                      colorText: Colors.black,
                      borderRadius: 10,
                      margin: const EdgeInsets.all(15),
                      animationDuration: const Duration(seconds: 1),
                      duration: const Duration(seconds: 2),
                      reverseAnimationCurve:
                          Curves.easeInBack, // Animasi keluar
                      isDismissible:
                          true, // Snackbar dapat ditutup dengan menggeser
                      dismissDirection: DismissDirection
                          .horizontal, // Arah geser untuk menutup Snackbar
                      mainButton: TextButton(
                        onPressed: () {
                          Get.back(); // Tombol aksi pada Snackbar
                        },
                        child: const Text(
                          "Dismiss",
                          style: TextStyle(color: Colors.black),
                        ),
                      ));
                }
              },
              icon: const Icon(Icons.upload),
              tooltip: "Unggah",
            ),
          ],
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    Obx(() {
                      return InkWell(
                        onTap: (){
                            _showBottomSheet(context, controller);
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
                            
                              child: controller.selectedImage.value != null
                                  ? Image.file(controller.selectedImage.value!)
                                  : Image.asset("assets/image.png",height:60,width:60),
                            ),
                          ),
                      );
                    }),
                    const SizedBox(height: 50),
                    TextFormField(
                      controller: controller.name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Kolom name tidak boleh kosong';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: "Name",
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          suffixIcon: InkWell(
                              onTap: () {
                                controller.name.clear();
                              },
                              child: const Icon(Icons.clear))),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: controller.description,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Kolom name tidak boleh kosong';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          hintText: "Description",
                          suffixIcon: InkWell(
                              onTap: () {
                                controller.description.clear();
                              },
                              child: const Icon(Icons.clear))),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: controller.quantity,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Kolom name tidak boleh kosong';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: "Quantity",
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          suffixIcon: InkWell(
                              onTap: () {
                                controller.quantity.clear();
                              },
                              child: const Icon(Icons.clear))),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
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
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          suffixIcon: InkWell(
                              onTap: () {},
                              child: InkWell(
                                onTap: () async {
                                  final DateTime? dateTime =
                                      await showDatePicker(
                                          context: context,
                                          initialDate:
                                              controller.selectedDate.value,
                                          firstDate: DateTime(2000),
                                          lastDate: DateTime(3000));
                                  if (dateTime != null) {
                                    controller.selectedDate.value = dateTime;
                                    controller.date.text =
                                        controller.formatDate(dateTime);
                                  }
                                },
                                child: const Icon(Icons.calendar_today),
                              ))),
                    ),
                    const SizedBox(height: 20),
                  ],
                )),
          ),
        ));
  }
}

Widget _buildOptionCard(String image, String label, Function() onPressed) {
  return Column(
    children: [
      GestureDetector(
        onTap: onPressed,
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            width: 60,
            height: 60,
            child: Center(
              child: Image.asset(image, height: 30, width: 30)
            ),
          ),
        ),
      ),
      const SizedBox(height: 8),
      Text(
        label,
        style: const TextStyle(fontSize: 16),
      ),
    ],
  );
}

void _showBottomSheet(BuildContext context, AddsController controller) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (BuildContext context) {
      return Container(
        height: 180,
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Choose image from :",textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold),),
            const SizedBox(height: 15),
            Row(
              children: <Widget>[
                _buildOptionCard("assets/ic_gallery.png", 'Gallery', () {
                  Navigator.pop(context);
                  controller.pickImageFromGallery();
                }),
                const SizedBox(width: 16),
                _buildOptionCard("assets/ic_cameras.png", 'Camera', () {
                  Navigator.pop(context);
                  controller.pickImageFromCamera();
                }),
              ],
            )
          ],
        ),
      );
    },
  );
}
