import 'package:flutter/material.dart';
import 'package:tirgumim/UI/serverDataTable/dataTableSource.dart';
import 'package:tirgumim/models/user.dart';

class ServerDataTable extends StatefulWidget {
  @override
  _ServerDataTableState createState() => _ServerDataTableState();
}

class _ServerDataTableState extends State<ServerDataTable> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("טבלת שרת"),
        actions: [
          IconButton(icon: Icon(Icons.support_agent), onPressed: () {}),
          IconButton(icon: Icon(Icons.share), onPressed: () {}),
          IconButton(icon: Icon(Icons.local_laundry_service), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          Row(mainAxisSize: MainAxisSize.min, children: [
            Flexible(
              child: GridView.builder(
                itemCount: 6,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  return new Card(
                    child: new GridTile(
                      footer: new Text('name'),
                      child: new Text('index'),
                    ),
                  );
                },
              ),
            )
          ]),
          PaginatedDataTable(
            columnSpacing: MediaQuery.of(context).size.width / 6,
            showCheckboxColumn: true,
            rowsPerPage: 6,
            header: Center(child: Text("הדר")),
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
                User(id: 3, name: "5", email: "a@a", phone: "1234567890", status: "admin"),
                User(id: 4, name: "6", email: "a@a", phone: "1234567890", status: "admin")
              ],
            ),
          ),
        ],
      ),
    );
  }
}
