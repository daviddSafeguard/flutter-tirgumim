class Role {
  String originalId;
  String name;

  Role.fromJson(Map<String, dynamic> json)
      : originalId = json['originalId'],
        name = json['name'];

  Map<String, dynamic> toJson() => {
        'originalId': originalId,
        'name': name,
      };

  static String getNameFromOriginalId(originalId, roles) {
    for (final x in roles) {
      if (x.originalId.toString() == originalId.toString()) return x.name;
    }
    return null;
  }
}
