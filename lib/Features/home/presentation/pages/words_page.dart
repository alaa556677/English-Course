import 'package:english/core/styles/colors.dart';
import 'package:flutter/material.dart';
import '../../../../core/widgets/default_screen.dart';

class WordsPage extends StatefulWidget {
  const WordsPage({super.key});
  @override
  State<WordsPage> createState() => _WordsPageState();
}

class _WordsPageState extends State<WordsPage> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text("words")
      ],
    );
  }
}