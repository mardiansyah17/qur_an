import 'package:flutter/cupertino.dart';

class AppBarTitleText extends StatelessWidget {
  const AppBarTitleText({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        color: Color(0xFF65D6FC),
      ),
    );
  }
}
