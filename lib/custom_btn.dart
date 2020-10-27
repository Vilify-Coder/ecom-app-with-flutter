import 'package:flutter/material.dart';
import 'package:timer/constants.dart';

class customButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final bool outLineBtn;
  final bool isLoading;

  customButton({this.text, this.onPressed, this.outLineBtn, this.isLoading});

  @override
  Widget build(BuildContext context) {
    bool _outLineBtn = outLineBtn ?? false;
    bool _isLoading = isLoading ?? false;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          height: 65.0,
          // alignment: Alignment.center,
          decoration: BoxDecoration(
            color: _outLineBtn ? Colors.transparent : Colors.black,
            border: Border.all(
              color: Colors.black,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
          margin: EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 8.0,
          ),
          child: Stack(
            children: [
              Visibility(
                visible: _isLoading ? false : true,
                child: Center(
                  child: Text(
                    text ?? "Text",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: _outLineBtn ? Colors.black : Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: _isLoading,
                child: Center(
                  child: SizedBox(
                      height: 30.0,
                      width: 30.0,
                      child: CircularProgressIndicator()),
                ),
              )
            ],
          )),
    );
  }
}
