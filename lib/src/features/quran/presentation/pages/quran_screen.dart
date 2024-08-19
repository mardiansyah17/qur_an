import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qur_an/src/core/widgets/app_loading.dart';
import 'package:qur_an/src/core/widgets/app_search_widget.dart';
import 'package:qur_an/src/features/quran/presentation/blocs/surah_bloc/surah_bloc.dart';
import 'package:qur_an/src/features/quran/presentation/widgets/item_surah_widget.dart';

class QuranScreen extends StatefulWidget {
  const QuranScreen({super.key});

  @override
  State<QuranScreen> createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> {
  final FocusNode focusNode = FocusNode();
  @override
  void initState() {
    super.initState();

    context.read<SurahBloc>().add(GetSurah());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        focusNode.unfocus();
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          title: AppSearchWidget(
            title: "Cari Surah",
            focusNode: focusNode,
            onChanged: (query) {
              context.read<SurahBloc>().add(SearchSurah(name: query));
            },
          ),
          toolbarHeight: 65,
        ),
        body: BlocBuilder<SurahBloc, SurahState>(
          builder: (context, state) {
            if (state is SurahLoading) {
              return const Center(
                child: AppLoading(),
              );
            }
            if (state is SurahLoaded) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: state.surahFilterByName == null
                            ? state.surah!.length
                            : state.surahFilterByName!.length,
                        itemBuilder: (context, index) {
                          return ItemSurahWidget(
                            surah: state.surahFilterByName == null
                                ? state.surah![index]
                                : state.surahFilterByName![index],
                          );
                        }),
                  ),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
