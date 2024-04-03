import 'package:flutter/material.dart';
import 'package:qur_an/widgets/scaffold_gradient.dart';

class SelectCity extends StatefulWidget {
  const SelectCity({Key? key}) : super(key: key);

  @override
  _SelectCityState createState() => _SelectCityState();
}

class _SelectCityState extends State<SelectCity> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldGradient(
      title: "Cari kota",
      body: Text("Select City"),
    );
  }
}
