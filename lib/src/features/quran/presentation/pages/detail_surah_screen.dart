import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qur_an/src/core/widgets/app_loading.dart';
import 'package:qur_an/src/features/quran/domain/entities/ayat.dart';
import 'package:qur_an/src/features/quran/presentation/blocs/ayat_bloc/ayat_bloc.dart';
import 'package:qur_an/src/features/quran/presentation/blocs/play_sound_bloc/play_sound_bloc.dart';
import 'package:qur_an/src/features/quran/presentation/widgets/item_ayat_widget.dart';
import 'package:just_audio/just_audio.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class DetailSurahScreen extends StatefulWidget {
  final String surat;
  final String name;
  final int maxAyat;
  const DetailSurahScreen(
      {super.key,
      required this.surat,
      required this.name,
      required this.maxAyat});

  @override
  State<DetailSurahScreen> createState() => _DetailSurahScreenState();
}

class _DetailSurahScreenState extends State<DetailSurahScreen> {
  final ItemScrollController itemScrollController = ItemScrollController();
  final ScrollOffsetController scrollOffsetController =
      ScrollOffsetController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  final ScrollOffsetListener scrollOffsetListener =
      ScrollOffsetListener.create();

  final AudioPlayer _player = AudioPlayer();
  List<Ayat> ayat = [];

  void playAudio(String url) async {
    await _player.setUrl(url);
    _player.play();
  }

  @override
  void initState() {
    super.initState();

    context.read<AyatBloc>().add(GetAyatBySurah(
          surat: widget.surat,
        ));

    itemPositionsListener.itemPositions.addListener(() {
      final lastItem = itemPositionsListener.itemPositions.value.last.index;
      if (lastItem == int.parse(ayat.last.number) - 1) {
        context.read<AyatBloc>().add(GetAyatBySurah(
              surat: widget.surat,
              lastAyat: int.parse(ayat.last.number),
            ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlaySoundBloc(),
      child: PopScope(
        onPopInvoked: (didPop) {
          context.read<AyatBloc>().add(ResetAyat());
        },
        child: Scaffold(
            appBar: AppBar(
              title: Text(widget.name),
              surfaceTintColor: Colors.transparent,
              // actions: [
              //   GestureDetector(
              //     child: Text("${ayat.length}/${widget.maxAyat}"),
              //   )
              // ],
            ),
            body: BlocConsumer<AyatBloc, AyatState>(
              listener: (context, state) {
                if (state is AyatLoaded) {
                  setState(() {
                    ayat = [...ayat, ...state.ayat];
                  });
                }
              },
              builder: (context, state) {
                if (state is AyatLoading) {
                  return const AppLoading();
                }

                return ScrollablePositionedList.builder(
                  itemScrollController: itemScrollController,
                  scrollOffsetController: scrollOffsetController,
                  itemPositionsListener: itemPositionsListener,
                  scrollOffsetListener: scrollOffsetListener,
                  itemCount: ayat.length,
                  itemBuilder: (context, index) {
                    if (state is AyatLoadingPagination &&
                        index == ayat.length - 1) {
                      return const AppLoading();
                    }
                    return ItemAyatWidget(
                      ayat: ayat[index],
                    );
                  },
                );
              },
            )),
      ),
    );
  }

  // @override
  // void dispose() {
  //   _scrollController.dispose();
  //   super.dispose();
  // }
}
