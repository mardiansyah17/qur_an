import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation(
      {super.key, required this.onTap, this.selectedIndex = 0});

  final int selectedIndex;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: (int index) {
        onTap(index);
      },
      type: BottomNavigationBarType.fixed,
      backgroundColor: const Color(0xFF121931),

      // backgroundColor: Colors.transparent,
      unselectedItemColor: const Color.fromARGB(255, 179, 208, 218),
      selectedItemColor: const Color(0xFF65D6FC),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(FlutterIslamicIcons.quran),
          label: 'Al-Qur\'an',
        ),
        BottomNavigationBarItem(
          icon: Icon(FlutterIslamicIcons.prayingPerson),
          label: 'Sholat',
        ),
        // BottomNavigationBarItem(
        //   icon: Icon(FlutterIslamicIcons.kaaba),
        //   label: 'Kiblat',
        // ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Setting',
        ),
      ],
    );
  }
}
