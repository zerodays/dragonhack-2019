import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'camera_view.dart';
import 'main_page.dart';
import 'package:flutter/services.dart';
import 'util/colors.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
    statusBarColor: Colors.transparent, //or set color with: Color(0xFF0000FF)
  ));
  allCameras = await availableCameras();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    bool dark = true;

    return MaterialApp(
      title: 'DragonHack 2019',
      theme: dark
          ? ThemeData(
              primaryColor: AppColors.primary,
              accentColor: AppColors.primary,
              brightness: Brightness.dark,
              backgroundColor: AppColors.bcgColor,
              bottomAppBarColor: AppColors.bcgColor,
              appBarTheme: AppBarTheme(
                  color: AppColors.bcgColor, brightness: Brightness.dark),
              scaffoldBackgroundColor: AppColors.bcgColor,
              canvasColor: AppColors.bcgColor,
              cardColor: AppColors.cardColor,
            )
          : ThemeData(
              brightness: Brightness.light,
              primaryColor: Colors.green,
              accentColor: Colors.teal),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
