
class ListCity {
  String id;
  String lokasi;

  ListCity({
    required this.id,
    required this.lokasi,
  });

  factory ListCity.fromJson(Map<String, dynamic> json) => ListCity(
        id: json["id"],
        lokasi: json["lokasi"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "lokasi": lokasi,
      };
}
