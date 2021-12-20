import 'package:flutter/material.dart';
import 'package:localstorage/repo/services.dart';

class BarcodeScannerScreen extends StatefulWidget {
  const BarcodeScannerScreen({Key? key}) : super(key: key);

  @override
  State<BarcodeScannerScreen> createState() => _BarcodeScannerScreenState();
}

class _BarcodeScannerScreenState extends State<BarcodeScannerScreen> {
  String scanResult = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Barcode Scanner'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment:MainAxisAlignment.center,
          children: [
            Text(scanResult),
            ElevatedButton(
              onPressed: () async {
                scanResult = await Service.scanBarcode();
                setState(() {
                  
                });
              },
              child: const Text('Scan'),
            ),
          ],
        ),
      ),
    );
  }
}
