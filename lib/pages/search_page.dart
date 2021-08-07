import 'package:daily_planner/components/auth_text_input.dart';
import 'package:daily_planner/components/switch_pages.dart';
import 'package:daily_planner/pages/constants.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: size.height * 0.29,
              decoration: BoxDecoration(
                color: homeColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(35.0),
                  bottomRight: Radius.circular(35.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    SwitchPages(
                      title: "search",
                      onClick: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    SizedBox(
                      height: 18.0,
                    ),
                    AuthTextInput(
                      message: "Search",
                      icon: Icons.search,
                      onClick: (newValue) {},
                      onValidate: (value) {},
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
