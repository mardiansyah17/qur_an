import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qur_an/screens/home.dart';
import 'package:qur_an/screens/jadwal_sholat.dart';
import 'package:qur_an/screens/kiblah.dart';
import 'package:qur_an/widgets/bottom_navigation.dart';
import 'package:qur_an/widgets/container_gradient.dart';

class TabWraper extends StatefulWidget {
  const TabWraper({
    Key? key,
    this.title,
    this.showBottomNav = true,
    this.body,
  }) : super(key: key);

  final bool showBottomNav;
  final Widget? body;
  final Widget? title;

  @override
  State<TabWraper> createState() => _TabWraperState();
}

class _TabWraperState extends State<TabWraper> {
  int _selectedIndex = int.parse(Get.parameters["selectedIndex"] ?? "") ?? 0;

  final _pages = [const Home(), const JadwalSholat(), const Kiblah()];

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      bottomNavigationBar: BottomNavigation(
        onTap: onItemTapped,
        selectedIndex: _selectedIndex,
      ),
      body: ContainerGradient(
        body: _pages[_selectedIndex],
      ),
    );
  }
}
