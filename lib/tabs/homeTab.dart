import 'package:flutter/material.dart';
import 'package:timer/constants.dart';
import 'package:timer/screens/productPage.dart';
import 'package:timer/widget/cutomActionBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timer/widget/productCard.dart';

// ignore: camel_case_types
class homeTab extends StatelessWidget {
  final CollectionReference _productsRef =
      FirebaseFirestore.instance.collection("Products");
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(
      children: [
        FutureBuilder<QuerySnapshot>(
            future: _productsRef.get(),
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
                    top: 100.0,
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
        customActionBar(
          hasBackArrow: false,
          title: "Home",
          // hasTitle: false,
        ),
      ],
    ));
  }
}
