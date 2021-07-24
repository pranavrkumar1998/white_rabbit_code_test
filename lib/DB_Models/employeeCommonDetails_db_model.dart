import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

class EmployeeCommonDetails {
  @required
  final int id;
  @required
  final String name;
  @required
  final String username;
  @required
  final String email;
  @required
  final String profile_image;
  @required
  final String street;
  @required
  final String suite;
  @required
  final String city;
  @required
  final String zipcode;
  @required
  final String lat;
  @required
  final String lng;
  @required
  final String phone;
  @required
  final String website;
  @required
  final String companyName;
  @required
  final String companyCatchPhrase;
  @required
  final String companyBs;

  EmployeeCommonDetails(
      {this.id,
      this.name,
      this.username,
      this.email,
      this.profile_image,
      this.street,
      this.suite,
      this.city,
      this.zipcode,
      this.lat,
      this.lng,
      this.phone,
      this.website,
      this.companyName,
      this.companyCatchPhrase,
      this.companyBs});

  EmployeeCommonDetails.fromDb(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'],
        username = map['username'],
        email = map['email'],
        profile_image = map['profile_image'],
        street = map['street'],
        suite = map['suite'],
        city = map['city'],
        zipcode = map['zipcode'],
        lat = map['lat'],
        lng = map['lng'],
        phone = map['phone'],
        website = map['website'],
        companyName = map['companyName'],
        companyCatchPhrase = map['companyCatchPhrase'],
        companyBs = map['companyBs'];

  Map<String, dynamic> toMapForDb() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['name'] = name;
    map['username'] = username;
    map['email'] = email;
    map['profile_image'] = profile_image;
    map['street'] = street;
    map['suite'] = suite;
    map['city'] = city;
    map['zipcode'] = zipcode;
    map['lat'] = lat;
    map['lng'] = lng;
    map['phone'] = phone;
    map['website'] = website;
    map['companyName'] = companyName;
    map['companyCatchPhrase'] = companyCatchPhrase;
    map['companyBs'] = companyBs;
    return map;
  }

  EmployeeCommonDetails.random(
    int id,
    String name,
    String username,
    String email,
    String profile_image,
    String street,
    String suite,
    String city,
    String zipcode,
    String lat,
    String lng,
    String phone,
    String website,
    String companyName,
    String companyCatchPhrase,
    String companyBs,
  )   : this.id = id,
        this.name = name,
        this.username = username,
        this.email = email,
        this.profile_image = profile_image,
        this.street = street,
        this.suite = suite,
        this.city = city,
        this.zipcode = zipcode,
        this.lat = lat,
        this.lng = lng,
        this.phone = phone,
        this.website = website,
        this.companyName = companyName,
        this.companyCatchPhrase = companyCatchPhrase,
        this.companyBs = companyBs;
}
