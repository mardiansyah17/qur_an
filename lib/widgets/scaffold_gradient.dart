import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:qur_an/widgets/bottom_navigation.dart';

class ScaffoldGradient extends StatefulWidget {
  const ScaffoldGradient(
      {super.key,
      required this.body,
      this.title = '',
      this.showBottomNav = true});
  final Widget body;
  final String title;
  final bool showBottomNav;

  @override
  State<ScaffoldGradient> createState() => _ScaffoldGradientState();
}

class _ScaffoldGradientState extends State<ScaffoldGradient> {
  int _selectedIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: background,
      extendBodyBehindAppBar: true,
      appBar: widget.title.isNotEmpty
          ? AppBar(
              iconTheme: const IconThemeData(color: Color(0xFF65D6FC)),
              title: Text(
                widget.title,
                style: const TextStyle(fontSize: 16, color: Color(0xFF65D6FC)),
              ),
              backgroundColor: Colors.transparent,
            )
          : null,
      bottomNavigationBar: widget.showBottomNav
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
              colors: [Color(0xFF112095), Color(0xFF092052)]),
        ),
        child: SafeArea(
          child: widget.body,
        ),
        // child: Container(
        //   child: Text('mantap'),
        // ),
      ),
    );
  }
}
