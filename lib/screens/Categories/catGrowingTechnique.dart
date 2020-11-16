import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';


class GrowingTech extends StatelessWidget {
  final String title;
  final String desc;

  GrowingTech({this.title, this.desc});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(title,
        style: TextStyle(
            fontFamily: "Gotik",
            fontWeight: FontWeight.w400,
            color: Color(0xFF1B5E20)),)),
      body: SingleChildScrollView(child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Html(data: desc),
      )),

    );
  }
}
