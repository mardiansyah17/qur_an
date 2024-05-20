import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:localstorage/localstorage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qur_an/routes.dart';
import 'package:qur_an/utils/contants.dart';
import 'package:qur_an/utils/notification_helper.dart';
// import 'package:qur_an/utils/callback_workmanager.dart';
import 'package:qur_an/utils/schedule_prayer.dart';
import 'package:workmanager/workmanager.dart';

void callbackWorkmanager() async {
  Workmanager().executeTask((task, inputData) async {
    await initializeDateFormatting();
    await initLocalStorage();
    print('task $task');
    switch (task) {
      case "getSchedule":
        await SchedulePrayer().getSchedule();
        break;
      case "setSchedule":
        await SchedulePrayer().schedulePrayerTimes();
        break;

      default:
        break;
    }
    return Future.value(true);
  });
}

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
// Ganti dengan zona waktu yang sesuai
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await initLocalStorage();

  Workmanager()
      .initialize(callbackWorkmanager, isInDebugMode: Constants.isDebug);

  await Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await NotificationHelper.initializeLocalNotifications();
  await NotificationHelper.startListeningNotificationEvents();
  FlutterNativeSplash.remove();

  initializeDateFormatting().then((_) => runApp(const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    Workmanager().registerPeriodicTask(
      'getSchedule',
      'getSchedule',
      frequency: const Duration(minutes: 15),
    );

    Workmanager().registerPeriodicTask(
      'setSchedule',
      'setSchedule',
      frequency: const Duration(hours: 1),
    );

    SchedulePrayer().schedulePrayerTimes();
  }

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
