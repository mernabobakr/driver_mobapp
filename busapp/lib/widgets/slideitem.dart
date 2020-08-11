import 'package:flutter/material.dart';

import '../models/slide.dart';

class SlideItem extends StatelessWidget {
  final Slide slide;

  const SlideItem(this.slide);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Flexible(
            child: Image.asset(
          slide.imageUrl,
          fit: BoxFit.cover,
        )),
        SizedBox(
          height: 40,
        ),
        Flexible(
          child: Text(
            slide.title,
            style: TextStyle(
              fontSize: 22,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Flexible(
          child: Text(
            slide.description,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
