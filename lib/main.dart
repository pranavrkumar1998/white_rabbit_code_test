import 'package:employee_directory_app/pages/employee_directory_listing_screen.dart';
import 'package:employee_directory_app/pages/employment_details_screen.dart';
import 'package:employee_directory_app/pages/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: SplashScreen.PAGE,
      routes: {
        SplashScreen.PAGE: (BuildContext context) => SplashScreen(),
        EmployeeDirectoryListingScreen.PAGE: (BuildContext context) =>
            EmployeeDirectoryListingScreen(),
        EmploymentDetailsScreen.PAGE: (BuildContext context) =>
            EmploymentDetailsScreen(),
      },
    );
  }
}
