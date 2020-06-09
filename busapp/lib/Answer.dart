import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final Function answer;
  final String choice;

  Answer(this.answer, this.choice);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: RaisedButton(
      color: Colors.blue,
      child: Text(this.choice),
      onPressed: this.answer,
    ));
  }
}
