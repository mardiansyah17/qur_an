import 'package:flutter/material.dart';
import 'package:qur_an/utils/app_colors.dart';
import 'package:table_calendar/table_calendar.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({
    super.key,
    this.onDaySelected,
    // this.selectedDate,
  });

  final void Function(DateTime, DateTime)? onDaySelected;

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime? selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    print(selectedDate);
    return TableCalendar(
      onDaySelected: (selectedDay, focusedDay) => {
        setState(() {
          selectedDate = selectedDay;
        }),
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
      selectedDayPredicate: (day) => isSameDay(day, selectedDate),
      focusedDay: selectedDate ?? DateTime.now(),
      calendarFormat: CalendarFormat.month,
      startingDayOfWeek: StartingDayOfWeek.monday,
      availableGestures: AvailableGestures.horizontalSwipe,
    );
  }
}
