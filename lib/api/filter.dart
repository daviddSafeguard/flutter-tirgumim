class Filter {
  String key;
  String operator;
  var value;

  List<Filter> listParams = [];
  String operatorListParams;

  Filter.simple(this.key, this.operator, this.value) {
    if (value is String && operator != "in") {
      value = "'$value'";
    }
    if (value is List) {
      if (value.length == 0)
        value = null; // "length list is 0";
      else {
        String newValue = '';

        if (value[0] is String)
          for (int i = 0; i < value.length; i++) {
            value[i] = "'" + value[i].toString() + "'";
          }
        newValue = value.join(',');

        value = newValue;
      }
    }
  }

  Filter({this.key, this.operator, this.value, this.listParams, this.operatorListParams}) {
    if (value is String && operator != "in") {
      value = "'$value'";
    }
    if (value is List) {
      if (value.length == 0) throw "length list is 0";

      String newValue = '';

      if (value[0] is String)
        for (int i = 0; i < value.length; i++) {
          value[i] = "'" + value[i].toString() + "'";
        }
      newValue = value.join(',');
      value = newValue;
    }
  }

  String getStringFilter() {
    String string = '';
    if (listParams != null && listParams.length > 0) {
      string = "(";
      for (var i = 0; listParams.length > i; i++) {
        // print(listParams[i].operatorListParams);
        string = string + listParams[i].getStringFilter();
        if (i < listParams.length - 1)
          string += " $operatorListParams ";
        else
          string += ") ";
        // print(string);
      }
      return string;
    } else if (listParams == null || listParams.length == 0) {
      if (this.value == null) {
        string = "";
      } else if (this.operator == "not contains") {
        String newValue = value.toString();
        if (newValue.startsWith("'")) {
          newValue = newValue.substring(1);
        }
        if (newValue.endsWith("'")) {
          newValue = newValue.substring(0, newValue.length - 1);
        }
        // string = "$key LIKE '%25" + newValue.substring(1, newValue.length - 1) + "%25'";
        string = "$key NOT LIKE '%25" + newValue + "%25'";
      } else if (this.operator == "contains") {
        String newValue = value.toString();
        if (newValue.startsWith("'")) {
          newValue = newValue.substring(1);
        }
        if (newValue.endsWith("'")) {
          newValue = newValue.substring(0, newValue.length - 1);
        }
        // string = "$key LIKE '%25" + newValue.substring(1, newValue.length - 1) + "%25'";
        string = "$key LIKE '%25" + newValue + "%25'";

        // string = "$key LIKE '%25$value%25'";
      } else if (this.operator == "startwith") {
        String newValue = value.toString();
        if (newValue.startsWith("'")) {
          newValue = newValue.substring(1);
        }
        if (newValue.endsWith("'")) {
          newValue = newValue.substring(0, newValue.length - 1);
        }
        // string = "$key LIKE " + newValue.substring(0, newValue.length - 1) + "%25'";
        string = "$key LIKE '" + newValue + "%25'";
      } else if (this.operator == "in") {
        string = "$key IN ($value)";
        // string = "$key IN ("+value+")";
      } else if (this.operator == "isnull") {
        string = "$key is null";
      } else if (this.operator == "isnotnull") {
        string = "$key is not null";
      } else if (this.operator == "isnull") {
        string = "$key is null";
      } else if (this.operator == "isnull") {
        string = "$key is null";
      } else {
        string = "$key$operator$value";
      }
      // print(string);
      return string;
    } else
      return "";
  }
}

class Query {
  static String sessionId;
  static Uri login(Map<String, String> params) {
    params.addAll({"output": "json"}); //"sessionId": sessionId,
    Uri schemeUri = new Uri(scheme: 'https', host: 'www.safeguardapps.com', path: '/rest/api/login', queryParameters: params);
    return schemeUri;
  }

  static Uri logout() {
    Map<String, String> params = {"sessionId": sessionId, "output": "json"};

    Uri schemeUri = new Uri(scheme: 'https', host: 'www.safeguardapps.com', path: '/rest/api/logout', queryParameters: params);
    return schemeUri;
  }

