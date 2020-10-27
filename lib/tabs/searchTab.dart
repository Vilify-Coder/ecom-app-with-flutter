import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:timer/constants.dart';
import 'package:timer/widget/cutomActionBar.dart';
import 'package:timer/widget/productCard.dart';

import '../custom_input.dart';

class searchTab extends StatefulWidget {
  @override
  _searchTabState createState() => _searchTabState();
}

class _searchTabState extends State<searchTab> {
  final CollectionReference _productsRef =
      FirebaseFirestore.instance.collection("Products");

  String _searchString = "";

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(
      children: [
        if (_searchString.isEmpty)
          Center(
            child: Container(
                // margin: EdgeInsets.only(150.0),
                child: Text(
              "Search Results",
              style: Constants.regularDarkText,
            )),
          )
        else
          FutureBuilder<QuerySnapshot>(
              future: _productsRef.orderBy("search_string").startAt(
                  [_searchString]).endAt(["$_searchString\uf8ff"]).get(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text(
                        "error: ${snapshot.error}",
                      ),
                    ),
                  );
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  //display data in list view
                  return ListView(
                    padding: EdgeInsets.only(
                      top: 120.0,
                      bottom: 12.0,
                    ),
                    children: snapshot.data.docs.map((document) {
                      return ProductCard(
                        title: document.data()['name'],
                        imageUrl: document.data()['images'][0],
                        price: "\$${document.data()['price']}",
                        productId: document.id,
                      );
                    }).toList(),
                  );
                }
                //Loading State
                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }),
        Padding(
          padding: const EdgeInsets.only(top: 45.0),
          child: customInput(
            hintText: "Search Here...",
            onSubmitted: (value) {
              setState(() {
                _searchString = value.toLowerCase();
              });
            },
          ),
        ),
      ],
    ));
  }
}
