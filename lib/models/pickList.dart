import 'dart:collection';

class Picklist {
  int id;
  String code;
  String name;

  String operator [](String key) {
    switch (key) {
      case 'id':
        return id.toString();
      case 'name':
        return name;
      case 'code':
        return code.toString();
      default:
        return "";
    }
  }

  Picklist({
    this.id,
    this.code,
    this.name,
  });

  Picklist.fromJson(Map<String, dynamic> json, picklistStrings)
      : id = json['id'],
        code = json['code'],
        name = //json['name'];
            (picklistStrings != null && json['code'] != null && picklistStrings[json['code']] != null) ? picklistStrings[json['code']] : json['name'];

  Picklist.fromJson2(Map<String, dynamic> json, picklistStrings)
      : id = json['id'],
        code = json['code'],
        name = //json['name'];
            json['name'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'code': code.toString(),
        'name': name,
      };

  static String getNameFromId(id, picklist) {
    for (var x in picklist) {
      if (x.id.toString() == id.toString()) return x.name;
    }
    return null;
  }

  static String getCodeFromId(id, picklist) {
    if (id == null || id == "null" || picklist == null || picklist == "null") throw "null";
    for (final x in picklist) {
      if (x.code.toString() == id.toString() || x.id.toString() == id.toString()) return x.code;
    }
    return null;
  }

  static String getCodeFromName(name, picklist) {
    if (name == null || name == "null" || picklist == null || picklist == "null") throw "null";
    for (final x in picklist) {
      if (x.code.toString() == name.toString() || x.name.toString() == name.toString()) return x.code;
    }
    return null;
  }

  static int getIdFromCode(code, picklist) {
    for (final x in picklist) {
      if (x.id.toString() == code.toString() || x.code.toString() == code.toString()) return x.id;
    }
    return null;
  }

  static String getNameFromCode(id, picklist, {String label}) {
    for (final x in picklist) {
      if (x.code.toString() == id) return x.name;
    }
    return label;
  }

  static String getName(id, picklist, {String integrationName}) {
    for (final x in picklist) {
      if (x.code == id || x.id.toString() == id.toString()) if (integrationName != null)
        return x.name;
      else
        return x.name;
    }
    return null;
  }

  static List<String> getNames(String idArrey, picklist) {
    if (idArrey == null || idArrey == "") {
      return [""];
    } else {
      idArrey = idArrey.replaceAll('|', ',');
      List<String> listo = idArrey.split(',');
      if (listo[0].length == 1) {
        return new List<String>.generate(listo.length, (int index) => getNameFromCode(listo[index], picklist));
      } else {
        return new List<String>.generate(listo.length, (int index) => getNameFromId(listo[index], picklist));
      }
    }
  }

  static List<String> getNamesByLanguage(String idArrey, List<Picklist> picklist, String integrationName) {
    if (idArrey == null || idArrey == "") {
      return [""];
    } else {
      idArrey = idArrey.replaceAll('|', ',');
      List<String> listo = idArrey.split(',');
      return new List<String>.generate(listo.length, (int index) => integrationName);
    }
  }

  static List<String> getcodes(idArrey, picklist) {
    if (idArrey == null || idArrey == "") {
      return [""];
    } else {
      idArrey = idArrey.replaceAll('|', ',');
      List<String> listo = idArrey.split(',');
      if (listo[0].length == 1) {
        return new List<String>.generate(listo.length, (int index) => listo[index]);
      } else {
        return new List<String>.generate(listo.length, (int index) => getCodeFromId(listo[index], picklist));
      }
    }
  }

  static List<Map<String, String>> getNamesAndcode(idArrey, picklist) {
    if (idArrey == null || idArrey == "") {
      return [null];
    } else {
      idArrey = idArrey.replaceAll('|', ',');
      List<String> listo = idArrey.split(',');
      if (listo[0].length == 1) {
        return new List<Map<String, String>>.generate(listo.length, (int index) => {"name": Picklist.getNameFromCode(listo[index], picklist), "code": listo[index]});
      } else {
        return new List<Map<String, String>>.generate(listo.length, (int index) => {"name": Picklist.getNameFromId(listo[index], picklist), "code": listo[index]});
      }
    }
  }

  static List<Map<String, String>> pickListDataSource(picklist, picklistName) {
    return new List<Map<String, String>>.generate(picklist.length, (int index) => {"display": picklist[index].name.toString(), "value": picklist[index].id.toString()});
  }

  static List<Map<String, String>> buildPickListDataSource(List picklist, key) {
    return new List<Map<String, String>>.generate(picklist.length, (int index) => {"display": picklist[index].name.toString(), "value": picklist[index].id.toString()});
  }

  static List<Map<String, String>> buildDataSource(List data) {
    return new List<Map<String, String>>.generate(data.length, (int index) => {"display": data[index].name.toString(), "value": data[index].id.toString()});
  }

  static Map<int, String> getDropDownMap(List<Picklist> picklist) {
    LinkedHashMap<int, String> temp = new LinkedHashMap();
    for (var pick in picklist) {
      temp[pick.id] = pick.name;
    }
    return temp;
  }
}

List<Map<String, String>> buildPickListDataSource(List<Picklist> picklist, key) {
  return new List<Map<String, String>>.generate(picklist.length, (int index) => {"display": picklist[index].name.toString(), "value": picklist[index].id.toString()});
}
