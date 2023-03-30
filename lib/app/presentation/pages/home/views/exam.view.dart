import 'package:flutter/material.dart';
class ExamenView extends StatefulWidget {
  const ExamenView({super.key});

  @override
  State<ExamenView> createState() => _ExamenViewState();
}

class _ExamenViewState extends State<ExamenView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child:Text('EXAMS')),
    );
  }
}