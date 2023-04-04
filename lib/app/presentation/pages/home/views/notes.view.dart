import 'package:flutter/material.dart';

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
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
          : Center(child: Text('NOTES')),
    );
  }
}
