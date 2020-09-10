import 'dart:html';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tirgumim/AppStore/appStore.dart';
import 'package:tirgumim/models/employee.dart';

class AddNewWorker extends StatefulWidget {
  AddNewWorker(this.employee, {Key key}) : super(key: key);
  Employee employee;

  @override
  _AddNewWorkerState createState() => _AddNewWorkerState();
}

class _AddNewWorkerState extends State<AddNewWorker> {
  AppStore appStore;

  bool isInit = true;

  @override
  void didChangeDependencies() {
    appStore = Provider.of<AppStore>(context);
    if (isInit) {
      isInit = false;
    }
    super.didChangeDependencies();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: () => Navigator.of(context).pop(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(widget.employee.id.toString()),
              Text(widget.employee.name.toString()),
              Text(widget.employee.contractor.toString()),
              Text(widget.employee.phone.toString()),
              FlatButton(color: Colors.blue, textColor: Colors.white, onPressed: () async => appStore.updateEmployee(widget.employee, {}), child: Text("שמור"))
            ],
          ),
        ),
      ),
    );
  }
}
