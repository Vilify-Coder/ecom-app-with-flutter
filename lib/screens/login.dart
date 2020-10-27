import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:timer/custom_btn.dart';
import 'package:timer/custom_input.dart';
import 'package:timer/screens/registerPage.dart';

import '../constants.dart';

class login extends StatefulWidget {
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
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
  Future<String> _loginAccount() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _loginEmail, password: _loginPassword);

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
      _loginFormLoading = true;
    });
    String _loginAcountFeedback = await _loginAccount();
    // debugPrint("got print");
    // debugPrint(_createAcountFeedback);
    if (_loginAcountFeedback != null) {
      _alertDialogBuilder(_loginAcountFeedback);
      setState(() {
        _loginFormLoading = false;
      });
    }
  }

  bool _loginFormLoading = false;
  String _loginEmail = "";
  String _loginPassword = "";
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
                "Welcome User\n Login to your account",
                textAlign: TextAlign.center,
                style: Constants.boldHeading,
              ),
            ),
            Column(
              children: [
                customInput(
                  hintText: "Email ...",
                  onChanged: (value) {
                    _loginEmail = value;
                  },
                  onSubmitted: (value) {
                    _passwordFocusNode.requestFocus();
                  },
                  textInputAction: TextInputAction.next,
                ),
                customInput(
                  hintText: "Password ...",
                  onChanged: (value) {
                    _loginPassword = value;
                  },
                  isPasswodField: true,
                  focusNode: _passwordFocusNode,
                  onSubmitted: (value) {
                    _submitForm();
                  },
                ),
                customButton(
                  text: "Login",
                  onPressed: () {
                    // _alertDialogBuilder();
                    // setState(() {
                    //   _registerFormLoading = true;
                    // });
                    _submitForm();
                  },
                  isLoading: _loginFormLoading,
                ),
              ],
            ),
            Padding(
                padding: const EdgeInsets.only(
              bottom: 16.0,
            )),
            customButton(
              text: "Create New Account",
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => registerPage()));
              },
              outLineBtn: true,
            ),
          ],
        ),
      ),
    ));
  }
}
