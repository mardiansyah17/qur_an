import 'package:flutter/material.dart';
import 'package:qur_an/widgets/container_gradient.dart';

class ScaffoldGradient extends StatelessWidget {
  const ScaffoldGradient({
    Key? key,
    this.title,
    required this.body,
  }) : super(key: key);

  final Widget body;
  final Widget? title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: title != null
          ? AppBar(
              iconTheme: const IconThemeData(color: Color(0xFF65D6FC)),
              title: title,
              backgroundColor: Colors.transparent,
            )
          : null,

      body: ContainerGradient(
        body: body,
      ),
    );
  }
}
