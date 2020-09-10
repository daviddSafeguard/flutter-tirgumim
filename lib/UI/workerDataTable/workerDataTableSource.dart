import 'package:flutter/material.dart';
import 'package:tirgumim/AppStore/appStore.dart';
import 'package:tirgumim/models/employee.dart';

typedef OnRowSelect = void Function(int index);

class WorkerDataTableSource extends DataTableSource {
  WorkerDataTableSource({
    @required List<Employee> employeeData,
    @required this.onRowSelect,
  })  : _employeeData = employeeData,
        assert(employeeData != null);

  final List<Employee> _employeeData;
  final OnRowSelect onRowSelect;

  @override
  DataRow getRow(int index) {
    assert(index >= 0);

    if (index >= _employeeData.length) {
      return null;
    }
    final _employee = _employeeData[index];

    return DataRow.byIndex(
      index: index, // DONT MISS THIS
      onSelectChanged: (val) {}, //_showMaterialDialog,
      selected: false,
      cells: <DataCell>[
        DataCell(Text('${_employee.id}')),
        DataCell(Text('${_employee.name}')),
        DataCell(Text('${_employee.email}')),
        DataCell(Text('${_employee.phone}')),
        DataCell(Text('${_employee.dateOfBirth}')),
        DataCell(
          IconButton(
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onPressed: () => onRowSelect(index),
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _employeeData.length;

  @override
  int get selectedRowCount => 0;

  /*
   *
   * Sorts this list according to the order specified by the [compare] function.

    The [compare] function must act as a [Comparator].

    List<String> numbers = ['two', 'three', 'four'];
// Sort from shortest to longest.
    numbers.sort((a, b) => a.length.compareTo(b.length));
    print(numbers);  // [two, four, three]
    The default List implementations use [Comparable.compare] if [compare] is omitted.

    List<int> nums = [13, 2, -11];
    nums.sort();
    print(nums);  // [-11, 2, 13] 
   */
  void sort<T>(Comparable<T> Function(Employee d) getField, bool ascending) {
    _employeeData.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });

    notifyListeners();
  }
}
