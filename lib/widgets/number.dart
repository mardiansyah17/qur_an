import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

class Number extends StatelessWidget {
  const Number({
    super.key,
    required this.nomor,
  });

  final int nomor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          'assets/svg/bingkai-nomor.svg',
          colorFilter: const ColorFilter.mode(
            Color(0xFF65D6FC),
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
