import 'package:flutter/material.dart';

class SettingsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:
              Text('Settings', style: TextStyle(fontWeight: FontWeight.w700))),
      body: Container(
          color: Colors.black87,
          child: Center(
            child: Text('This is settings, bam!',
                style: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.w800,
                    fontStyle: FontStyle.italic,
                    fontSize: 37)),
          )),
    );
  }
}
