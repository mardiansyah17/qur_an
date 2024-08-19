import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qur_an/src/core/theme/app_pallete.dart';

class ActionAyatWidget extends StatelessWidget {
  final IconData? icon;
  final String? svg;
  final void Function()? onTap;
  const ActionAyatWidget({super.key, this.icon, this.svg, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: icon != null
          ? Icon(
              icon,
              color: AppPallete.primary,
              size: 35,
            )
          : SvgPicture.asset(svg!),
    );
  }
}
