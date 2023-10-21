import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app/routes/app_pages.dart';
import 'di.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();

    await Supabase.initialize(
    url: 'https://pqgwxjlgapkbglecqqxm.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBxZ3d4amxnYXBrYmdsZWNxcXhtIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTc4Nzg2ODksImV4cCI6MjAxMzQ1NDY4OX0.0b6axq508t32g9_L4HyhEbZyXgQsPufjuAY9AqvBkBY',
  );

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
