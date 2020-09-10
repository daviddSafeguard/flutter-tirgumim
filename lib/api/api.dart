import 'dart:convert';
import 'dart:typed_data';
import 'package:tirgumim/api/filter.dart';
import 'package:http/http.dart' as http;
import 'package:tirgumim/models/pickList.dart';
import 'package:tirgumim/models/role.dart';

class Api {
  static Query query;
  static Future<String> login({String email, String password}) async {
    try {
      Uri loginUrl = Query.login({"loginName": email, "password": password});
      String path = loginUrl.toString().replaceAll(new RegExp(r"%09|%E2|%80|%8E"), "");
      var response = await http.get(path); //.timeout(const Duration(seconds: 30));
      print("LOGIN, status code: " + response.statusCode.toString() + " USERNAME: $email PASSWORD: $password");
      if (response.statusCode != 200) throw response;
      Map data = json.decode(response.body);
      Query.sessionId = data["sessionId"];
      print("SESSION ID: : " + data["sessionId"]);
      return Query.sessionId;
    } catch (error) {
      print(error);
      throw error;
    }
  }

  static Future<void> logout() async {
    try {
      Uri logoutUrl = Query.logout();
      var response = await http.get(logoutUrl).timeout(const Duration(seconds: 30));
      String sessionId = Query.sessionId;
      print("LOGOUT, status code: " + response.statusCode.toString() + " SESSION_ID: $sessionId");
      if (response.statusCode != 200) throw response;
    } catch (error) {
      throw error;
    }
  }

  static Future<bool> setBinaryData(Map<String, dynamic> params) async {
    try {
      Uri setBinaryDataUrl = Query.setBinaryData();
      var response = await http.post(setBinaryDataUrl, body: params).timeout(const Duration(seconds: 30));
      print("SET BINARY DATA: $setBinaryDataUrl");
      if (response.statusCode != 200) throw response;
      // Map data = json.decode(response.body);
      return true;
    } catch (error) {
      throw error;
    }
  }

  static Future<Map> getBinaryData(Map<String, dynamic> params) async {
    try {
      Uri getBinaryDataUrl = Query.getBinaryData(params);
      // print(getBinaryDataUrl);
      var response = await http.get(getBinaryDataUrl).timeout(const Duration(seconds: 30));
      // print(response.statusCode);
      print("GET BINARY DATA: $getBinaryDataUrl");

      if (response.statusCode != 200) throw response;
      Map data = json.decode(response.body);
      return data;
    } catch (error) {
      throw error;
    }
  }

  static Future<List> select(List<String> params, String object, {Filter query, String orderBy = "updatedAt desc", String groupBy = "", int startRow = 0, int maxRows = 20000}) async {
    try {
      String url = Query.select(params, object, query: query, orderBy: orderBy, startRow: startRow, maxRows: maxRows, groupBy: groupBy);

      var response = await http.get(url).timeout(const Duration(seconds: 30));

      response.body.replaceAll(new RegExp("\t"), "   ");
      // response.body.replaceAll(new RegExp("\n"), "");
      // response.body.replaceAll(new RegExp(r'[^\w\s]+'), "");
      //response.body.replaceAll(new RegExp("/\(|\)/g"), "");
      if (response.statusCode != 200) {
        print("SELECT $object, $url, STATUS CODE: " + response.statusCode.toString());
        throw response;
      }
      List data = json.decode(response.body.replaceAll(new RegExp("\t"), "   "));
      print("SELECT $object, $url, STATUS CODE: " + response.statusCode.toString() + ", LENGTH: ${data.length}");
      return data;
    } catch (error) {
      print(error);
      throw error;
    }
  }

  static Future<bool> updateRecord(Map<String, String> params) async {
    try {
      Uri updateQuery = Query.updateRecord();
      var response = await http.post(updateQuery, body: params).timeout(const Duration(seconds: 30));
      //     Uri updateQuery = Query.updateRecord(params);
      // var response = await http.post(updateQuery, body: params);

      // var response = await http.get(updateQuery);

      print("UPDATE RECORD: $updateQuery, STATUS CODE: " + response.statusCode.toString() + ", PARAMS: " + params.toString());
      if (response.statusCode != 200) throw response;
      return true;
    } catch (error) {
      print(error);
      throw error;
    }
  }

