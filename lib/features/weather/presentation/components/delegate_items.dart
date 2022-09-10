import 'package:flutter/material.dart';

import '../../../../const/styles.dart';

class CityName extends StatelessWidget {
  CityName({
    Key? key,
    required this.percentage,
    this.left = 20,
    this.top = 50,
    required this.city,
  }) : super(key: key);

  final double percentage;
  final String city;
  double top;
  double left;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: top,
        left: left,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 100),
          opacity: percentage,
          child: Text(city, style: mainStyle(context: context)),
        ));
  }
}

class TempTitle extends StatelessWidget {
  const TempTitle({
    Key? key,
    required this.temp,
  }) : super(key: key);
  final String temp;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 20,
      child: Text(
        temp,
        style: mainStyle(context: context),
      ),
    );
  }
}
