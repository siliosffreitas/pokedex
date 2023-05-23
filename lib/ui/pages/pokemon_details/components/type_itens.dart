import 'package:flutter/material.dart';

import 'components.dart';

class TypesItens extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 56),
      height: 20,
      child: Center(
          child: ListView.separated(
        itemCount: 2,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(width: 16),
        itemBuilder: (BuildContext context, int index) => TypeItem(),
      )),
    );
  }
}
