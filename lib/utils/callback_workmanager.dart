import 'package:intl/date_symbol_data_local.dart';
import 'package:localstorage/localstorage.dart';
import 'package:qur_an/utils/schedule_prayer.dart';
import 'package:workmanager/workmanager.dart';

void callbackWorkmanager() async {
  await initializeDateFormatting();
  await initLocalStorage();
  Workmanager().executeTask((task, inputData) async {
    switch (task) {
      case "getSchedule2":
        return await SchedulePrayer().getSchedule();
      default:
        return Future.value(true);
    }
  });
}
