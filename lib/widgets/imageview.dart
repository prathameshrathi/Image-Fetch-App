import 'package:flutter/material.dart';

class ImageView extends StatelessWidget {
  String path;
  ImageView(this.path);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      height: 400,
      child: Card(
        elevation: 15.0,
        shadowColor: Colors.grey,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Image(
            image: NetworkImage(path),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}

