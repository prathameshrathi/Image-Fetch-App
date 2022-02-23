import 'package:flutter/material.dart';
class ErrorScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.error,size: 120,color: Colors.blue,),
            SizedBox(height: 20,),
            Text("Ahhh! Some error occured",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          ],
        ),
      ),
    );
  }
}