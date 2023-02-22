import 'package:flutter/material.dart';

class FlashCardsView extends StatefulWidget {
  const FlashCardsView({super.key});

  @override
  State<FlashCardsView> createState() => _FlashCardsViewState();
}

class _FlashCardsViewState extends State<FlashCardsView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(child: Text('FLASHCARDS')),
    );
  }
}