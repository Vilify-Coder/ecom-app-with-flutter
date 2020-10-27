import 'package:flutter/material.dart';

class productSizes extends StatefulWidget {
  final List productSize;
  final Function(String) onSelected;
  productSizes({this.productSize, this.onSelected});
  @override
  _productSizesState createState() => _productSizesState();
}

class _productSizesState extends State<productSizes> {
  int _selected = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20.0,
      ),
      child: Row(
        children: [
          for (var i = 0; i < widget.productSize.length; i++)
            GestureDetector(
              onTap: () {
                widget.onSelected(widget.productSize[i]);
                setState(() {
                  _selected = i;
                });
              },
              child: Container(
                width: 42.0,
                height: 42.0,
                decoration: BoxDecoration(
                  color: _selected == i
                      ? Theme.of(context).accentColor
                      : Color(0xffDCDCDC),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(
                  horizontal: 4.0,
                ),
                child: Text(
                  widget.productSize[i],
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                    color: _selected == i ? Colors.white : Colors.black,
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
