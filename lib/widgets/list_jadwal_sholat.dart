import 'package:flutter/material.dart';
import 'package:qur_an/utils/app_colors.dart';
import 'package:qur_an/widgets/item_jadwal_sholat.dart';

class ListJadwalSholat extends StatelessWidget {
  const ListJadwalSholat({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ItemJadwalSholat(),
        ItemJadwalSholat(),
        ItemJadwalSholat(
          isActivated: true,
        ),
      ],
    );
  }
}
