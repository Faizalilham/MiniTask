import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_mobile/app/modules/adds/controllers/adds_controller.dart';
import 'package:path/path.dart' as p;
import 'package:image/image.dart' as img;

void showCustomSnackbar(String tittle, String message, Color color,bool isConnection) {
  Get.snackbar(
    tittle,
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: color,
    colorText: Colors.black,
    borderRadius: 10,
    margin: const EdgeInsets.all(15),
    animationDuration: const Duration(seconds: 1),
    duration: isConnection ? const Duration(days: 1) : const Duration(seconds: 3),
    reverseAnimationCurve: Curves.easeInBack,
    isDismissible: true,
    dismissDirection: DismissDirection.horizontal,
    mainButton: TextButton(
      onPressed: () {
        if (Get.isSnackbarOpen) {
          Get.closeCurrentSnackbar();
        }
      },
      child: const Text(
        "Dismiss",
        style: TextStyle(color: Colors.black),
      ),
    ),
  );
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
            child: Center(child: Image.asset(image, height: 30, width: 30)),
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

void showCustomBottomSheet(BuildContext context, AddsController controller) {
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
            const Text(
              "Choose image from :",
              textAlign: TextAlign.left,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
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


String fileUploadName(String filePath) {
  String extension = filePath.split('.').last;
  String basename = p.basenameWithoutExtension(filePath);
  String newFileName =
      '$basename-${DateTime.now().millisecondsSinceEpoch}.$extension';
  return newFileName;
}

Future<List<int>> compileToBytes(File image) async {
  final bytes = await image.readAsBytes();
  return await compressImage(bytes);
}

Future<String> fileToBase64(File file) async {
  List<int> fileBytes = await file.readAsBytes();
  String base64String = base64Encode(fileBytes);
  return base64String;
}

Future<List<int>> compressImage(List<int> bytes) async {
  int imageLength = bytes.length;
  if (imageLength < 1000000) return bytes;

  final img.Image image = img.decodeImage(bytes)!;
  int compressQuality = 100;
  int length = imageLength;
  List<int> newByte = [];

  do {
    ///
    compressQuality -= 10;

    newByte = img.encodeJpg(
      image,
      quality: compressQuality,
    );

    length = newByte.length;
  } while (length > 1000000);

  return newByte;
}
