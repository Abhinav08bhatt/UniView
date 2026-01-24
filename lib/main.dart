import 'package:flutter/material.dart';
import 'package:uniview/graphic_era_main.dart';


// UniView app main
void main() {
  runApp(const UniView());
}

// Main screen navigation
class UniView extends StatelessWidget {
  const UniView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

// main home screen
      home: const GraphicEraMain(),

    );
  }
}
