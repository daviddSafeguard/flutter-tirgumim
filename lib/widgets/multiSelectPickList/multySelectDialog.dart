import 'package:flutter/material.dart';

class MultiSelectDialogItem<V> {
  const MultiSelectDialogItem(this.value, this.label);

  final V value;
  final String label;
}

class MultiSelectDialog<V> extends StatefulWidget {
  MultiSelectDialog({Key key, this.items, this.initialSelectedValues, this.title, this.okButtonLabel, this.cancelButtonLabel, this.iconsList}) : super(key: key);

  final List<MultiSelectDialogItem<V>> items;
  final List<V> initialSelectedValues;
  final String title;
  final String okButtonLabel;
  final String cancelButtonLabel;
  final Map<V, Widget> iconsList;

  @override
  State<StatefulWidget> createState() => _MultiSelectDialogState<V>();
}

class _MultiSelectDialogState<V> extends State<MultiSelectDialog<V>> {
  final _selectedValues = List<V>();
  List<MultiSelectDialogItem<V>> tempItems;

  void initState() {
    tempItems = widget.items;
    if (widget.initialSelectedValues != null) {
      _selectedValues.addAll(widget.initialSelectedValues);
    }
    super.initState();
  }

  void _onItemCheckedChange(V itemValue, bool checked) {
    setState(() {
      if (checked) {
        _selectedValues.add(itemValue);
      } else {
        _selectedValues.remove(itemValue);
      }
    });
  }

  void _onCancelTap() {
    Navigator.pop(context);
  }

  void _onSubmitTap() {
    Navigator.pop(context, _selectedValues);
  }

  void filterSearch(String query) {
    setState(() {
      tempItems = widget.items.where((value) => value.label.toLowerCase().contains(query.toLowerCase())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedValues.clear();
                      _selectedValues.addAll(widget.items.map((f) => f.value));
                    });
                  },
                  child: Text(
                    "בחר הכל",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Colors.blue, height: 1.1),
                  )),
              GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedValues.clear();
                    });
                  },
                  child: Text('נקה הכל', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Colors.blue, height: 1.1)))
            ],
          ),
          TextField(
              onChanged: (value) {
                filterSearch(value);
                print('value :' + value);
              },
              decoration: InputDecoration(suffixIcon: Icon(Icons.search, color: Colors.blue, size: 25.0), hintText: widget.title, hintStyle: TextStyle(color: Colors.grey))),
        ],
      ),
      //Text(widget.title),
      contentPadding: EdgeInsets.only(top: 12.0),
      content: SingleChildScrollView(
        child: ListTileTheme(
          contentPadding: EdgeInsets.fromLTRB(14.0, 0.0, 24.0, 0.0),
          child: ListBody(
            children: tempItems.map(_buildItem).toList(),
          ),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(widget.cancelButtonLabel),
          onPressed: _onCancelTap,
        ),
        FlatButton(
          child: Text(widget.okButtonLabel),
          onPressed: _onSubmitTap,
        )
      ],
    );
  }

  Widget _buildItem(MultiSelectDialogItem<V> item) {
    final checked = _selectedValues.contains(item.value);
    return CheckboxListTile(
      value: checked,
      secondary: widget.iconsList != null ? widget.iconsList[item.value.toString()] : null,
      title: Text(item.label),
      controlAffinity: ListTileControlAffinity.trailing,
      onChanged: (checked) => _onItemCheckedChange(item.value, checked),
    );
  }
}
