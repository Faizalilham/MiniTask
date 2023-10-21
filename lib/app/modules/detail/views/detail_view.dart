import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controllers/detail_controller.dart';

class DetailView extends GetView<DetailController> {
  DetailView({Key? key}) : super(key: key);

  GoogleMapController? _gmapsController;
  @override
  Widget build(BuildContext context) {
    Get.put(DetailController());
    return Scaffold(
        appBar: AppBar(
          title: const Text('DetailView'),
          centerTitle: true,
        ),
        body: Container(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Container(
                  height: 1000, // Atur tinggi sesuai kebutuhan Anda
                  child: Column(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          child: Row(
                            children: [
                                Expanded(child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      10.0), // Ubah angka sesuai keinginan Anda
                                  child: Image.file(
                                    File(controller.task['photo']),
                                    height: 300,
                                    width: 200,
                                    fit: BoxFit
                                        .cover, // Sesuaikan dengan kebutuhan Anda
                                  ),
                                ),
                              ),
                                Expanded(child: Container(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                  crossAxisAlignment: CrossAxisAlignment
                                      .start, // Ratakan teks ke kiri
                                  children: [
                                    const SizedBox(height: 10),
                                    const Text(
                                      "Name",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      controller.task['name'],
                                      textAlign: TextAlign
                                          .left, // Ratakan teks ke kiri
                                    ),
                                    const SizedBox(height: 10),
                                    const Text(
                                      "Description",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      controller.task['description'],
                                      textAlign: TextAlign
                                          .left, // Ratakan teks ke kiri
                                    ),
                                    const SizedBox(height: 10),
                                    const Text(
                                      "Date ",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      controller.task['date'],
                                      textAlign: TextAlign
                                          .left, // Ratakan teks ke kiri
                                    ),
                                    const SizedBox(height: 5),
                                    const Text(
                                      "Address",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      controller.task['address'],
                                      textAlign: TextAlign
                                          .left, // Ratakan teks ke kiri
                                    ),
                                  ],
                                ),
                                )

                              )
                            ],
                          ),
                          // Widget untuk setengah pertama di sini
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                              const Text(
                                "Detail Address (Location)",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            Container(
                                width: double.infinity,
                                height: 500,
                                child: GoogleMap(
                                  onMapCreated:
                                      (GoogleMapController controller) {
                                    _gmapsController = controller;
                                  },
                                  initialCameraPosition: CameraPosition(
                                    target: LatLng(
                                        double.parse(controller.task['latitude']),
                                        double.parse(
                                            controller.task['longitude'])),
                                    zoom: 15,
                                  ),
                                  markers: {
                                    Marker(
                                        markerId: const MarkerId("marker1"),
                                        position: LatLng(
                                            double.parse(
                                                controller.task['latitude']),
                                            double.parse(
                                                controller.task['longitude'])),
                                        draggable: true,
                                        icon: BitmapDescriptor.defaultMarker),
                                  },
                                  zoomControlsEnabled:
                                      true, // Aktifkan kontrol zoom
                                  myLocationEnabled:
                                      true, // Aktifkan tampilan lokasi pengguna
                                  myLocationButtonEnabled: true,
                                  gestureRecognizers: <Factory<
                                      OneSequenceGestureRecognizer>>{
                                    Factory<OneSequenceGestureRecognizer>(
                                      () => EagerGestureRecognizer(),
                                    ),
                                  },
                                  onCameraMove: (CameraPosition position) {
                                    // Kembalikan true untuk mengaktifkan interaksi dengan peta
                                    
                                  },
                                ),
                              )
                          ],
                        )
                      ),
                    ],
                  ),
                ))));
  }
}
