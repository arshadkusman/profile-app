import 'package:flutter/material.dart';

class NextPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Next Page'),
        backgroundColor: Color.fromARGB(255, 6, 232, 74),
      ),
      body: Center(
        child: Text(
          'Portuguese football legend \n'
          '5x Ballon dOr winner \n'
          'GOAT of football',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
