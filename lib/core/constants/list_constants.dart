import 'package:english/Features/home/presentation/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import '../../Features/home/presentation/pages/interview_page.dart';
import '../../Features/home/presentation/pages/sentence_page.dart';
import '../../Features/home/presentation/pages/words_page.dart';

List <Widget> screens = [
  const SentencePage(),
  const WordsPage(),
  const InterviewPage()
];

List <String> titles = [
  "Sentence",
  "Words",
  "Interview"
];
