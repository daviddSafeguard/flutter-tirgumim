import 'package:flutter/material.dart';
import 'package:tirgumim/api/api.dart';
import 'package:tirgumim/models/user.dart';

class AppStore extends ChangeNotifier {
  static Map<int, User> users = {};

  Future<void> getAllUsers() async {
    var selectedKeys = [
      "id",
      User.keys["NAME"],
      User.keys["LOGIN_NAME"],
      User.keys["PERSONAL_ID"],
      User.keys["USER_ROLE"],
      User.keys["URL_PHOTO_USER"],
      User.keys["FIRST_NAME"],
      User.keys["LAST_NAME"],
      User.keys["EMAIL"],
      User.keys["USER_PHONE"],
      User.keys["DEV_TOKEN"],
      User.keys["TOKEN_SAFEGUARD"],
      User.keys["STATUS"]
    ];
    List response = await Api.select(selectedKeys, User.keys["OBJECT_NAME"]);

    if (response.length == 0) {
      users = {};
      response.forEach((item) => users[item[0]] = User.fromJson(new Map.fromIterables(selectedKeys, item)));
    }
    print(users);

    notifyListeners();
  }
}
