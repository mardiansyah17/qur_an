import 'dart:developer';
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:qur_an/src/core/theme/app_pallete.dart';

class TranslateWidget extends StatelessWidget {
  final String translate;
  final String? noteNumber;
  final String? noteText;

  const TranslateWidget({
    super.key,
    required this.translate,
    this.noteNumber,
    this.noteText,
  });
  static const styleText = TextStyle(
    color: Colors.black,
    height: 1.2,
    fontSize: 16,
  );

  @override
  Widget build(BuildContext context) {
    if (noteNumber == null && noteText == null) {
      return Align(
        alignment: Alignment.centerLeft,
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: translate,
                style: styleText,
              ),
            ],
          ),
        ),
      );
    }

    List<InlineSpan> spans = [];
    int start = 0;
    int index = translate.indexOf(noteNumber!);
    while (index != -1) {
      if (index > start) {
        spans.add(TextSpan(
          text: translate.substring(start, index),
        ));
      }
      spans.add(WidgetSpan(
          child: Tooltip(
        enableTapToDismiss: true,
        showDuration: const Duration(minutes: 2),
        triggerMode: TooltipTriggerMode.tap,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: AppPallete.primary),
          // buatkan shadow tipis
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        textStyle: const TextStyle(color: AppPallete.primary),
        message: noteText!,
        child: Text(
          " $noteNumber)",
          style: const TextStyle(
            color: AppPallete.primary,
            fontSize: 15,
          ),
        ),
      )));
      start = index + noteNumber!.length;
      index = translate.indexOf(noteNumber!, start);
    }

    if (start < translate.length) {
      spans.add(TextSpan(
        text: translate.substring(start + 1),
      ));
    }
    return Align(
      alignment: Alignment.centerLeft,
      child: Text.rich(
        TextSpan(children: spans, style: styleText),
      ),
    );
  }
}
