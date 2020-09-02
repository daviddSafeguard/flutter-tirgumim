import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:tirgumim/UI/serverDataTable/dataTableSource.dart';
import 'package:tirgumim/models/user.dart';

class ServerDataTable extends StatefulWidget {
  @override
  _ServerDataTableState createState() => _ServerDataTableState();
}

class _ServerDataTableState extends State<ServerDataTable> {
  Map<String, bool> selectedFilters = {"workers": false};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("טבלת שרת"),
        actions: [
          IconButton(icon: Icon(Icons.ac_unit), onPressed: () {}),
          IconButton(icon: Icon(Icons.share), onPressed: () {}),
          IconButton(icon: Icon(Icons.local_laundry_service), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Row(children: [
              Flexible(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    itemCount: 12,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 6),
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
              Flexible(flex: 3, child: Container())
            ]),
          ),
          PaginatedDataTable(
            columnSpacing: MediaQuery.of(context).size.width / 6,
            showCheckboxColumn: selectedFilters["workers"],
            rowsPerPage: 4,
            header: Row(children: [
              FilterChip(
                showCheckmark: selectedFilters["workers"],

                selected: selectedFilters["workers"],
                label: new Text(
                  "עובדים",
                  style: TextStyle(color: selectedFilters["workers"] ? Colors.blue : Colors.blue[300]),
                ),

                shape: StadiumBorder(
                    side: BorderSide(
                  color: Colors.blue[300],
                )),

                // shape: StadiumBorder(side: BorderSide(color: Colors.blueGrey)),
                onSelected: (bool bvalue) {
                  setState(() {
                    selectedFilters["workers"] = !selectedFilters["workers"];
                  });
                },
              )
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
              onRowSelect: (index) => print(index),
              userData: [
                User(id: 1, name: "1", email: "a@a", phone: "1234567890", status: "admin"),
                User(id: 2, name: "2", email: "a@a", phone: "1234567890", status: "admin"),
                User(id: 3, name: "3", email: "a@a", phone: "1234567890", status: "admin"),
                User(id: 4, name: "4", email: "a@a", phone: "1234567890", status: "admin"),
                User(id: 5, name: "5", email: "a@a", phone: "1234567890", status: "admin"),
                User(id: 6, name: "6", email: "a@a", phone: "1234567890", status: "admin"),
                User(id: 7, name: "7", email: "a@a", phone: "1234567890", status: "admin"),
                User(id: 8, name: "8", email: "a@a", phone: "1234567890", status: "admin"),
                User(id: 9, name: "9", email: "a@a", phone: "1234567890", status: "admin"),
                User(id: 10, name: "10", email: "a@a", phone: "1234567890", status: "admin"),
                User(id: 11, name: "11", email: "a@a", phone: "1234567890", status: "admin"),
                User(id: 12, name: "12", email: "a@a", phone: "1234567890", status: "admin")
              ],
            ),
          ),
        ],
      ),
    );
  }
}
