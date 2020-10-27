import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:timer/bottomTabs.dart';
import 'package:timer/constants.dart';
import 'package:timer/tabs/homeTab.dart';
import 'package:timer/tabs/savedTab.dart';
import 'package:timer/tabs/searchTab.dart';

class homePage extends StatefulWidget {
  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  PageController _tabsPageController;
  int _selectedTab = 0;
  // int tabPressed = 0;
  @override
  void initState() {
    _tabsPageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _tabsPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: PageView(
            controller: _tabsPageController,
            onPageChanged: (num) {
              setState(() {
                _selectedTab = num;
              });
            },
            children: [
              homeTab(),
              searchTab(),
              savedTab(),
            ],
          )),
          bottomTabs(
            selectedTab: _selectedTab,
            tabPressed: (num) {
              _tabsPageController.animateToPage(num,
                  duration: Duration(microseconds: 300),
                  curve: Curves.easeOutCubic);
            },
          ),
        ],
      ),
    );
  }
}
