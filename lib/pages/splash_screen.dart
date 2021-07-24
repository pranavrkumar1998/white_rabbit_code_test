import 'dart:async';
import 'package:employee_directory_app/DAO/employee_directory_dao.dart';
import 'package:employee_directory_app/service/api.dart';
import 'package:employee_directory_app/utils/constants.dart';
import 'package:employee_directory_app/utils/screen_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'employee_directory_listing_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String PAGE = "/splash_screen";

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _callEmployeeDetailsAPI();
  }

  @override
  Widget build(BuildContext context) {
    ScreenLayout().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: _displayAppName()),
            _loadIndicator(),
          ],
        )),
      ),
    );
  }

  Widget _loadIndicator() => Padding(
        padding: const EdgeInsets.only(bottom: 2.0),
        child: CupertinoActivityIndicator(
          animating: true,
          radius: 15,
        ),
      );

  Widget _displayAppName() => Center(
        child: Text(
          Constants.employeeDirectory,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      );

  void _callEmployeeDetailsAPI() async {
    List<dynamic> employeeDetails = await API.getEmployeeDetails();
    if (employeeDetails != null && employeeDetails.isNotEmpty) {
      await EmployeeDirectoryDAO.saveEmployeeDirectoryDetailsToDB(
          employeeDetails);
      await _navigationToEmployeeDirectoryListingScreen();
    }
  }

  _navigationToEmployeeDirectoryListingScreen() async {
    Navigator.pushReplacementNamed(
        context, EmployeeDirectoryListingScreen.PAGE);
  }
}
