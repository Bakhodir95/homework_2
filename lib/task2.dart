import 'dart:async';
import 'dart:isolate';

import 'package:flutter/material.dart';

class Isolatecreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Heavy Computation')),
      body: Center(
        child: FutureBuilder<int>(
          future: _compute(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Text('Result: ${snapshot.data}');
            }
          },
        ),
      ),
    );
  }

  Future<int> _compute() async {
    ReceivePort receivePort = ReceivePort();

    await Isolate.spawn(_heavyComputation, receivePort.sendPort);

    Completer<int> completer = Completer();

    receivePort.listen((dynamic message) {
      completer.complete(message as int);
      receivePort.close();
    });

    return completer.future;
  }

  static void _heavyComputation(SendPort sendPort) {
    int sum = 0;
    for (int i = 0; i < 10000000000; i++) {
      sum += i;
    }

    sendPort.send(sum);
  }
}
