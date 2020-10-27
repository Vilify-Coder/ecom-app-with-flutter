// import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../custom_btn.dart';
import '../custom_input.dart';

class registerPage extends StatefulWidget {
  @override
  _registerPageState createState() => _registerPageState();
}

class _registerPageState extends State<registerPage> {
  //default form loading state

  //Form input field values
  //focus node for input fields
  Future<void> _alertDialogBuilder(String error) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text("Error!"),
            content: Container(
              child: Text(error),
            ),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Close!"),
              )
            ],
          );
        });
  }

  //create a new user account
  // String err = "Error";
  Future<String> _createAccount() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _registerEmail, password: _registerPassword);

      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return "Weak Password";
      } else if (e.code == 'email-already-in-use') {
        return "Email Already in Use";
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  //submit form
  void _submitForm() async {
    setState(() {
      _registerFormLoading = true;
    });
    String _createAcountFeedback = await _createAccount();
    // debugPrint("got print");
    // debugPrint(_createAcountFeedback);
    if (_createAcountFeedback != null) {
      _alertDialogBuilder(_createAcountFeedback);
      setState(() {
        _registerFormLoading = false;
      });
    } else {
      //if user login goto home page
      Navigator.pop(context);
      // print("Created Account!");
    }
  }

  bool _registerFormLoading = false;
  String _registerEmail = "";
  String _registerPassword = "";
  FocusNode _passwordFocusNode;
  @override
  void initState() {
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.only(
                top: 24.0,
              ),
              child: Text(
                "Create New Account",
                textAlign: TextAlign.center,
                style: Constants.boldHeading,
              ),
            ),
            Column(
              children: [
                customInput(
                  hintText: "Email ...",
                  onChanged: (value) {
                    _registerEmail = value;
                  },
                  onSubmitted: (value) {
                    _passwordFocusNode.requestFocus();
                  },
                  textInputAction: TextInputAction.next,
                ),
                customInput(
                  hintText: "Password ...",
                  onChanged: (value) {
                    _registerPassword = value;
                  },
                  isPasswodField: true,
                  focusNode: _passwordFocusNode,
                  onSubmitted: (value) {
                    _submitForm();
                  },
                ),
                customButton(
                  text: "Create New Account",
                  onPressed: () {
                    // _alertDialogBuilder();
                    // setState(() {
                    //   _registerFormLoading = true;
                    // });
                    _submitForm();
                  },
                  isLoading: _registerFormLoading,
                ),
              ],
            ),
            Padding(
                padding: const EdgeInsets.only(
              bottom: 16.0,
            )),
            customButton(
              text: "Back To Login",
              onPressed: () {
                Navigator.pop(context);
              },
              outLineBtn: true,
            ),
          ],
        ),
      ),
    ));
  }
}
