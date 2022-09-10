import 'package:flutter/material.dart';

TextStyle mainStyle(
        {required context, double size = 35, color = Colors.white}) =>
    Theme.of(context)
        .textTheme
        .titleLarge!
        .copyWith(color: color, fontWeight: FontWeight.w300, fontSize: size);
