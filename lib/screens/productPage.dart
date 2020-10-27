import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:timer/constants.dart';
import 'package:timer/services/firebaseServices.dart';
import 'package:timer/widget/cutomActionBar.dart';
import 'package:timer/widget/imageSwipe.dart';
import 'package:timer/widget/productSize.dart';

class productPage extends StatefulWidget {
  final String productId;
  productPage({this.productId});
  @override
  _productPageState createState() => _productPageState();
}

class _productPageState extends State<productPage> {
  // user->userId->cart->productId

  User _user = FirebaseAuth.instance.currentUser;
  String _selectedProductSize = "0";
  Future _addToCart() {
    return FirebaseServices.usersRef
        .doc(_user.uid)
        .collection("cart")
        .doc(widget.productId)
        .set({"size": _selectedProductSize});
  }

  final SnackBar _snackBar =
      SnackBar(content: Text("Product added to the cart!"));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        FutureBuilder(
          future: FirebaseServices.productsRef.doc(widget.productId).get(),
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
              //firebase document data map
              Map<String, dynamic> documentData = snapshot.data.data();
              //list of images
              List imageList = documentData['images'];
              //list of sizes
              List productSize = documentData['size'];
              _selectedProductSize = productSize[0];
              return ListView(
                padding: EdgeInsets.all(0),
                children: [
                  imageSwipe(
                    imageList: imageList,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 24.0,
                      left: 24.0,
                      right: 24.0,
                      bottom: 4.0,
                    ),
                    child: Text(
                      "${documentData['name']}" ?? "Product Name",
                      style: Constants.boldHeading,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4.0,
                      horizontal: 24.0,
                    ),
                    child: Text(
                      "\$${documentData['price']}" ?? "Price",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 24.0,
                    ),
                    child: Text(
                      documentData['desc'] ?? "Description",
                      style: TextStyle(
                        fontSize: 18.0,
                        // color: Theme.of(context).accentColor,
                        // fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 24.0,
                      horizontal: 24.0,
                    ),
                    child: Text(
                      "Select Size",
                      style: Constants.regularDarkText,
                    ),
                  ),
                  productSizes(
                    productSize: productSize,
                    onSelected: (Size) {
                      _selectedProductSize = Size;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Row(
                      children: [
                        Container(
                          width: 65.0,
                          height: 65.0,
                          decoration: BoxDecoration(
                            color: Color(0xffDCDCDC),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          alignment: Alignment.center,
                          child: Image(
                            image: AssetImage("assets/images/tab_saved.png"),
                            // width: 13.0,
                            height: 21.0,
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              await _addToCart();
                              Scaffold.of(context).showSnackBar(_snackBar);
                            },
                            child: Container(
                              height: 65.0,
                              margin: EdgeInsets.only(left: 16.0),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "Add To Cart",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            }
            //Loading State
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
        customActionBar(
          hasBackArrow: true,
          hasTitle: false,
          hasBackGround: false,
        )
      ],
    ));
  }
}
