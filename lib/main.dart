import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IoT Sensor Dashboard',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SensorDashboard(),
    );
  }
}

class SensorDashboard extends StatefulWidget {
  @override
  _SensorDashboardState createState() => _SensorDashboardState();
}

class _SensorDashboardState extends State<SensorDashboard> {
  double temperature = 30.0;
  double humidity = 89.0;
  double soilMoisture = 19.0;
  bool pumpStatus = true;
  String mode = "Manual";

  void togglePump() {
    setState(() {
      pumpStatus = !pumpStatus;
    });
  }

  void switchMode() {
    setState(() {
      mode = mode == "Automatic" ? "Manual" : "Automatic";
    });
  }

  Widget buildGauge(String label, double value, Color color) {
    return Column(
      children: [
        Text('$label: ${value.toStringAsFixed(1)}'),
        SizedBox(
          width: 150,
          height: 150,
          child: SfRadialGauge(
            axes: <RadialAxis>[
              RadialAxis(
                minimum: 0,
                maximum: 100,
                showLabels: false,
                showTicks: false,
                ranges: <GaugeRange>[
                  GaugeRange(startValue: 0, endValue: value, color: color),
                ],
                pointers: <GaugePointer>[
                  NeedlePointer(value: value),
                ],
                annotations: <GaugeAnnotation>[
                  GaugeAnnotation(
                    widget: Text(
                      '$value',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    angle: 90,
                    positionFactor: 0.8,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('IoT Sensor Dashboard')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildGauge("Temperature", temperature, Colors.blue),
                buildGauge("Humidity", humidity, Colors.green),
              ],
            ),
            SizedBox(height: 20),
            Center(child: buildGauge("Soil Moisture", soilMoisture, Colors.orange)),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Pump is ${pumpStatus ? "ON" : "OFF"}'),
                Switch(
                  value: pumpStatus,
                  onChanged: (value) => togglePump(),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Mode: $mode'),
                ElevatedButton(
                  onPressed: switchMode,
                  child: Text('Switch to ${mode == "Automatic" ? "Manual" : "Automatic"} Mode'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