  static select(List<String> params, String object, {Filter query, String orderBy = "updatedAt desc", String groupBy = "", int startRow = 0, int maxRows = 20000}) {
    String stringParams = '';
    params.removeWhere((item) => item == null || item == "");
    stringParams = params.join(',');
    String urlQuery = "https://www.safeguardapps.com/rest/api/selectQuery?sessionId=$sessionId&query=select $stringParams from $object";
    if (query != null) {
      String stringQuery = query.getStringFilter();

      urlQuery += " WHERE $stringQuery";
    }
    if (groupBy != "" && groupBy != null) {
      urlQuery += " group by $groupBy order by $orderBy &startRow=$startRow&maxRows=$maxRows&output=json";
    } else {
      urlQuery += " order by $orderBy &startRow=$startRow&maxRows=$maxRows&output=json";
    }

    return urlQuery;
  }

  static Uri updateRecord() {
    Map<String, String> params = {"sessionId": sessionId, "output": "json", "useIds": "true"};

    Uri schemeUri = new Uri(scheme: 'https', host: 'www.safeguardapps.com', path: '/rest/api/updateRecord', queryParameters: params);
    return schemeUri;
  }

  static Uri deleteRecord(String objectName, String idRecord) {
    Map<String, String> params = {"sessionId": sessionId, "output": "json", "useIds": "true", "objName": objectName, "id": idRecord};

    Uri schemeUri = new Uri(scheme: 'https', host: 'www.safeguardapps.com', path: '/rest/api/deleteRecord', queryParameters: params);
    return schemeUri;
  }

  static Uri createRecord() {
    Map<String, String> params = {"sessionId": sessionId, "output": "json", "useIds": "true"};
    Uri schemeUri = new Uri(scheme: 'https', host: 'www.safeguardapps.com', path: '/rest/api/createRecord', queryParameters: params);
    return schemeUri;
  }

  static Uri getRecord(Map<String, String> params) {
    params.addAll({"sessionId": sessionId, "output": "json", "useIds": "true"});
    Uri schemeUri = new Uri(scheme: 'https', host: 'www.safeguardapps.com', path: '/rest/api/getRecord', queryParameters: params);
    return schemeUri;
  }

  static Uri setBinaryData() {
    Map<String, String> params = {"sessionId": sessionId, "output": "json"};
    Uri schemeUri = new Uri(scheme: 'https', host: 'www.safeguardapps.com', path: '/rest/api/setBinaryData', queryParameters: params);
    return schemeUri;
  }

  static Uri getBinaryData(Map<String, String> params) {
    params.addAll({"sessionId": sessionId, "output": "json"});
    Uri schemeUri = new Uri(scheme: 'https', host: 'www.safeguardapps.com', path: '/rest/api/getBinaryData', queryParameters: params);
    return schemeUri;
  }

  static Uri getPicklist(Map<String, String> params) {
    params.addAll({"sessionId": sessionId, "output": "json"});
    Uri schemeUri = new Uri(scheme: 'https', host: 'www.safeguardapps.com', path: '/rest/api/getPicklist', queryParameters: params);
    return schemeUri;
  }

  static Uri getRelationships(Map<String, String> params, {List<String> fieldList}) {
    params.addAll({"sessionId": sessionId, "output": "json"});
    // fieldList ?? params.addAll({"fieldList": fieldList.join(",")});
    if (fieldList != null) //{
      params.addAll({"fieldList": fieldList.join(",")});
    // }
    Uri schemeUri = new Uri(scheme: 'https', host: 'www.safeguardapps.com', path: '/rest/api/getRelationships', queryParameters: params);
    return schemeUri;
  }

  static Uri getRoles(Map<String, String> params) {
    params.addAll({"sessionId": sessionId, "output": "json"});
    Uri schemeUri = new Uri(scheme: 'https', host: 'www.safeguardapps.com', path: '/rest/api/getRoles', queryParameters: params);
    return schemeUri;
  }

  static Uri getIdByOriginalID(Map<String, String> params) {
    params.addAll({"sessionId": sessionId, "output": "json"});
    Uri schemeUri = new Uri(scheme: 'https', host: 'www.safeguardapps.com', path: '/rest/api/getIdByOriginalId', queryParameters: params);
    return schemeUri;
  }
}

main() {
  List<dynamic> list = List<dynamic>.generate(3, (int index) => index * index);
  Filter json = Filter(listParams: [Filter(key: "id", operator: "isnull", value: 123456789), Filter(key: "id", operator: "contains", value: 123456789)], operatorListParams: "and");
  json.listParams.add(Filter(operatorListParams: "or", listParams: [Filter(key: "name", operator: "startwith"), Filter(key: "name", operator: "in", value: list)]));
}
