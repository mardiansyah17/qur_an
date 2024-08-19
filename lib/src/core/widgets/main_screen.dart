import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qur_an/src/core/theme/app_pallete.dart';
import 'package:qur_an/src/features/kiblah/presentation/pages/kiblah_screen.dart';
import 'package:qur_an/src/features/prayer_time/presentation/pages/prayer_time_screen.dart';
import 'package:qur_an/src/features/quran/presentation/pages/quran_screen.dart';
import 'package:lazy_load_indexed_stack/lazy_load_indexed_stack.dart';

class MainScreen extends StatefulWidget {
  final int? index;
  const MainScreen({super.key, this.index = 1});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int? _selectedIndex;
  static const List<Widget> _widgetOptions = <Widget>[
    PrayerTimeScreen(),
    QuranScreen(),
    KiblahScreen(),
  ];

  @override
  void initState() {
    super.initState();
    setState(() {
      _selectedIndex = widget.index ?? 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LazyLoadIndexedStack(
        index: _selectedIndex!,
        preloadIndexes: const [3],
        children: _widgetOptions,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        buttonBackgroundColor: AppPallete.primary,
        backgroundColor: AppPallete.second,
        index: _selectedIndex!,
        items: <Widget>[
          BottomNavItem(
            svg: "prayer",
            isActive: _selectedIndex == 0,
          ),
          BottomNavItem(
            svg: "quran",
            isActive: _selectedIndex == 1,
          ),
          BottomNavItem(
            svg: "qibla",
            isActive: _selectedIndex == 2,
          ),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}

class BottomNavItem extends StatelessWidget {
  final String svg;
  final bool isActive;
  const BottomNavItem({
    super.key,
    required this.svg,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/svg/$svg.svg',
      height: 30,
      colorFilter: ColorFilter.mode(
          isActive ? AppPallete.white : AppPallete.primary, BlendMode.srcIn),
    );
  }
}
