import 'package:intl/intl.dart';

DateTime parseJavascriptDateString(String dateString) {
  if (dateString != null) {
    var dList = dateString.split(RegExp(" |:|\\(|\\)"));
    // print(dList);
    var dateTime;
    if(dList.length == 4){
      var dateTime = DateTime(int.parse(dList[3]), _months.indexOf(dList[1]), int.parse(dList[2]));
    }
    else{
      dateTime = DateTime(int.parse(dList[3]), _months.indexOf(dList[1]), int.parse(dList[2]), int.parse(dList[4]), int.parse(dList[5]), int.parse(dList[6]));
    }
    

    // dateTime = dateTime
    //     .subtract(Duration(minutes: (60 * _getTimeZoneOffset(dList[8]).round())));

    return dateTime;
  }
}

DateTime fromRest(String dateString, {versionDate}) {
  if (dateString != null && dateString != "") {
    var dList = dateString.split(RegExp(" |:|\\(|\\)"));
    if (dList.length == 1) dList = dList[0].split("-");
    var dateTime;
    if (dList.length == 8)
      dateTime = DateTime(int.parse(dList[7]), _months.indexOf(dList[1]), int.parse(dList[2]));
    else if (dList.length > 3)
      dateTime = DateTime(int.parse(dList[3]), _months.indexOf(dList[1]), int.parse(dList[2]));
    else
      dateTime = DateTime(int.parse(dList[0]), _months.indexOf(dList[1]), int.parse(dList[2]));
    return dateTime;
  } else
    return null;
}

DateTime fromRestWithTime(String dateString, {versionDate}) {
  if (dateString != null && dateString != "") {
    var dList = dateString.split(RegExp(" |:|\\(|\\)"));
    if (dList.length == 1) dList = dList[0].split("-");
    var dateTime;
    if (dList.length > 5 && dList.contains("IDT")) {
      dateTime = DateTime(int.parse(dList[3]), _months.indexOf(dList[1]), int.parse(dList[2]), int.parse(dList[4]), int.parse(dList[5]));
    } else if (dList.length > 5 && !dList.contains("IDT")) {
      dateTime = DateTime(int.parse(dList[7]), _months.indexOf(dList[1]), int.parse(dList[2]), int.parse(dList[3]), int.parse(dList[4]));
    } else {
      dateTime = DateTime(int.parse(dList[3]), _months.indexOf(dList[1]), int.parse(dList[2]), 0, 0);
    }

    return dateTime;
  } else
    return null;
}

DateTime getDateTimeFromController(String dateString, {versionDate}) {
  if (dateString != null && dateString != "") {
    var dList = dateString.split('-');

    DateTime dateTime = DateTime(int.parse(dList[2]), int.parse(dList[1]), int.parse(dList[0]), 0, 0);

    return dateTime;
  } else
    return null;
}

DateTime getStartDateDayMinus8Hours() {
  DateTime nowDate = new DateTime.now();
  return new DateTime(nowDate.year, nowDate.month, nowDate.day).add(new Duration(hours: -8));
}

String getFullTime(DateTime datetime) {
  int hour = datetime.hour;
  String hourString = "$hour";
  if (hour < 10) hourString = "0$hour";
  int minute = datetime.minute;
  String minuteString = "$minute";
  if (minute < 10) minuteString = "0$minute";
  // int second = datetime.second;
  // String secondString = "$second";
  // if (second < 10) secondString = "0$second";
  return "$hourString:$minuteString"; //:$secondString";
}

String getFullDate(DateTime datetime) {
  if (datetime != null) {
    int year = datetime.year;
    String yearString = "$year";
    // if (year < 10) yearString = "0$year";
    int month = datetime.month;
    String monthString = "$month";
    if (month < 10) monthString = "0$month";
    int day = datetime.day;
    String dayString = "$day";
    if (day < 10) dayString = "0$day";
    return "$yearString-$monthString-$dayString";
  } else
    return "";
}

String getYearMonthDayDate(String datetime) {
  String year;
  String month;
  String day;
  List tryRestTime = datetime.split(' ');
  if (tryRestTime.length == 1) {
    List dayMonthYear = datetime.split('-');
    if (dayMonthYear[0].toString().length == 4) {
      return datetime;
    } // if it is already year-month-day string
    year = dayMonthYear[2];
    month = dayMonthYear[1];
    day = dayMonthYear[0];
  } else {
    Map<String, String> junTo06 = {"Jan": "01", "Feb": "02", "Mar": "03", "Apr": "04", "May": "05", "Jun": "06", "Jul": "07", 'Aug': "08", "Sep": "09", "Oct": '10', 'Nov': "11", "Dec": "12"};
    year = tryRestTime[3];
    month = junTo06[tryRestTime[1]];
    day = tryRestTime[2];
  }
  return "$year-$month-$day";
}

