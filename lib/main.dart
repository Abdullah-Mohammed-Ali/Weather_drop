import 'package:drop_weather/dependency_container.dart';
import 'package:drop_weather/routing/generate_routing.dart';
import 'package:drop_weather/routing/routing_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(500, 250),
      builder: (BuildContext context, Widget? child) {
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: GenerateRouting.onGenerateRouting,
          initialRoute: RoutingNames.home,
        );
      },
    );
  }
}
