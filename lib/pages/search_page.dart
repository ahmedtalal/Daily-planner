import 'package:daily_planner/components/appbar_widget.dart';
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppbarWidget.getAppBar("search", context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AuthTextInput(
                initialValue: "",
                message: "Search",
                icon: Icons.search,
                onClick: (newValue) {},
                onValidate: (value) {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
