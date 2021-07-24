import 'package:cached_network_image/cached_network_image.dart';
import 'package:employee_directory_app/DB_Models/employeeCommonDetails_db_model.dart';
import 'package:employee_directory_app/utils/screen_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmploymentDetailsScreen extends StatefulWidget {
  static const String PAGE = "/employee_details_screen";
  EmployeeCommonDetails employeeDetail;

  EmploymentDetailsScreen({this.employeeDetail});

  @override
  _EmploymentDetailsScreenState createState() =>
      _EmploymentDetailsScreenState();
}

class _EmploymentDetailsScreenState extends State<EmploymentDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    ScreenLayout().init(context);
    return Scaffold(
        backgroundColor: Colors.white, appBar: _appBar(), body: _bodyWidget());
  }

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
          _verticalSpacer(20.0),
          Expanded(child: _viewBody()),
        ],
      );

  Widget _verticalSpacer(double height) => SizedBox(
        height: height,
      );

  Widget _viewBody() {
    return Column(
      children: [
        _buildEmployeeDetailsWidget(),
      ],
    );
  }

  Widget _buildEmployeeDetailsWidget() => widget.employeeDetail != null
      ? Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProfileIcon(),
                  _verticalSpacer(10),
                  _employeeName(),
                  _verticalSpacer(5),
                  widget.employeeDetail.username != null
                      ? _subDetails(
                          "User name: ${widget?.employeeDetail?.username}")
                      : _emptyWidget(),
                  _verticalSpacer(3),
                  widget.employeeDetail.email != null
                      ? _subDetails(
                          "Email Address: ${widget?.employeeDetail?.email}")
                      : _emptyWidget(),
                  _verticalSpacer(3),
                  widget.employeeDetail.street == null &&
                          widget.employeeDetail.suite == null &&
                          widget.employeeDetail.city == null &&
                          widget.employeeDetail.zipcode == null
                      ? _emptyWidget()
                      : _subDetails(
                          "Address: ${widget?.employeeDetail?.street}, ${widget?.employeeDetail?.suite}, ${widget?.employeeDetail?.city}, zipcode: ${widget?.employeeDetail?.zipcode}"),
                  _verticalSpacer(3),
                  widget.employeeDetail.phone != null
                      ? _subDetails("Phone: ${widget?.employeeDetail?.phone}")
                      : _emptyWidget(),
                  _verticalSpacer(3),
                  widget.employeeDetail.website != null
                      ? _subDetails(
                          "Website: ${widget?.employeeDetail?.website}")
                      : _emptyWidget(),
                  _verticalSpacer(8),
                  _subDetails("COMPANY DETAILS"),
                  _verticalSpacer(3),
                  widget.employeeDetail.companyName != null
                      ? _subDetails(
                          "Name: ${widget?.employeeDetail?.companyName}")
                      : _emptyWidget(),
                  _verticalSpacer(3),
                  widget.employeeDetail.companyCatchPhrase != null
                      ? _subDetails(
                          "Catch Phrase: ${widget?.employeeDetail?.companyCatchPhrase}")
                      : _emptyWidget(),
                  _verticalSpacer(3),
                  widget.employeeDetail.companyBs != null
                      ? _subDetails(
                          "Balance Segment: ${widget?.employeeDetail?.companyBs}")
                      : _emptyWidget(),
                ],
              ),
            ),
            decoration: _decorationForContainer(),
          ),
        )
      : Container();

  _emptyWidget() => Container();

  Widget _subDetails(String subDetails) => Text(
        subDetails ?? "",
        style: TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontFamily: "Poppins-Regular",
          fontWeight: FontWeight.w600,
        ),
      );

  Widget _employeeName() => Text(
        widget?.employeeDetail?.name ?? "",
        style: TextStyle(
          color: Colors.black,
          fontSize: 17,
          fontFamily: "Poppins-Regular",
          fontWeight: FontWeight.w600,
        ),
      );

  Widget _buildProfileIcon() => ClipRRect(
        borderRadius: BorderRadius.circular(100.0),
        child: CachedNetworkImage(
          width: ScreenLayout.screenWidth * 0.125,
          imageUrl: widget?.employeeDetail?.profile_image,
          placeholder: (context, url) => CupertinoActivityIndicator(
            animating: true,
            radius: 15,
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      );

  BoxDecoration _decorationForContainer() => BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey[500],
              offset: const Offset(
                1.0,
                1.0,
              ),
              blurRadius: 5.0,
              spreadRadius: 1.0,
            )
          ],
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(4)));

  AppBar _appBar() => AppBar(
        elevation: 1.75,
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Text(
          "",
          style: TextStyle(
            color: Colors.black,
            fontSize: 17,
            fontFamily: "Poppins-Regular",
            fontWeight: FontWeight.w600,
          ),
        ),
      );
}
