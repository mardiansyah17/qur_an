import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qur_an/src/core/theme/app_pallete.dart';
import 'package:qur_an/src/core/widgets/app_loading.dart';
import 'package:qur_an/src/features/quran/domain/entities/ayat.dart';
import 'package:qur_an/src/features/quran/presentation/blocs/play_sound_bloc/play_sound_bloc.dart';
import 'package:qur_an/src/features/quran/presentation/widgets/action_ayat_widget.dart';
import 'package:qur_an/src/features/quran/presentation/widgets/number_widget.dart';
import 'package:qur_an/src/features/quran/presentation/widgets/translate_widget.dart';

class ItemAyatWidget extends StatelessWidget {
  const ItemAyatWidget({super.key, required this.ayat});
  final Ayat ayat;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        context.read<PlaySoundBloc>().add(const StopAyat());
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 209, 242, 255),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    NumberWidget(nomor: ayat.number),
                    Row(
                      children: [
                        BlocBuilder<PlaySoundBloc, PlaySoundState>(
                          builder: (context, state) {
                            if (state is PlaySoundLoading &&
                                state.id == ayat.id) {
                              return const AppLoading();
                            }
                            if (state is PlayingAyat && state.id == ayat.id) {
                              return ActionAyatWidget(
                                icon: Icons.stop,
                                onTap: () {
                                  context.read<PlaySoundBloc>().add(StopAyat());
                                },
                              );
                            }
                            return ActionAyatWidget(
                              icon: Icons.play_arrow,
                              onTap: () {
                                context.read<PlaySoundBloc>().add(
                                    PlayAyat(url: ayat.audio, id: ayat.id));
                              },
                            );
                          },
                        ),
                        const SizedBox(width: 10),
                        const ActionAyatWidget(icon: Icons.bookmark),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.only(right: 15, top: 10),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      ayat.arab,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppPallete.primary,
                        height: 2,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      ayat.latin,
                      style: const TextStyle(
                        fontSize: 18,
                        color: AppPallete.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  TranslateWidget(
                    translate: ayat.terjemahan,
                    noteNumber: ayat.noteNumber,
                    noteText: ayat.noteText,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