String getYourGodDammTimeBack(String ymd, String time) {
  if (ymd.length > 1) {
    ymd = ymd.split(' ')[0];
    if (ymd.split('-')[0].length == 2) ymd = getYearMonthDayDate(ymd);
    List<String> splitedDate = ymd.split('-');
    List<String> splitedTime = time.split(':');
    var newDate = DateTime(int.parse(splitedDate[0]), int.parse(splitedDate[1]), int.parse(splitedDate[2]), int.parse(splitedTime[0]), int.parse(splitedTime[1]), DateTime.now().second);
    return newDate.toIso8601String();
  } else
    return '';
}

List<String> splitIsoToDateAndTime(String iso) {
  List<String> rightWay = iso.split('T');
  rightWay[1] = rightWay[1].substring(0, 5);
  rightWay[0] = switchFromYMDtoDMY(rightWay[0]);
  print(rightWay);
  return rightWay;
}

String switchFromYMDtoDMY(String ymd) {
  List<String> dmy = ymd.split('-');
  return dmy[2] + '-' + dmy[1] + '-' + dmy[0];
}

String getFullDateSlash(DateTime datetime) {
  try {
    if (datetime != null) {
      int year = datetime.year;
      String yearString = "$year";
      // if (year < 10) yearString = "0$year";
      int month = datetime.month;
      String monthString = "$month";
      if (month < 10) monthString = "0$month";
      int day = datetime.day;
      String dayString = "$day";
      if (day < 10) dayString = "0$day";
      return "$dayString/$monthString/$yearString";
    } else
      return "";
  } catch (e) {
    throw e;
  }
}

String getFullDateAndFullTimeToNameFile({DateTime datetime}) {
  try {
    if (datetime == null) datetime = DateTime.now();
    return "${datetime.year}${datetime.month}${datetime.day}${datetime.hour}${datetime.minute}${datetime.second}";
  } catch (e) {
    throw e;
  }
}

String getFullDateMakaf(DateTime datetime) {
  try {
    if (datetime != null) {
      int year = datetime.year;
      String yearString = "$year";
      int month = datetime.month;
      String monthString = "$month";
      if (month < 10) monthString = "0$month";
      int day = datetime.day;
      String dayString = "$day";
      if (day < 10) dayString = "0$day";
      return "$dayString-$monthString-$yearString";
    } else
      return "";
  } catch (e) {
    throw e;
  }
}

String getElectraGoodMorning(DateTime date) {
  int hour = date.hour;
  if ((hour >= 21 && hour <= 23) || (hour >= 0 && hour <= 5))
    return "לילה טוב";
  else if (hour > 5 && hour <= 12)
    return "בוקר טוב";
  else if (hour > 12 && hour <= 18)
    return "צהריים טובים";
  else
    return "ערב טוב";
}

String getElectraDay(DateTime date) {
  int day = date.weekday;
  switch (day) {
    case 1:
      return "שני";
    case 2:
      return "שלישי";
    case 3:
      return "רביעי";
    case 4:
      return "חמישי";
    case 5:
      return "שישי";
    case 6:
      return "שבת";
    case 7:
      return "ראשון";
    default:
      return "";
  }
}

String getHoursString(DateTime date) {
  String issueDateHour = "";
  String issueDateMin = "";
  if (date != null) {
    issueDateHour = date.hour.toString().length < 2 ? ("0" + date.hour.toString()) : date.hour.toString();
    issueDateMin = date.minute.toString().length < 2 ? ("0" + date.minute.toString()) : date.minute.toString();
  }

  return "$issueDateHour:$issueDateMin";
}

String getDateString(DateTime date) {
  String issueDateYear = "";
  String issueDateMonth = "";
  String issueDateDay = "";
  if (date != null) {
    issueDateYear = date.year.toString();
    issueDateMonth = date.month.toString().length < 2 ? ("0" + date.month.toString()) : date.month.toString();
    issueDateDay = date.day.toString().length < 2 ? ("0" + date.day.toString()) : date.day.toString();
  }

  return "$issueDateDay/$issueDateMonth/$issueDateYear";
}

