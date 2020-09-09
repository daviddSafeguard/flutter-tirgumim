import 'package:flutter/material.dart';
import 'package:tirgumim/api/api.dart';
import 'package:tirgumim/models/user.dart';

class AppStore extends ChangeNotifier {
  static List<User> users = [];
  bool isLoading = false;

  Future<void> getAllUsers() async {
    // await Future.delayed(const Duration(milliseconds: 1000), () async {
    //   users = [
    //     User(id: 123, name: "1", email: "a@a", phone: "1234567890", status: "admin"),
    //     User(id: 456, name: "2", email: "a@a", phone: "1234567890", status: "admin"),
    //     User(id: 789, name: "3", email: "a@a", phone: "1234567890", status: "admin"),
    //     User(id: 4, name: "4", email: "a@a", phone: "1234567890", status: "admin"),
    //     User(id: 5, name: "5", email: "a@a", phone: "1234567890", status: "admin"),
    //     User(id: 6, name: "6", email: "a@a", phone: "1234567890", status: "admin"),
    //     User(id: 7, name: "7", email: "a@a", phone: "1234567890", status: "admin"),
    //     User(id: 8, name: "8", email: "a@a", phone: "1234567890", status: "admin"),
    //     User(id: 9, name: "9", email: "a@a", phone: "1234567890", status: "admin"),
    //     User(id: 10, name: "10", email: "a@a", phone: "1234567890", status: "admin"),
    //     User(id: 11, name: "11", email: "a@a", phone: "1234567890", status: "admin"),
    //     User(id: 12, name: "12", email: "a@a", phone: "1234567890", status: "admin")
    //   ];
    // });

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
      users = [];
    } else {
      users = response.map((user) => User.fromJson(new Map.fromIterables(selectedKeys, user))).toList();
    }
    print(users);

    notifyListeners();
  }

  Future<void> deleteUser(User user) async {
    isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 300), () async {
      users.remove(user);
    });
    isLoading = false;
    notifyListeners();
  }
}
