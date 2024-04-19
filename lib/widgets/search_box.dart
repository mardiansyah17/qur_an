import 'package:flutter/material.dart';
import 'package:qur_an/utils/app_colors.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({
    super.key,
    required this.changeHandler,
    required this.hintText,
  });

  final Function(String) changeHandler;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: changeHandler,
      style: const TextStyle(
          color: Colors.white,
          decoration: TextDecoration.none,
          decorationThickness: 0),
      cursorColor: AppColors.primaryColor,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(
          Icons.search,
          color: AppColors.primaryColor,
        ),
        hintStyle: TextStyle(color: Colors.grey),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.secondaryColor),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor),
        ),
      ),
    );
  }
}
