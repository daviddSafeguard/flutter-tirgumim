class User {
  int id;
  String name;
  String phone;
  String loginName;
  String personalId;
  String userRole;
  String urlProfilePic;
  String firstName;
  String lastName;
  String email;
  String tokenSafeguard;
  String tokenHRGuard;
  String tokenEQPGuard;
  String tokenQGuard;
  String status;

  static Map<String, String> keys = {
    "OBJECT_NAME": "USER",
    "NAME": "name",
    "LOGIN_NAME": "loginName",
    "PERSONAL_ID": "PersonalID",
    "USER_ROLE": "role",
    "USER_ROLE_CODE": "role%23code",
    "USER_PHONE": "phone",
    "PHOTO_USER": "userProfilePic",
    "FIRST_NAME": "firstName",
    "LAST_NAME": "lastName",
    "EMAIL": "PersonalEmail",
    "TOKEN_EQPGUARD": "tokenEQP",
    "TOKEN_HRGUARD": "tokenHR",
    "TOKEN_QGUARD": "tokenQguard",
    "TOKEN_SAFEGUARD": "tokenSafe",
    "URL_PHOTO_USER": "URLProfilePic",
    "MODEL_USER_PHONE": "phoneModel",
    "STATUS": "NewStatus",
    "OS_USER_PHONE": "phoneSystem"
  };
  User(
      {this.id,
      this.loginName,
      this.name,
      this.personalId,
      this.userRole,
      this.urlProfilePic,
      this.firstName,
      this.lastName,
      this.email,
      this.tokenEQPGuard,
      this.tokenHRGuard,
      this.tokenQGuard,
      this.tokenSafeguard,
      this.phone,
      this.status});
  factory User.fromJson(Map<String, dynamic> json, {String role}) {
    return User(
      id: json['id'],
      name: json[User.keys["NAME"]],
      loginName: json[User.keys["LOGIN_NAME"]],
      personalId: json[User.keys["PERSONAL_ID"]],
      userRole: role != null ? role : json[User.keys["USER_ROLE_CODE"]].toString(),
      urlProfilePic: json[User.keys["URL_PHOTO_USER"]],
      firstName: json[User.keys["FIRST_NAME"]],
      lastName: json[User.keys["LAST_NAME"]],
      email: json[User.keys["EMAIL"]],
      tokenEQPGuard: json[User.keys["TOKEN_EQPGUARD"]],
      tokenHRGuard: json[User.keys["TOKEN_HRGUARD"]],
      tokenQGuard: json[User.keys["TOKEN_QGUARD"]],
      tokenSafeguard: json[User.keys["TOKEN_SAFEGUARD"]],
      phone: json[User.keys["USER_PHONE"]],
      status: json[User.keys["STATUS"]],
    );
  }
}
