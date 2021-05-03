import 'package:flutter/material.dart';

Widget customDropDown(List<String> items, String value, void onChanged(val)) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 18),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
    ),
    child: DropdownButton<String>(
      value: value,
      onChanged: (String val) {
        onChanged(val);
      },
      items: items?.map<DropdownMenuItem<String>>((String val) {
            return DropdownMenuItem(
              child: Text(val),
              value: val,
            );
          })?.toList() ??
          [],
    ),
  );
}
