import 'package:flutter/material.dart';
import 'package:qur_an/src/core/theme/app_pallete.dart';

class AppButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44.0,
      decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppPallete.primary, AppPallete.second],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(5)),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent),
        child: Text(
          text,
          style: const TextStyle(color: AppPallete.white),
        ),
      ),
    );
  }
}
