class TRow {
  int id;
  String name;
  var image;
  Map<int, Map<int, String>> trowTable = {};
  int selectedRow;
  int selectedcell;
  String epic;

  static Map<dynamic, String> keys = {
    "OBJECT_NAME": "USER",
    "NAME": "name",
  };

  TRow({
    this.id,
    this.name,
    this.image = 'https://picsum.photos/250?image=9',
    this.trowTable,
    this.selectedRow,
    this.selectedcell,
    this.epic,
  });

  factory TRow.fromJson(Map<String, dynamic> json) {
    return TRow(
      id: json['id'],
      name: json[TRow.keys["NAME"]],
      epic: json['epic'],
      image: 'https://picsum.photos/250?image=9',
    );
  }
}
