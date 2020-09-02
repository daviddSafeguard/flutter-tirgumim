import 'package:flutter/material.dart';

class SelectChip extends StatefulWidget {
  final dynamic chips; // map or enum of Chips
  dynamic pickedValue; //map of the picked chips
  final Function valueCallBack; //callBack with the returned value
  SelectChip(this.chips, this.valueCallBack, {this.pickedValue});
  @override
  _SelectChipState createState() => _SelectChipState();
}

class _SelectChipState extends State<SelectChip> {
  List<Widget> chipList;

  @override
  Widget build(BuildContext context) {
    chipList = [];
    for (var value in widget.chips) {
      bool isSelected = widget.pickedValue != null && widget.pickedValue == value;
      chipList.add(FilterChip(
        showCheckmark: false,
        elevation: isSelected ? 5 : 0,

        selected: isSelected ? true : false,
        label: new Text(
          value.toString(),
          style: TextStyle(color: isSelected ? Colors.blue : Colors.blue[300]),
        ),
        //backgroundColor: ColorManager().theme.fillColor,
        shape: StadiumBorder(
            side: BorderSide(
          color: Colors.blue[300],
        )),

        // shape: StadiumBorder(side: BorderSide(color: Colors.blueGrey)),
        onSelected: (bool bvalue) {
          setState(() {
            widget.pickedValue = value;
            widget.valueCallBack(value);
          });
        },
      ));
      chipList.add(SizedBox(width: 10));
    }

    return Wrap(
      direction: Axis.horizontal,
      children: chipList,
    );
  }
}
