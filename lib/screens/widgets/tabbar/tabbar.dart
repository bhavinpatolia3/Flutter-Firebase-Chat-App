import 'package:firebase_notification/theme/color.dart';
import 'package:flutter/material.dart';

class TabButton extends StatelessWidget {
  Icon icon;
  TabButton({this.icon});
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: IconButton(
          icon: icon,
          color: primary_color,
        ),
      ),
    );
  }
}
