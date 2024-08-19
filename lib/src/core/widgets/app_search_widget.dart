import 'package:flutter/material.dart';
import 'package:qur_an/src/core/theme/app_pallete.dart';

class AppSearchWidget extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final FocusNode? focusNode;
  final String title;
  const AppSearchWidget(
      {super.key, required this.title, this.onChanged, this.focusNode});

  static OutlineInputBorder outlineInputBorder(
          {Color color = AppPallete.second, double width = 1}) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: color, width: width),
      );

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focusNode,
      onChanged: onChanged,
      style: const TextStyle(
        color: AppPallete.primary,
        decorationThickness: 0,
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(10),
        hintText: "Cari Surah",
        prefixIcon: const Icon(Icons.search),
        border: outlineInputBorder(),
        enabledBorder: outlineInputBorder(),
        focusedBorder: outlineInputBorder(color: AppPallete.primary, width: 2),
      ),
    );
  }
}
