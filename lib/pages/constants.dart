import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

const String splash1 = "assets/images/splash1.png";
const String splash2 = "assets/images/splash2.jpg";
const String appFont_1 = "tit";
const String appFont1 = "sourceSans";
const String descriptionSplash =
    "A daily planner app is an app that helps you get organized and keeps all of your daily tasks";
const Color appColor = Color.fromRGBO(129, 225, 162, 1);
const Color homeColor = Color.fromRGBO(252, 194, 117, 1);
const Color borderColor = Color.fromRGBO(244, 122, 122, 1);
const Color addColor = Color.fromRGBO(2, 151, 154, 1);
const Color todoColor = Color.fromRGBO(238, 75, 110, 1);
const Color doneColor = Color.fromRGBO(115, 111, 232, 1);
const Color onprogressColor = Color.fromRGBO(252, 194, 117, 1);

const String userImage = "assets/images/user.png";
const String logoutImage = "assets/images/logout.png";
const String rateAppImage = "assets/images/rate.png";
const String shareAppImage = "assets/images/share.png";
const String changePassword = "assets/images/changepassword.png";
const String editImage = "assets/images/edit.png";
const String listIcon = "assets/images/listIcon.png";
const String emptyData = "assets/images/emptysearch.png";

void snackbarValidate(String s, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        s,
        style: TextStyle(
          fontFamily: appFont1,
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      backgroundColor: Colors.grey[200],
    ),
  );
}

String _url =
    "https://play.google.com/store/apps/details?id=com.example.online_booking_places&referrer=utm_source%3Dgoogle";
shared(String message, BuildContext context) {
  final RenderBox box = context.findRenderObject() as RenderBox;
  Share.share("${message + "the app link on google play : " + _url}",
      sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
}

launchUrl() async {
  if (await canLaunch(_url)) {
    await launch(_url);
  } else {
    throw "could not launch $_url";
  }
}
