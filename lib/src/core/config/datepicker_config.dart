import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:qur_an/src/core/theme/app_pallete.dart';

final datePickerConfig = CalendarDatePicker2WithActionButtonsConfig(
  selectedDayHighlightColor: AppPallete.primary,
  yearBuilder: (
      {decoration,
      isCurrentYear,
      isDisabled,
      isSelected,
      textStyle,
      required year}) {
    return Center(
      child: Container(
        decoration: decoration,
        height: 36,
        width: 72,
        child: Center(
          child: Semantics(
            selected: isSelected,
            button: true,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  year.toString(),
                  style: textStyle,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  },
);
