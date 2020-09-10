import 'package:tirgumim/api/api.dart';
import 'package:tirgumim/api/filter.dart';

class CoolFuncs {
  static String removeNullFromString(string) {
    if (string != null && string != "null")
      return string;
    else
      return "";
  }

  static bool getBoolFromInt(integer) {
    if (integer == 1 || integer == "1" || integer == true || integer == 'true')
      return true;
    else
      return false;
  }

  static int getIntFromBool(boolean) {
    if (boolean == 1 || boolean == "1" || boolean == true || boolean == 'true')
      return 1;
    else
      return 0;
  }

  static int getInt(notInt) {
    if (notInt is int)
      return notInt;
    else if (notInt is double)
      return notInt.toInt();
    else if (notInt is String)
      return int.parse(notInt);
    else
      return null;
  }

  static List<int> getM2MRel(value) {
    if (value == null) return [];
    return value is int ? [value] : List<int>.from(value);
  }

  // static List<Map<String, String>> buildPickListDataSource(picklist, id, value, {picklistKey}) {
  //   //return
  //   return new List<Map<String, String>>.generate(
  //       picklist.length,
  //       (int index) => {
  //             "display":
  //                 picklistKey == null ? picklist[index][value].toString() : GeneralAppStore.getPickListString(picklistKey, picklist[index]["code"].toString(), picklist[index][value].toString()),

  //             // picklist[index].name.toString(),
  //             "value": picklist[index][id].toString()
  //           });
  // }

  static Future<Map> oneJsonPlease(String objectName, List<String> fields, {Filter filters}) async {
    Map<String, List<String>> returnMap = {};
    Map<int, String> keyPlaces = {};
    for (var i = 0; i < fields.length; i++) {
      String fieldName = fields[i];
      returnMap[fieldName] = new List<String>();
      keyPlaces[i] = fieldName;
    }
    List response = await Api.select(fields, objectName, query: filters);
    response
        .map((fields) => {
              for (var i = 0; i < fields.length; i++) {returnMap[keyPlaces[i]].add(fields[i])}
            })
        .toList();
    print(returnMap);
    return returnMap;
  }
}
