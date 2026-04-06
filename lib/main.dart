import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Battery Level',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platform = MethodChannel('samples.flutter.dev/battery');

  String _batteryLevel = "Unknown";

  Future<void> getBatteryLevel() async {
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      setState(() {
        _batteryLevel = "Battery: $result%";
      });
    } catch (e) {
      setState(() {
        _batteryLevel = "Error getting battery";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Battery Level')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: getBatteryLevel,
              child: Text("Get Battery"),
            ),
            SizedBox(height: 20),
            Text(_batteryLevel),
          ],
        ),
      ),
    );
  }
}
