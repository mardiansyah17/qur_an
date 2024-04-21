import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:localstorage/localstorage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qur_an/routes.dart';
import 'package:qur_an/utils/notification_helper.dart';
// import 'package:qur_an/screens/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationHelper.init();
  await Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await initLocalStorage();
  initializeDateFormatting().then((_) => runApp(const MyApp()));
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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: true,
          fontFamily: GoogleFonts.poppins().fontFamily,
          appBarTheme: AppBarTheme(
              color: Colors.transparent,
              titleTextStyle: GoogleFonts.poppins()
                  .copyWith(color: Colors.green, fontSize: 20)),
          textTheme: const TextTheme(
              bodyMedium: TextStyle(
            color: Colors.white,
          ))),
      initialRoute: '/',
      getPages: appRoutes(),
    );
  }
}
