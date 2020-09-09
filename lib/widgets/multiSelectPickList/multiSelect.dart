import 'dart:ui';

import 'package:flutter/material.dart';
import 'multySelectDialog.dart';

class MultiSelectChip extends FormField<dynamic> {
  final String titleText;
  final String hintText;
  final bool required;
  final bool isEnabled;
  final String errorText;
  final dynamic value;
  final List dataSource;
  final List fullDataSource;
  final String textField;
  final Map<String, Widget> iconsList;
  final String valueField;
  final Function change;
  final Function open;
  final Function close;
  final Widget leading;
  final Widget trailing;
  final String okButtonLabel;
  final String cancelButtonLabel;

  MultiSelectChip(
      {FormFieldSetter<dynamic> onSaved,
      FormFieldValidator<dynamic> validator,
      int initialValue,
      bool autovalidate = false,
      this.titleText = 'Title',
      this.hintText = 'Tap to select one or more',
      this.required = false,
      this.errorText = 'Please select one or more options',
      this.value,
      this.leading,
      this.dataSource,
      this.fullDataSource,
      this.textField,
      this.valueField,
      this.change,
      this.iconsList,
      this.isEnabled = true,
      this.open,
      this.close,
      this.okButtonLabel = 'OK',
      this.cancelButtonLabel = 'CANCEL',
      this.trailing})
      : super(
          onSaved: onSaved,
          validator: validator,
          initialValue: initialValue,
          autovalidate: autovalidate,
          builder: (FormFieldState<dynamic> state) {
            List<Widget> _buildSelectedOptions(dynamic values, state) {
              List<Widget> selectedOptions = [];
              if (values != null) {
                values.forEach((item) {
                  var existingItem;
                  for (var itm in dataSource) {
                    if (item == itm[valueField]) {
                      existingItem = itm;
                    }
                  }
                  if (existingItem == null && fullDataSource != null) {
                    for (var itm in fullDataSource) {
                      if (item == itm[valueField]) {
                        existingItem = itm;
                      }
                    }
                  }
                  //var existingItem = dataSource.singleWhere((itm) => itm[valueField] == item, orElse: () => null);
                  if (existingItem != null) {
                    selectedOptions.add(Chip(
                      backgroundColor: Colors.transparent,
                      shape: StadiumBorder(side: BorderSide(color: Colors.grey[500])),
                      label: Text(
                        existingItem[textField],
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.blue),
                      ),
                    ));
                  }
                });
              }

              return selectedOptions;
            }

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: FilterChip(
                      showCheckmark: value != null && value.length > 0,

                      selected: value != null && value.length > 0,
                      label: new Text(
                        titleText,
                        style: TextStyle(color: value != null && value.length > 0 ? Colors.blue : Colors.blue[300]),
                      ),

                      shape: StadiumBorder(
                          side: BorderSide(
                        color: Colors.blue[300],
                      )),

                      // shape: StadiumBorder(side: BorderSide(color: Colors.blueGrey)),
                      onSelected: (bool bvalue) async {
                        if (isEnabled) {
                          List initialSelected = value;
                          if (initialSelected == null) {
                            initialSelected = List();
                          }

                          final items = List<MultiSelectDialogItem<dynamic>>();
                          dataSource.forEach((item) {
                            items.add(MultiSelectDialogItem(item[valueField], item[textField]));
                          });

                          List selectedValues = await showDialog<List>(
                            context: state.context,
                            builder: (BuildContext context) {
                              // FocusScope.of(context).();

                              return MultiSelectDialog(
                                title: titleText,
                                okButtonLabel: okButtonLabel,
                                cancelButtonLabel: cancelButtonLabel,
                                items: items,
                                initialSelectedValues: initialSelected,
                                iconsList: iconsList,
                              );
                            },
                          );
                          if (change != null) change(selectedValues);
                          if (selectedValues != null) {
                            state.didChange(selectedValues);
                            state.save();
                          }
                        }
                      },
                    ),
                  ),
                  Positioned(
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                      ),
                      width: 20,
                      height: 20,
                      child: Center(
                          child: Text(
                        value != null ? value.length.toString() : '0',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      )),
                    ),
                  )
                ],
              ),
            );

            // InputDecorator(
            //   decoration: InputDecoration(
            //     filled: true,
            //     enabled: isEnabled,
            //     fillColor: Colors.white70,
            //     focusedBorder: OutlineInputBorder(
            //       borderSide: BorderSide(color: Colors.blue, width: 1.5),
            //     ),
            //     enabledBorder: OutlineInputBorder(
            //       borderSide: BorderSide(color: Colors.black54, width: 1.5),
            //     ),
            //     disabledBorder: UnderlineInputBorder(
            //       borderSide: BorderSide(
            //         color: Colors.black54,
            //         width: 0.2,
            //       ),
            //     ),
            //     errorText: state.hasError ? state.errorText : null,
            //     errorMaxLines: 4,
            //   ),
            //   isEmpty: state.value == null || state.value == '',
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: <Widget>[
            //       Padding(
            //         padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
            //         child: Row(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: <Widget>[
            //             Expanded(
            //                 child: Text(
            //               titleText,
            //               style: TextStyle(fontSize: 13.0, color: Colors.black54),
            //             )),
            //             required
            //                 ? Padding(
            //                     padding: EdgeInsets.only(top: 5, right: 5),
            //                     child: Text(
            //                       ' *',
            //                       style: TextStyle(
            //                         color: Colors.red.shade700,
            //                         fontSize: 17.0,
            //                       ),
            //                     ),
            //                   )
            //                 : Container(),
            //             Icon(
            //               Icons.arrow_drop_down,
            //               color: Colors.blue,
            //               size: 25.0,
            //             ),
            //           ],
            //         ),
            //       ),
            //       value != null && value.length > 0
            //           ? Wrap(
            //               spacing: 8.0,
            //               runSpacing: 0.0,
            //               children: _buildSelectedOptions(value, state),
            //             )
            //           : new Container(
            //               padding: EdgeInsets.only(top: 4),
            //               child: Text(
            //                 hintText,
            //                 style: TextStyle(
            //                   fontSize: 16,
            //                   color: Colors.grey.shade500,
            //                 ),
            //               ),
            //             )
            //     ],
            //   ),
            // ),
            //);
          },
        );
}
