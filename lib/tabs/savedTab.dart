import 'package:flutter/material.dart';
import 'package:timer/widget/cutomActionBar.dart';

class savedTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(
      children: [
        Center(
            child: Text(
          "HomePage",
        )),
        customActionBar(
          hasBackArrow: false,
          title: "Saved",
          // hasTitle: false,
        ),
      ],
    ));
  }
}
