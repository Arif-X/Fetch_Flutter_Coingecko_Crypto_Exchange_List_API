import 'package:flutter/material.dart';
import 'ExchangesListView.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crypto Exchange List',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Crypto Exchange List'),
        ),
        body: Center(
            child: ExchangeListView()
        ),
      ),
    );
  }
}
