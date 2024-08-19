import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qur_an/src/core/theme/app_pallete.dart';

class NumberWidget extends StatelessWidget {
  const NumberWidget({
    super.key,
    required this.nomor,
  });

  final String nomor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          'assets/svg/number.svg',
          colorFilter: const ColorFilter.mode(
            AppPallete.primary,
            BlendMode.srcIn,
          ),
        ),
        Positioned.fill(
          child: Center(
            child: Text(nomor.toString()),
          ),
        ),
      ],
    );
  }
}
