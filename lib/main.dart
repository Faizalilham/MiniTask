import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app/routes/app_pages.dart';
import 'di.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();


  runApp(
    
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "MyTask",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: ThemeData(
        textTheme:  GoogleFonts.poppinsTextTheme().apply(bodyColor: Colors.black),
        // Menggunakan 'Poppins' sebagai jenis huruf utama
      ),
    ),
  );
}
