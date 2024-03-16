import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qur_an/screens/home.dart';
import 'package:qur_an/widgets/scaffold_gradient.dart';
// import 'package:qur_an/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        // title: "mantap",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            useMaterial3: true,
            fontFamily: GoogleFonts.poppins().fontFamily,
            appBarTheme: AppBarTheme(
                color: Colors.transparent,
                titleTextStyle: GoogleFonts.poppins()
                    .copyWith(color: Colors.white, fontSize: 20)),
            textTheme: const TextTheme(
                bodyMedium: TextStyle(
              color: Colors.white,
            ))),
        home: const ScaffoldGradient(
          body: Home(),
        ));
  }
}
