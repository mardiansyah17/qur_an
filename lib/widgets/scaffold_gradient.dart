import 'package:flutter/material.dart';
import 'package:qur_an/screens/home.dart';
import 'package:qur_an/screens/jadwal_sholat.dart';
import 'package:qur_an/widgets/bottom_navigation.dart';

class ScaffoldGradient extends StatefulWidget {
  const ScaffoldGradient({
    Key? key,
    this.title = '',
    this.showBottomNav = true,
    this.body,
  }) : super(key: key);

  final String title;
  final bool showBottomNav;
  final Widget? body;

  @override
  State<ScaffoldGradient> createState() => _ScaffoldGradientState();
}

class _ScaffoldGradientState extends State<ScaffoldGradient> {
  int _selectedIndex = 0;

  final _pages = [
    const Home(),
    const JadwalSholat(),
  ];

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: widget.title.isNotEmpty
          ? AppBar(
              iconTheme: const IconThemeData(color: Color(0xFF65D6FC)),
              title: Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF65D6FC),
                ),
              ),
              backgroundColor: Colors.transparent,
            )
          : null,
      bottomNavigationBar: widget.body == null
          ? BottomNavigation(
              onTap: onItemTapped,
              selectedIndex: _selectedIndex,
            )
          : null,
      body: Container(
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
              child: widget.body ?? _pages.elementAt(_selectedIndex),
            ),
          ],
        ),
      ),
    );
  }
}
