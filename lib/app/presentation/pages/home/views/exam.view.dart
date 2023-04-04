import 'package:flutter/material.dart';

class ExamenView extends StatefulWidget {
  const ExamenView({super.key});

  @override
  State<ExamenView> createState() => _ExamenViewState();
}

class _ExamenViewState extends State<ExamenView> {
  bool _loading = true;

  void _loadData() async {
    await Future.delayed(const Duration(seconds: 3));
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loading
          ? const CircularProgressIndicator()
          : Center(child: Text('EXAMS')),
    );
  }
}
