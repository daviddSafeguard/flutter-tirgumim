import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tirgumim/AppStore/appStore.dart';
import 'package:tirgumim/UI/workerDataTable/workerDataTableSource.dart';
import 'package:tirgumim/models/employee.dart';
import 'package:tirgumim/widgets/multiSelectPickList/multiSelect.dart';

class WorkerDataTable extends StatefulWidget {
  @override
  _WorkerDataTableState createState() => _WorkerDataTableState();
}

class _WorkerDataTableState extends State<WorkerDataTable> {
  AppStore appStore;

  String selectedWorkers = "", selectedExeptionType = "";
  List<Employee> employees = [];
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
    employees = AppStore.employees;
    return Scaffold(
      appBar: AppBar(
        title: Text("עובדים"),
        actions: [
          IconButton(icon: Icon(Icons.ac_unit), onPressed: () {}),
          IconButton(icon: Icon(Icons.share), onPressed: () {}),
          IconButton(icon: Icon(Icons.local_laundry_service), onPressed: () {}),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
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
                  DataColumn(label: Text("dateOfBirth")),
                  DataColumn(label: SizedBox.shrink()),
                ],
                source: WorkerDataTableSource(
                  onRowSelect: (index) => {},
                  employeeData: selectedWorkers != ""
                      ? employees
                          .where((employee) =>
                              selectedWorkers.contains(employee.id.toString()))
                          .toList()
                      : employees,
                ),
              ),
              if (appStore.isLoading) Center(child: LinearProgressIndicator())
            ]),
          ],
        ),
      ),
    );
  }
}
