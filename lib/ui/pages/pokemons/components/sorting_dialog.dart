import 'package:flutter/material.dart';
import 'package:pokedex/ui/helpers/sorting/ui_sorting.dart';

void showSortingModal(BuildContext context) {
  showDialog(
      context: context,
      child: SimpleDialog(
        children: [
          Container(
            color: Colors.red,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Sort by:'),
                Container(
                  color: Colors.white,
                  child: Column(
                    children: UISorting.values
                        .map((entry) =>
                            Container(child: Text(entry.description)))
                        .toList(),
                  ),
                )
              ],
            ),
          )
        ],
      ));
}