String dateStrings(String stringFormat) {
//  "Thu Jun 20 2019" Jan = 01,Feb = 02,Mar = 03 Apr = 04 May = 05 Jun = 06 Jul = 07 Aug = 08 Sep = 09 Oct = 10  Nov = 11 Dec = 12

  Map<String, String> junTo06 = {"Jan": "01", "Feb": "02", "Mar": "03", "Apr": "04", "May": "05", "Jun": "06", "Jul": "07", 'Aug': "08", "Sep": "09", "Oct": '10', 'Nov': "11", "Dec": "12"};
  if (stringFormat != "" && stringFormat != null && stringFormat.length > 10) {
    List stringList = stringFormat.split(' ');
    if (stringList[0].length == 3) {
      print(stringList[3] + "-" + junTo06[stringList[1].toString()] + "-" + stringList[2]);
      return (stringList[3] + "-" + junTo06[stringList[1].toString()] + "-" + stringList[2]);
    } else {
      var t = fromRest(stringFormat).toString();
      var p = t.split(' ');
      if (p.length > 1)
        return p[0];
      else {
        return stringFormat;
      }
    }
  } else {
    return stringFormat;
  }
}

String stringToxxxxXxXxFormat(String stringFormat) {
//  "Thu Jun 20 2019" Jan = 01,Feb = 02,Mar = 03 Apr = 04 May = 05 Jun = 06 Jul = 07 Aug = 08 Sep = 09 Oct = 10  Nov = 11 Dec = 12
  if (stringFormat.contains("-")) {
    if (stringFormat.split("-")[2].length > 2) {
      var arr = stringFormat.split("-");
      return [arr[2], arr[1], arr[0]].join("-");
    } else
      return stringFormat;
  }
  Map<String, String> junTo06 = {"Jan": "01", "Feb": "02", "Mar": "03", "Apr": "04", "May": "05", "Jun": "06", "Jul": "07", 'Aug': "08", "Sep": "09", "Oct": '10', 'Nov': "11", "Dec": "12"};
  if (stringFormat != "" && stringFormat != null && stringFormat.length > 10) {
    List stringList = stringFormat.split(' ');
    if (stringList[0].length == 3) {
      print(stringList[3] + "-" + junTo06[stringList[1].toString()] + "-" + stringList[2]);
      return (stringList[3] + "-" + junTo06[stringList[1].toString()] + "-" + stringList[2]);
    } else {
      var t = fromRest(stringFormat).toString();
      var p = t.split(' ');
      if (p.length > 1)
        return p[0];
      else {
        return stringFormat;
      }
    }
  } else {
    return stringFormat;
  }
}

String stringToxxXxXxxxFormat(String stringFormat) {
//  "Thu Jun 20 2019" Jan = 01,Feb = 02,Mar = 03 Apr = 04 May = 05 Jun = 06 Jul = 07 Aug = 08 Sep = 09 Oct = 10  Nov = 11 Dec = 12

  Map<String, String> junTo06 = {"Jan": "01", "Feb": "02", "Mar": "03", "Apr": "04", "May": "05", "Jun": "06", "Jul": "07", 'Aug': "08", "Sep": "09", "Oct": '10', 'Nov': "11", "Dec": "12"};
  if (stringFormat != "" && stringFormat != null && stringFormat.length > 10) {
    List stringList = stringFormat.split(' ');
    if (stringList[0].length == 3) {
      return (stringList[2] + "-" + junTo06[stringList[1].toString()] + "-" + stringList[3]);
    } else {
      var t = fromRest(stringFormat).toString();
      var p = t.split(' ');
      if (p.length > 1)
        return p[0];
      else {
        return stringFormat;
      }
    }
  } else {
    return stringFormat;
  }
}

String stringToxxxXxXxXxxxFormat(String stringFormat) {
  var tempDate;
  if (stringFormat.split("-")[2].length > 2) {
    tempDate = new DateFormat("dd-MM-yyyy", "en_US").parse(stringFormat);
  } else {
    tempDate = new DateFormat("yyyy-MM-dd", "en_US").parse(stringFormat);
  }

  var ddd = (DateFormat('E').format(tempDate));
  var mmm = (DateFormat('MMM').format(tempDate));
  var d = (DateFormat('d').format(tempDate));
  var yyy = (DateFormat('y').format(tempDate));
  if (d.length < 2) {
    d = "0" + d;
  }
  return "" + ddd + " " + mmm + " " + d + " " + yyy;
}

String stringTo_ddd_mmm_dd_yyyy_Format(String stringFormat) {
  var tempDate = new DateFormat("dd-MM-yyyy", "en_US").parse(stringFormat);
  var ddd = (DateFormat('E').format(tempDate));
  var mmm = (DateFormat('MMM').format(tempDate));
  var d = (DateFormat('d').format(tempDate));
  var yyy = (DateFormat('y').format(tempDate));
  if (d.length < 2) {
    d = "0" + d;
  }
  return "" + yyy + "-" + mmm + " " + d + " " + yyy;
}

var _months = [" ", "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
