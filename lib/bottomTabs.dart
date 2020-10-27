import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class bottomTabs extends StatefulWidget {
  final int selectedTab;
  final Function(int) tabPressed;
  bottomTabs({this.selectedTab, this.tabPressed});
  @override
  _bottomTabsState createState() => _bottomTabsState();
}

class _bottomTabsState extends State<bottomTabs> {
  int _selectedTab = 2;

  @override
  Widget build(BuildContext context) {
    _selectedTab = widget.selectedTab ?? 0;
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.0),
            topRight: Radius.circular(12.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              spreadRadius: 1.0,
              blurRadius: 30.0,
            )
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          bottomTabButton(
            imagePath: "assets/images/tab_home.png",
            selected: _selectedTab == 0 ? true : false,
            onPressed: () {
              widget.tabPressed(0);
            },
          ),
          bottomTabButton(
            imagePath: "assets/images/tab_search.png",
            selected: _selectedTab == 1 ? true : false,
            onPressed: () {
              widget.tabPressed(1);
            },
          ),
          bottomTabButton(
            imagePath: "assets/images/tab_saved.png",
            selected: _selectedTab == 2 ? true : false,
            onPressed: () {
              widget.tabPressed(2);
            },
          ),
          bottomTabButton(
            imagePath: "assets/images/tab_logout.png",
            selected: _selectedTab == 3 ? true : false,
            onPressed: () {
              // widget.tabPressed(3);
              // setState(() {

              // });
              FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
    );
  }
}

class bottomTabButton extends StatelessWidget {
  final String imagePath;
  final bool selected;
  final Function onPressed;

  bottomTabButton({this.imagePath, this.selected, this.onPressed});

  @override
  Widget build(BuildContext context) {
    bool _selected = selected ?? false;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        // child: Text("Hello!"),
        padding: EdgeInsets.symmetric(
          vertical: 28.0,
          horizontal: 16.0,
        ),
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
          color: _selected ? Theme.of(context).accentColor : Colors.transparent,
        ))),
        child: Image(
          image: AssetImage(
            imagePath ?? "assets/images/tab_home.png",
          ),
          width: 22.0,
          height: 22.0,
          color: _selected ? Theme.of(context).accentColor : Colors.black,
        ),
      ),
    );
  }
}
