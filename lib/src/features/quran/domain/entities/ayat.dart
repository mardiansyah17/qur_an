class Ayat {
  final String id;
  final String number;
  final String arab;
  final String audio;
  final String latin;
  final String terjemahan;
  final String? noteNumber;
  final String? noteText;

  Ayat({
    required this.id,
    required this.number,
    required this.arab,
    required this.audio,
    required this.latin,
    required this.terjemahan,
    this.noteNumber,
    this.noteText,
  });
}
