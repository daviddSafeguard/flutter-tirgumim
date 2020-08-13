class TRow {
  int id;
  String name;
  var image;
  Map<int, Map<int, String>> words = {};
  int selectedRow;
  int selectedcell;

  static Map<dynamic, String> keys = {
    "OBJECT_NAME": "USER",
    "NAME": "name",
  };

  TRow({
    this.id,
    this.name,
    this.image = 'https://picsum.photos/250?image=9',
    this.words,
    this.selectedRow,
    this.selectedcell,
  });

  factory TRow.fromJson(Map<String, dynamic> json) {
    return TRow(
      id: json['id'],
      name: json[TRow.keys["NAME"]],
      image: 'https://picsum.photos/250?image=9',
    );
  }
}
