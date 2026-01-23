import 'package:flutter/material.dart';
import 'package:uniview/graphic_era_main.dart';

void main() {
  runApp(const UniView());
}

class UniView extends StatelessWidget {
  const UniView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: const GraphicEraMain(),

    );
  }
}
