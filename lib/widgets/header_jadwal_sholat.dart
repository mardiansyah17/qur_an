import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';
import 'package:qur_an/screens/select_city.dart';
import 'package:qur_an/utils/app_colors.dart';
import 'package:table_calendar/table_calendar.dart';

class HeaderJadwalSholat extends StatefulWidget {
  const HeaderJadwalSholat({super.key, required this.fetchJadwal});

  final dynamic fetchJadwal;
  @override
  State<HeaderJadwalSholat> createState() => _HeaderJadwalSholatState();
}

class _HeaderJadwalSholatState extends State<HeaderJadwalSholat> {
  String? selectedDateSchedule = localStorage.getItem('selectedDateSchedule');

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => {
            Get.to(const SelectCity(),
                transition: Transition.downToUp,
                duration: Duration(milliseconds: 450))
          },
          child: Container(
            // margin: EdgeInsets.only(bottom: 120),
            child: Text(
                localStorage.getItem('city_name') == null
                    ? "Pilih Kota"
                    : localStorage.getItem('city_name')!.capitalize!,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                )),
          ),
        ),
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () => {
                  // onTapDate(context)
                },
                child: Text(
                  DateFormat('dd MMMM y', 'id-ID').format(DateTime.parse(
                      selectedDateSchedule == null
                          ? DateTime.now().toString()
                          : selectedDateSchedule!)),
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      color: AppColors.primaryColor),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Future<dynamic> onTapDate(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) => Dialog(
              backgroundColor: Colors.transparent,
              insetAnimationCurve: Curves.bounceInOut,
              insetAnimationDuration: Duration(milliseconds: 8000),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromARGB(255, 69, 89, 217),
                      ),
                      child: TableCalendar(
                        onDaySelected: (selectedDay, focusedDay) => {
                          setState(() {
                            selectedDateSchedule = selectedDay.toString();
                          }),
                          // localStorage.setItem(
                          //     'selectedDateSchedule',
                          //     selectedDay.toString()),
                          Navigator.pop(context),
                          widget.fetchJadwal()
                        },
                        headerStyle: const HeaderStyle(
                          formatButtonVisible: false,
                          titleCentered: true,
                          titleTextStyle: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                          leftChevronIcon: Icon(
                            Icons.arrow_back_ios,
                            color: AppColors.primaryColor,
                            size: 20,
                          ),
                          rightChevronIcon: Icon(
                            Icons.arrow_forward_ios,
                            color: AppColors.primaryColor,
                            size: 20,
                          ),
                        ),
                        daysOfWeekStyle: const DaysOfWeekStyle(
                          weekdayStyle: TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w700,
                          ),
                          weekendStyle: TextStyle(
                            color: Colors.white54,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        calendarStyle: CalendarStyle(
                          weekendTextStyle: TextStyle(color: Colors.white54),
                          todayDecoration: BoxDecoration(
                            color: AppColors.primaryColor.withOpacity(0.5),
                            shape: BoxShape.circle,
                          ),
                          todayTextStyle: const TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w700,
                          ),
                          selectedDecoration: const BoxDecoration(
                            color: AppColors.primaryColor,
                            shape: BoxShape.circle,
                          ),
                          selectedTextStyle: TextStyle(
                            color: Color.fromARGB(255, 41, 101, 122),
                          ),
                        ),
                        locale: "id_ID",
                        firstDay: DateTime.utc(2010, 10, 16),
                        lastDay: DateTime.utc(2030, 3, 14),
                        selectedDayPredicate: (day) => isSameDay(
                            day,
                            DateTime.parse(selectedDateSchedule == null
                                ? DateTime.now().toString()
                                : selectedDateSchedule!)),
                        focusedDay: DateTime.parse(selectedDateSchedule == null
                            ? DateTime.now().toString()
                            : selectedDateSchedule!),
                        calendarFormat: CalendarFormat.month,
                        startingDayOfWeek: StartingDayOfWeek.monday,
                        availableGestures: AvailableGestures.horizontalSwipe,
                      )),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          );
        });
  }
}
