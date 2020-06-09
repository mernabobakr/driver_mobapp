import 'package:flutter/material.dart';

class Slide {
  final String imageUrl;
  final String title;
  final String description;

  Slide({
    @required this.imageUrl,
    @required this.title,
    @required this.description,
  });
}

final slideList = [
  Slide(
    imageUrl: 'assets/images/image2.png',
    title: 'Kidzona Driver app',
    description: 'Easy to use and reliable, the app was built for drivers, with drivers.',
  ),
  Slide(
    imageUrl: 'assets/images/image3.png',
    title: 'Monthly payment',
    description: 'Much financial stress? you do not have job?tWe totally understand! We offer you a fixed salary every month. The salary starts from 2500 and up to 5,350 or more depending on the distance of the trip. ',
  ),
  Slide(
    imageUrl: 'assets/images/a-trip-png.png',
    title: 'The same trip every day',
    description: 'You take  the same trip with the same kids every day at the same time, so you can take use the rest of the day for any other business you want.',
  ),
];