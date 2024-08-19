import 'package:flutter/material.dart';
import 'package:qur_an/src/core/widgets/app_button.dart';
import 'package:qur_an/src/features/prayer_time/presentation/pages/select_city.dart';
import 'package:page_transition/page_transition.dart';

class NoLocationScreen extends StatelessWidget {
  const NoLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Anda belum memilih lokasi", style: TextStyle(fontSize: 20)),
        const SizedBox(height: 10),
        AppButton(
          text: "Pilih lokasi",
          onPressed: () async {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.fade, child: const SelectCity()));
          },
        )
      ],
    );
  }
}
