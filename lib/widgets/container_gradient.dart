import 'package:flutter/material.dart';

class ContainerGradient extends StatelessWidget {
  const ContainerGradient({super.key, required this.body});
  final Widget body;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 51, 67, 190),
            Color.fromARGB(255, 24, 53, 116)
          ],
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          SafeArea(
            child: body,
            // child: SelectCity(),
          ),
        ],
      ),
    );
  }
}
