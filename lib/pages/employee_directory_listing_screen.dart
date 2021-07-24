import 'package:cached_network_image/cached_network_image.dart';
import 'package:employee_directory_app/DB_Models/employeeCommonDetails_db_model.dart';
import 'package:employee_directory_app/utils/screen_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:employee_directory_app/DAO/employee_directory_dao.dart';

import 'employment_details_screen.dart';

class EmployeeDirectoryListingScreen extends StatefulWidget {
  static const String PAGE = "/employee_directory_listing_screen";

  const EmployeeDirectoryListingScreen({Key key}) : super(key: key);

  @override
  _EmployeeDirectoryListingScreenState createState() =>
      _EmployeeDirectoryListingScreenState();
}

class _EmployeeDirectoryListingScreenState
    extends State<EmployeeDirectoryListingScreen> {
  List<EmployeeCommonDetails> employeeList;
  List<EmployeeCommonDetails> duplicateEmployeeList;
  TextEditingController _searchController = new TextEditingController();
  FocusNode _searchFocusNode;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => callEmployeeDetailsFromLocalDB());
  }

  callEmployeeDetailsFromLocalDB() async {
    employeeList =
        await EmployeeDirectoryDAO.displayEmployeeCommonDetailsFromDb();
    duplicateEmployeeList = employeeList;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    ScreenLayout().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(),
      body: _bodyWidget(),
    );
  }

  AppBar _appBar() => AppBar(
        elevation: 1.75,
        backgroundColor: Colors.white,
        title: Text(
          "Employees",
          style: TextStyle(
            color: Colors.black,
            fontSize: 17,
            fontFamily: "Poppins-Regular",
            fontWeight: FontWeight.w600,
          ),
        ),
      );

  Widget _bodyWidget() => SingleChildScrollView(
        child: Container(
          width: ScreenLayout.screenWidth,
          height: ScreenLayout.screenHeight -
              (MediaQuery.of(context).padding.top + kToolbarHeight),
          child: _bodyDetails(),
        ),
      );

  _bodyDetails() => Column(
        children: [
          _verticalSpacer(15.0),
          Expanded(child: _viewBody()),
        ],
      );

  Widget _viewBody() {
    return Column(
      children: [
        _searchBarTextField(),
        _searchButton(),
        _verticalSpacer(15.0),
        _bodyContent(),
      ],
    );
  }

  Widget _searchButton() => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
              ),
              child: Text(
                'Search',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                _sortingEmployeeList(_searchController.text);
              },
            ),
          ),
        ],
      );

  Widget _bodyContent() => Expanded(
        child: employeeList == null
            ? Center(
                child: CupertinoActivityIndicator(
                animating: true,
                radius: 15,
              ))
            : ListView.builder(
                itemCount: employeeList?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  return employeeList.isEmpty
                      ? _noDataWidget()
                      : _listViewContent(index);
                },
              ),
      );

  Widget _searchBarTextField() => Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0.0),
          border: Border.all(color: Colors.black),
        ),
        child: TextField(
          controller: _searchController,
          focusNode: _searchFocusNode,
          autofocus: false,
          obscureText: false,
          keyboardType: TextInputType.text,
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
              hintText: 'Search Name/Email',
              hintStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 13.0,
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 15.0),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
              )),
          onChanged: (value) {},
          onSubmitted: (value) {},
        ),
      );

  _sortingEmployeeList(String searchContent) {
    if (searchContent.isEmpty) {
      setState(() {
        employeeList = duplicateEmployeeList;
      });
    } else {
      employeeList = [];
      for (int k = 0; k < employeeList.length; k++) {
        if ((searchContent.toLowerCase() ==
                employeeList[k].name.toLowerCase()) ||
            (searchContent.toLowerCase() ==
                employeeList[k].email.toLowerCase())) {
          setState(() {
            employeeList.add(employeeList[k]);
          });
        }
      }
    }
  }

  Widget _listViewContent(int i) => Padding(
        padding: const EdgeInsets.only(bottom: 20.0, left: 20.0, right: 20.0),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EmploymentDetailsScreen(
                        employeeDetail: employeeList[i],
                      )),
            );
          },
          child: Container(
            width: ScreenLayout.screenWidth,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(0)),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProfileIcon(employeeList[i]?.profile_image),
                  _verticalSpacer(5),
                  _employeeName(i),
                  _verticalSpacer(5),
                  _companyNameText(i),
                ],
              ),
            ),
          ),
        ),
      );

  Widget _verticalSpacer(double height) => SizedBox(
        height: height,
      );

  Widget _buildProfileIcon(String profileImage) => ClipRRect(
        borderRadius: BorderRadius.circular(100.0),
        child: CachedNetworkImage(
          width: ScreenLayout.screenWidth * 0.1,
          imageUrl: profileImage,
          placeholder: (context, url) => CupertinoActivityIndicator(
            animating: true,
            radius: 15,
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      );

  Widget _noDataWidget() => Padding(
        padding: const EdgeInsets.only(top: 40.0),
        child: Text(
          "No Data Available!",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontFamily: "Poppins-Regular",
            fontWeight: FontWeight.w500,
          ),
        ),
      );

  Widget _employeeName(int index) => Text(
        employeeList[index]?.name ?? "",
        style: TextStyle(
          color: Colors.black,
          fontSize: 17,
          fontFamily: "Poppins-Regular",
          fontWeight: FontWeight.w600,
        ),
      );

  Widget _companyNameText(int index) => Text(
        "Company: ${employeeList[index]?.companyName ?? ""}",
        style: TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontFamily: "Poppins-Regular",
          fontWeight: FontWeight.w600,
        ),
      );
}
