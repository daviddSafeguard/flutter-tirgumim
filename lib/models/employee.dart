import 'package:tirgumim/utilz/coolFuncs.dart';
import 'package:tirgumim/utilz/timezone.dart';

class Employee {
  int id;
  String name;
  String workerId;
  String wImageURL;
  int contractor;
  int dailyCheckRel;
  Map<String, List<dynamic>> certificationsRelations = {};
  bool isAllowAllSites;
  bool inAnyVision;
  bool isHoursAlert;
  bool isEmployeePhotoUpload;
  String urlWorkerId;
  DateTime dateOfBirth;
  String citizenship;
  String email;
  String isReq;
  String lastName;
  String firstName;
  String phone;
  String workerLocIds;
  String checkCode;
  String insideNum;
  String workerType;
  Employee(
      {this.id,
      this.name,
      this.workerId,
      this.wImageURL,
      this.contractor,
      this.dailyCheckRel,
      this.isAllowAllSites = true,
      this.inAnyVision = false,
      this.isHoursAlert = false,
      this.isEmployeePhotoUpload = false,
      this.urlWorkerId,
      this.dateOfBirth,
      this.citizenship,
      this.email,
      this.isReq,
      this.firstName,
      this.lastName,
      this.phone,
      this.certificationsRelations,
      this.workerLocIds,
      this.checkCode,
      this.insideNum,
      this.workerType});

  static Map<dynamic, String> keys = {
    "OBJECT_NAME": "WorkerObject",
    "NAME": "name",
    "WORKER_ID": "WorkerId",
    "PHOTO_WORKER_URL": "URL_photoWorker",
    "CONTRACTOR_REL": "R297223653",
    "DAILY_CHECK_REL": "R681922987",
    "FIRST_NAME": "firstName",
    "LAST_NAME": "lastName",
    "PHONE": "phone",
    "DATE_OF_BIRTH": "DateOfBirth",
    "IS_ALLOW": "cbAllow",
    "IS_IN_ANYVISION": "inAnyVision",
    "IS_HOURS_ALERT": "cbAlert",
    "IS_EMPLOYEE_PHOTO_UPLOAD": "cbWPhoto",
    "CITIZENSHIP": "Citizenship",
    "EMAIL": "email",
    "LOCATIONS_TEXT_AREA": "IdWL",
    "REPORT_HE": "WoFileHeb",
    "REPORT_ENG": "WoFileEng",
    "REPORT_CHI": "WoFileChi",
    "CHECK_RESPONSE_STATUS_PICKLIST": "dayCheck",
    "CHECK_RESPONSE_STATUS_CODE_PICKLIST": "dayCheck%23code",
    "INSIDE_NUM": "insideNum",
    "WORKER_TYPE": "workerType",
  };

  factory Employee.fromJson(Map<String, dynamic> json) {
    Map<String, List<dynamic>> certificationsRelationsTemp = {};
    certificationsRelationsTemp.putIfAbsent('R320336539', () => json['R320336539']);
    return Employee(
      id: json['id'],
      name: json[Employee.keys["NAME"]],
      workerId: json[Employee.keys["WORKER_ID"]],
      wImageURL: json[Employee.keys["PHOTO_WORKER_URL"]],
      contractor: json[Employee.keys["CONTRACTOR_REL"]],
      dailyCheckRel: json[Employee.keys["DAILY_CHECK_REL"]],
      firstName: json[Employee.keys["FIRST_NAME"]],
      lastName: json[Employee.keys["LAST_NAME"]],
      dateOfBirth: fromRest(json[Employee.keys["DATE_OF_BIRTH"]]),
      phone: json[Employee.keys["PHONE"]],
      isAllowAllSites: CoolFuncs.getBoolFromInt(json[Employee.keys["IS_ALLOW"]]),
      isEmployeePhotoUpload: CoolFuncs.getBoolFromInt(json[Employee.keys["IS_EMPLOYEE_PHOTO_UPLOAD"]]),
      inAnyVision: CoolFuncs.getBoolFromInt(json[Employee.keys["IS_IN_ANYVISION"]]),
      citizenship: json[Employee.keys["CITIZENSHIP"]] != null ? json[Employee.keys["CITIZENSHIP"]].toString() : null,
      email: json[Employee.keys["EMAIL"]],
      isHoursAlert: CoolFuncs.getBoolFromInt(json[Employee.keys["IS_HOURS_ALERT"]]),
      certificationsRelations: certificationsRelationsTemp,
      workerLocIds: json[Employee.keys["LOCATIONS_TEXT_AREA"]],
      checkCode:
          json[Employee.keys["CHECK_RESPONSE_STATUS_CODE_PICKLIST"]] != null ? json[Employee.keys["CHECK_RESPONSE_STATUS_CODE_PICKLIST"]] : json[Employee.keys["CHECK_RESPONSE_STATUS_PICKLIST"]],
      insideNum: json[Employee.keys["INSIDE_NUM"]],
      workerType: json[Employee.keys["WORKER_TYPE"]] != null ? json[Employee.keys["WORKER_TYPE"]].toString() : null,
    );
  }
}
