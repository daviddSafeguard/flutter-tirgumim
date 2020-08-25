import 'package:flutter/material.dart';

class FullTable extends StatefulWidget {
  @override
  _TranslatePageState createState() => _TranslatePageState();
}

class _TranslatePageState extends State<FullTable> {
  TextEditingController _searchQueryController;
  TextEditingController _insertWordController;
  String searchQuery = "";

  Map<int, Map<int, String>> fullTable = {};
  int fullTableRowIndex;
  int fullTableCellIndex;

  TextStyle titleStyle = new TextStyle(fontWeight: FontWeight.bold, color: Colors.black);

  void initState() {
    super.initState();
    _searchQueryController = TextEditingController();
    _insertWordController = TextEditingController();
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchQueryController,
      decoration: InputDecoration(
        hintText: "חפש מילה",
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.white30),
      ),
      style: TextStyle(color: Colors.white, fontSize: 16.0),
      onChanged: (query) => updateSearchQuery(query),
      onSubmitted: (query) => print("can ADD Function here"),
    );
  }

  List<Widget> _buildActions() {
    return <Widget>[
      _searchQueryController == null || _searchQueryController.text.isEmpty
          ? IconButton(
              icon: const Icon(Icons.search),
              onPressed: null,
            )
          : IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _clearSearchQuery();
              },
            )
    ];
  }

  void updateSearchQuery(String newQuery) {
    setState(() {
      searchQuery = newQuery;
    });
  }

  void _clearSearchQuery() {
    _searchQueryController.clear();
    updateSearchQuery("");
  }

  void _startEditMode(int rowIndex, int cellIndex) {
    setState(() {
      _insertWordController.clear();
      fullTableRowIndex = rowIndex;
      fullTableCellIndex = cellIndex;
    });
  }

  void endEdit(int rowIndex, int cellIndex) {
    setState(() {
      fullTable[rowIndex][cellIndex] = _insertWordController.text;
      _insertWordController.clear();
      fullTableRowIndex = null;
      fullTableCellIndex = null;
    });
  }

  List<DataRow> createTable(Map<int, Map<int, String>> currentTable) {
    List<DataRow> trowRows = [];
    for (var rowIndex in currentTable.keys) {
      List<DataCell> cells = [];
      for (var cellIndex = 0; cellIndex < 7; cellIndex++) {
        if (cellIndex == 5) {
          cells.add(DataCell(
            CircleAvatar(
              backgroundImage: NetworkImage('https://picsum.photos/250?image=9'),
            ),
          ));
        } else if (cellIndex == 6) {
          cells.add(DataCell(
            Icon(Icons.delete_outline, color: Colors.red),
            onTap: () => setState(() => currentTable.remove(rowIndex)),
          ));
        } else if (fullTableRowIndex == rowIndex && fullTableRowIndex == cellIndex) {
          if (currentTable[rowIndex].containsKey(cellIndex)) {
            _insertWordController.text = currentTable[rowIndex][cellIndex];
            cells.add(DataCell(TextField(
              controller: _insertWordController,
              autofocus: true,
              onChanged: (query) => currentTable[rowIndex][cellIndex] = query,
              onSubmitted: (query) => endEdit(rowIndex, cellIndex),
            )));
          } else
            cells.add(DataCell(TextField(
              controller: _insertWordController,
              autofocus: true,
              onChanged: (query) => currentTable[rowIndex][cellIndex] = query,
              onSubmitted: (query) => endEdit(rowIndex, cellIndex),
            )));
        } else if (currentTable[rowIndex].containsKey(cellIndex)) {
          cells.add(DataCell(Text(currentTable[rowIndex][cellIndex]), showEditIcon: true, onTap: () => _startEditMode(rowIndex, cellIndex)));
        } else
          cells.add(DataCell(Text("הוסף תרגום"), placeholder: true, showEditIcon: true, onTap: () => _startEditMode(rowIndex, cellIndex)));
      }
      trowRows.add(new DataRow(cells: cells));
    }
    return trowRows;
  }

  Widget buildFullTable(Size screenSize) {
    List<DataRow> trowRows = createTable(fullTable);
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.1),
        child: Row(
          children: [
            Expanded(
              child: DataTable(
                  sortColumnIndex: 1,
                  sortAscending: true,
                  columns: [
                    DataColumn(label: Text('עברית', style: titleStyle)),
                    DataColumn(label: Text('אנגלית', style: titleStyle)),
                    DataColumn(label: Text('סינית', style: titleStyle)),
                    DataColumn(label: Text('ערבית', style: titleStyle)),
                    DataColumn(label: Text('רוסית', style: titleStyle)),
                    DataColumn(label: Text('תמונה', style: titleStyle)),
                    DataColumn(label: SizedBox.shrink())
                  ],
                  rows: trowRows),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: _buildSearchField(),
        actions: _buildActions(),
      ),
      body: buildFullTable(screenSize),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_to_queue),
        onPressed: () {
          fullTableCellIndex = fullTableRowIndex = null;
          setState(() => fullTable[fullTable.length > 0 ? fullTable.keys.last + 1 : 0] = {});
        },
      ),
    );
  }

  void dispose() {
    _searchQueryController.dispose();
    _insertWordController.dispose();
    super.dispose();
  }
}
