import 'package:drop_weather/features/weather/presentation/screens/splash_screen.dart';
import 'package:drop_weather/routing/routing_names.dart';
import 'package:flutter/material.dart';

import '../features/weather/presentation/screens/details_screen.dart';
import '../features/weather/presentation/screens/home_screen.dart';

class GenerateRouting {
  // ignore: body_might_complete_normally_nullable
  static Route? onGenerateRouting(RouteSettings settings) {
    switch (settings.name) {
      case RoutingNames.home:
        return fadeInPageBuilder(const HomeScreen());
      case RoutingNames.details:
        return fadeInPageBuilder(const DetailsScreen());
    }
  }

  static PageRouteBuilder fadeInPageBuilder(
    page, {
    durationMili = 750,
  }) {
    return PageRouteBuilder(
        pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) =>
            page,
        transitionsBuilder: (_, anim, a2, child) =>
            FadeTransition(opacity: anim, child: child),
        transitionDuration: Duration(milliseconds: durationMili));
  }
}
