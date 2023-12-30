import 'package:flutter/material.dart';
import 'package:news_app/config/config.dart';

class AppName extends StatelessWidget {
  final double fontSize;

  const AppName({Key? key, required this.fontSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: Config().appName, //first part
        style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: fontSize,
            fontWeight: FontWeight.w900,
            color: Colors.grey[800]),
      ),
    );
  }
}
