import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:timer/constants.dart';
import 'package:timer/screens/homePage.dart';
import 'package:timer/screens/login.dart';

class landingPage extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text(
                "error",
              ),
            ),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          //stream builder to check login state
          return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, streamSnapshot) {
              if (streamSnapshot.hasError) {
                return Scaffold(
                  appBar: AppBar(
                    title: Text("dropDown"),
                  ),
                  body: Center(
                    child: Text(
                      "error",
                      style: Constants.regularHeading,
                    ),
                  ),
                );
              }
              //check for state
              if (streamSnapshot.connectionState == ConnectionState.active) {
                //check for loggedin
                User _user = streamSnapshot.data;
                if (_user == null) {
                  return login();
                } else {
                  return homePage();
                }
              }
              return Scaffold(
                appBar: AppBar(
                  title: Text("dropDown"),
                ),
                body: Center(
                  child: Text(
                    "checking auth state Loading",
                    style: Constants.regularHeading,
                  ),
                ),
              );
            },
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Scaffold(
          appBar: AppBar(
            title: Text("dropDown"),
          ),
          body: Center(
            child: Text(
              "Loading",
            ),
          ),
        );
      },
    );
  }
}