  static Future<bool> deleteRecord(String objectName, String idRecord) async {
    try {
      Uri deleteQuery = Query.deleteRecord(objectName, idRecord);
      var response = await http.delete(deleteQuery).timeout(const Duration(seconds: 30));
      print("---------DELETE---------- \n $deleteQuery. \n STATUS CODE: " + response.statusCode.toString());
      if (response.statusCode != 200) {
        print("---------DELETE SERVER ERROR---------- \n $response");
        throw response;
      }

      return true;
    } catch (error) {
      print("---------DELETE MOBILE ERROR---------- \n ${error.body}");
      throw error;
    }
  }

  static Future<int> createRecord(Map<String, String> params) async {
    try {
      print(DateTime.now());
      Uri createQuery = Query.createRecord();
      var response = await http.post(createQuery, body: params).timeout(const Duration(seconds: 30));
      print("CREATE RECORD: $createQuery, STATUS CODE: " + response.statusCode.toString() + ", PARAMS: " + params.toString());
      if (response.statusCode != 200) throw json.decode(response.body);
      var data = json.decode(response.body);
      var id = data['id'];
      return id;
    } catch (error) {
      throw error;
    }
  }

  static Future<String> getRecord(String objName, int id, List<String> fieldList, {int composite = 0}) async {
    try {
      Map<String, String> params = {"objName": objName, "id": id.toString(), "fieldList": fieldList.join(','), "composite": composite.toString()};
      Uri getRecordQuery = Query.getRecord(params);
      var response = await http.get(getRecordQuery).timeout(const Duration(seconds: 30));
      print("GET RECORD: $getRecordQuery, STATUS CODE: " + response.statusCode.toString() + ", PARAMS: " + params.toString());
      if (response.statusCode != 200) throw response;
      return response.body;
    } catch (error) {
      throw error;
    }
  }

  static Future<List<Picklist>> getPickList(String sessionId, String objectName, String picklistName, {String picklistStrings}) async {
    try {
      Uri getPicklistQuery = Query.getPicklist({
        "objName": objectName,
        "fieldName": picklistName,
      });

      var response = await http.get(getPicklistQuery).timeout(const Duration(seconds: 30));
      print("GET PICKLIST $picklistName OF $objectName: $getPicklistQuery, STATUS CODE: " + response.statusCode.toString());

      if (response.statusCode != 200) throw response;
      List pickListJSON = json.decode(response.body);
      List<Picklist> pickList = pickListJSON.map((p) => Picklist.fromJson(p, null)).toList();
      return pickList;
    } catch (error) {
      throw error;
    }
  }

  static Future<List> getRelationships(String objectName, String relationshipName, int id, {List<String> fieldList}) async {
    try {
      Uri getRelationshipsQuery = Query.getRelationships({
        "id": id.toString(),
        "objName": objectName,
        "relName": relationshipName,
      }, fieldList: fieldList);
      var response = await http.get(getRelationshipsQuery).timeout(const Duration(seconds: 30));
      print("GET Relationships $relationshipName OF $objectName: $getRelationshipsQuery, STATUS CODE: " + response.statusCode.toString());

      if (response.statusCode != 200) throw response;

      List responseJson = json.decode(response.body);

      return responseJson;
    } catch (error) {
      throw error;
    }
  }

  static Future<List<Role>> getRoles(String sessionId) async {
    try {
      Uri getRolesQuery = Query.getRoles({});
      var response = await http.get(getRolesQuery).timeout(const Duration(seconds: 30));
      print("GET PICKLIST: $getRolesQuery, STATUS CODE: " + response.statusCode.toString());
      if (response.statusCode != 200) throw response;
      List rolesJson = json.decode(response.body);
      List<Role> roles = rolesJson.map((r) => Role.fromJson(r)).toList();

      return roles;
    } catch (error) {
      throw error;
    }
  }

  static Future<Uint8List> getFileFromUrl(String url) async {
    try {
      var response = await http.get(url).timeout(const Duration(seconds: 60));
      print("GET URL: $url, STATUS CODE: " + response.statusCode.toString());
      if (response.statusCode != 200) throw response;
      return response.bodyBytes;
    } catch (error) {
      throw error;
    }
  }

  static Future<int> getIdByOriginalID(String entityType, String origId) async {
    Uri getIdByOriginalID = Query.getIdByOriginalID({
      "entityType": entityType,
      "origId": origId,
    });
    var response = await http.get(getIdByOriginalID).timeout(const Duration(seconds: 30));
    print("GET GET_ID_BY_ORIGINAL_ID: $getIdByOriginalID, STATUS CODE: " + response.statusCode.toString());
    if (response.statusCode != 200) throw response;
    return (json.decode(response.body)["id"]);
  }
}
