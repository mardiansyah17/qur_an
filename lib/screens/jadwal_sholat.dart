import 'package:flutter/material.dart';
import 'package:qur_an/widgets/scaffold_gradient.dart';

class JadwalSholat extends StatelessWidget {
  const JadwalSholat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldGradient(
        body: Container(
      child: Center(
        child: Text('Jadwal Sholat'),
      ),
    ));
  }
}
