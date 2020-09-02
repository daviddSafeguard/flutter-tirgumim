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
        title: Center(child: Text("טבלת שרת")),
      ),
      body: PaginatedDataTable(
        columnSpacing: MediaQuery.of(context).size.width / 6,
        showCheckboxColumn: true,
        rowsPerPage: 2,
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
            User(
                id: 1,
                name: "1",
                email: "a@a",
                phone: "1234567890",
                status: "admin"),
            User(
                id: 2,
                name: "2",
                email: "a@a",
                phone: "1234567890",
                status: "admin"),
            User(
                id: 3,
                name: "3",
                email: "a@a",
                phone: "1234567890",
                status: "admin"),
            User(
                id: 4,
                name: "4",
                email: "a@a",
                phone: "1234567890",
                status: "admin")
          ],
        ),
      ),
    );
  }
}
