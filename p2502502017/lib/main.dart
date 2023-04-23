import 'package:flutter/material.dart';
import 'package:p2502502017/paginas/principal.dart';


void main() {
  runApp(nombresap());
}

class nombresap extends StatelessWidget {
  const nombresap({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp
    (
       debugShowCheckedModeBanner: false,
      home: Principal(),
    );
  }
}