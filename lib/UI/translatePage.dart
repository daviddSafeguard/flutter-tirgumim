import 'package:flutter/material.dart';
import 'package:tirgumim/models/tRow.dart';
import 'package:tirgumim/widgets/camera.dart';
import 'package:tirgumim/widgets/selectedChips.dart';

class TranslatePage extends StatefulWidget {
  @override
  _TranslatePageState createState() => _TranslatePageState();
}

class _TranslatePageState extends State<TranslatePage> {
  TextEditingController _searchQueryController;
  TextEditingController _insertWordController;
  String searchQuery = "";

  List<TRow> trows = []; // trowRows view

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

  void _startEditMode(TRow trowTable, int rowIndex, int cellIndex) {
    setState(() {
      _insertWordController.clear();
      trowTable.selectedRow = rowIndex;
      trowTable.selectedcell = cellIndex;
    });
  }

  void endEdit(TRow trowTable, int rowIndex, int cellIndex) {
    setState(() {
      trowTable.trowTable[rowIndex][cellIndex] = _insertWordController.text;
      _insertWordController.clear();
      trowTable.selectedRow = null;
      trowTable.selectedcell = null;
    });
  }

  List<DataRow> createData(TRow tRow) {
    Map<int, Map<int, String>> currentTable = tRow.trowTable;
    List<DataRow> trowRows = [];
    for (var rowIndex in currentTable.keys) {
      List<DataCell> cells = [];
      for (var cellIndex = 0; cellIndex < 6; cellIndex++) {
        if (cellIndex == 5) {
          cells.add(DataCell(
            Icon(Icons.delete_outline, color: Colors.red),
            onTap: () => setState(() => currentTable.remove(rowIndex)),
          ));
        } else if (tRow.selectedRow == rowIndex && tRow.selectedcell == cellIndex) {
          if (currentTable[rowIndex].containsKey(cellIndex)) {
            _insertWordController.text = currentTable[rowIndex][cellIndex];
            cells.add(DataCell(TextField(
              controller: _insertWordController,
              autofocus: true,
              onChanged: (query) => currentTable[rowIndex][cellIndex] = query,
              onSubmitted: (query) => endEdit(tRow, rowIndex, cellIndex),
            )));
          } else
            cells.add(DataCell(TextField(
              controller: _insertWordController,
              autofocus: true,
              onChanged: (query) => currentTable[rowIndex][cellIndex] = query,
              onSubmitted: (query) => endEdit(tRow, rowIndex, cellIndex),
            )));
        } else if (currentTable[rowIndex].containsKey(cellIndex)) {
          cells.add(DataCell(Text(currentTable[rowIndex][cellIndex]), showEditIcon: true, onTap: () => _startEditMode(tRow, rowIndex, cellIndex)));
        } else
          cells.add(DataCell(Text("הוסף תרגום"), placeholder: true, showEditIcon: true, onTap: () => _startEditMode(tRow, rowIndex, cellIndex)));
      }
      trowRows.add(new DataRow(cells: cells));
    }
    return trowRows;
  }

  Widget tRowToRow(TRow tRow, int index, TextStyle titleStyle) {
    List<DataRow> trowRows = createData(tRow);
    return Container(
      color: index.isEven ? Colors.blue[50] : Colors.grey[100],
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Flexible(
            flex: 6,
            child: Camera(
              image: tRow.image ?? null,
              callback: (path) => tRow.image = path,
            ),
          ),
          Flexible(flex: 1, child: Container()),
          Flexible(
            flex: 38,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DataTable(
                    sortColumnIndex: 0,
                    sortAscending: true,
                    columns: [
                      DataColumn(label: Text('עברית', style: titleStyle)),
                      DataColumn(label: Text('אנגלית', style: titleStyle)),
                      DataColumn(label: Text('סינית', style: titleStyle)),
                      DataColumn(label: Text('ערבית', style: titleStyle)),
                      DataColumn(label: Text('רוסית', style: titleStyle)),
                      DataColumn(label: SizedBox.shrink())
                    ],
                    rows: trowRows),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Tooltip(
                      message: "מוסיף שורת מילים לתרגום בטבלה לעיל",
                      child: RaisedButton.icon(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(
                              color: Colors.blue[700],
                            ),
                          ),
                          textColor: Colors.blue[700],
                          icon: Icon(Icons.add),
                          label: Text("הוסף מילה לקבוצה"),
                          onPressed: () {
                            trows.forEach((element) => element.selectedRow = element.selectedcell = null);
                            setState(() => tRow.trowTable[tRow.trowTable.length > 0 ? tRow.trowTable.keys.last + 1 : 0] = {});
                          }),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Tooltip(
                      message: "מוחק את כל טבלת המילים והתמונה הקשורה",
                      child: RaisedButton.icon(
                          color: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          textColor: Colors.white,
                          icon: Icon(Icons.delete),
                          label: Text("מחק קבוצת מילים"),
                          onPressed: () {
                            print(index);
                            print(trows.length);
                            setState(() => trows.removeAt(index));
                          }),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SelectChip(["Safeguard", "Ebuild", "HR", "Quality"], (epic) {
                      tRow.epic = epic;
                    }, pickedValue: tRow.epic ?? "Safeguard"),

                    // RaisedButton.icon(
                    //     color: Colors.white,
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(18.0),
                    //       side: BorderSide(
                    //         color: Colors.purple[300],
                    //       ),
                    //     ),
                    //     textColor: Colors.purple[300],
                    //     icon: Icon(Icons.arrow_drop_down),
                    //     label: Text("סייפגארד"),
                    //     onPressed: () {
                    //       showAlertDialog(context);
                    //     }),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  showAlertDialog(BuildContext context, TRow tRow) {
    // set up the button
    Widget okButton = FlatButton(
        child: Text("שמור"),
        onPressed: () => setState(() {
              tRow.epic = "כח אדם";
              Navigator.of(context).pop();
            }));

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(tRow.epic ?? "סייפגארד"),
      content: Text("This is my message.."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _buildSearchField(),
        actions: _buildActions(),
      ),
      body: ListView.builder(
        itemCount: trows.length,
        itemBuilder: (context, index) {
          return tRowToRow(trows[index], index, titleStyle);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_to_queue),
        onPressed: () {
          trows.forEach((element) => element.selectedRow = element.selectedcell = null);
          setState(() => trows.insert(0, new TRow(trowTable: {})));
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
