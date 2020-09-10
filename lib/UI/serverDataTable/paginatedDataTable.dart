import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tirgumim/AppStore/appStore.dart';
import 'package:tirgumim/UI/serverDataTable/dataTableSource.dart';
import 'package:tirgumim/models/user.dart';
import 'package:tirgumim/widgets/graphs/donat.dart';
import 'package:tirgumim/widgets/multiSelectPickList/multiSelect.dart';

class ServerDataTable extends StatefulWidget {
  @override
  _ServerDataTableState createState() => _ServerDataTableState();
}

class _ServerDataTableState extends State<ServerDataTable> {
  AppStore appStore;

  String selectedWorkers = "", selectedExeptionType = "";
  List<User> users = [];
  bool isInit = true;

  @override
  void didChangeDependencies() {
    appStore = Provider.of<AppStore>(context);
    if (isInit) {
      isInit = false;
      appStore.getAllUsers();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    appStore = Provider.of<AppStore>(context);
    users = AppStore.users;
    return Scaffold(
        appBar: AppBar(
          title: Text("טבלת שרת"),
          actions: [
            IconButton(icon: Icon(Icons.ac_unit), onPressed: () {}),
            IconButton(icon: Icon(Icons.share), onPressed: () {}),
            IconButton(
                icon: Icon(Icons.local_laundry_service), onPressed: () {}),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.02,
              ),
              Expanded(
                child: Row(children: [
                  Flexible(
                    flex: 3,
                    child: Padding(
                      padding: EdgeInsets.all(size.width * 0.01),
                      child: GridView.builder(
                        itemCount: 8,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4),
                        itemBuilder: (BuildContext context, int index) {
                          return new Card(
                            child: new GridTile(
                              footer: new Text('name'),
                              child: new Text('index'),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 5,
                    child: Padding(
                        padding: EdgeInsets.all(size.width * 0.01),
                        child: Row(
                          children: [
                            PieChartSample2(),
                            PieChartSample2(),
                            PieChartSample2(),
                          ],
                        )),
                  )
                ]),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Stack(children: [
                PaginatedDataTable(
                  columnSpacing: (MediaQuery.of(context).size.width - 16) / 6,
                  showCheckboxColumn: true,
                  rowsPerPage: 4,
                  header: Row(children: [
                    MultiSelectChip(
                      change: (val) {
                        //if (val.length > 0) selectedWorkers = "";
                      },
                      autovalidate: false,
                      titleText: "עובדים",
                      dataSource: [
                        {"display": "כל העובדים", "value": "123"},
                        {"display": "עובדים פעילים", "value": "456"},
                        {"display": "עובדים לא פעילים", "value": "789"},
                        {"display": "בלתי מורשים", "value": "101"}
                      ],
                      textField: 'display',
                      valueField: 'value',
                      okButtonLabel: 'OK',
                      cancelButtonLabel: 'Cancel',
                      value: selectedWorkers != ""
                          ? selectedWorkers.split(',')
                          : null,
                      hintText: 'Select your Options',
                      onSaved: (value) {
                        if (value.length == 0) selectedExeptionType = "";
                        setState(() {
                          selectedWorkers = value.join(',');
                        });
                      },
                    ),
                    if (selectedWorkers != "")
                      MultiSelectChip(
                        change: (val) {},
                        autovalidate: false,
                        titleText: "סוג חריגה",
                        dataSource: [
                          {"display": "אישור עבודה בגובה", "value": "111"},
                          {"display": "אשרת עבודה", "value": "222"},
                          {"display": "אשרת שהייה", "value": "333"},
                          {"display": "הסמכת אתת", "value": "444"},
                          {"display": "רשיון מפעיל עגורן", "value": "555"},
                          {"display": "רשיון נהיגה", "value": "666"}
                        ],
                        textField: 'display',
                        valueField: 'value',
                        okButtonLabel: 'OK',
                        cancelButtonLabel: 'Cancel',
                        value: selectedExeptionType != ""
                            ? selectedExeptionType.split(',')
                            : null,
                        hintText: 'Select your Options',
                        onSaved: (value) {
                          if (value != null) {
                            setState(() {
                              selectedExeptionType = value.join(',');
                            });
                          }
                        },
                      ),
                  ]),
                  columns: [
                    DataColumn(label: Text("id")),
                    DataColumn(label: Text("name")),
                    DataColumn(label: Text("email")),
                    DataColumn(label: Text("phone")),
                    DataColumn(label: Text("status")),
                    DataColumn(label: SizedBox.shrink()),
                  ],
                  source: UserDataTableSource(
                    onRowSelect: (index) => appStore.deleteUser(users[index]),
                    userData: selectedWorkers != ""
                        ? users
                            .where((user) =>
                                selectedWorkers.contains(user.id.toString()))
                            .toList()
                        : users,
                  ),
                ),
                if (appStore.isLoading) Center(child: LinearProgressIndicator())
              ]),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add_call),
          onPressed: () {
            //_navigateToSecondPage(context);
          },
        ));
  }
}
