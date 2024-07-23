import 'package:flutter/material.dart';

class SentencePage extends StatefulWidget {
  const SentencePage({super.key});
  @override
  State<SentencePage> createState() => _SentencePageState();
}

class _SentencePageState extends State<SentencePage> {

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text("Sentence"),
      ],
    );
  }
}