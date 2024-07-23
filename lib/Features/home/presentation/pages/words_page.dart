import 'package:english/Features/home/presentation/cubit/home_states.dart';
import 'package:english/core/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widgets/default_screen.dart';
import '../../../../core/widgets/default_text.dart';
import '../cubit/home_cubit.dart';

class WordsPage extends StatefulWidget {
  const WordsPage({super.key});
  @override
  State<WordsPage> createState() => _WordsPageState();
}

class _WordsPageState extends State<WordsPage> {

  @override
  void initState() {
    HomeCubit.instance.readData(1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer <HomeCubit, HomeStates> (
      listener: (context, state){},
      builder: (context, state) {
        return ListView.separated(
            itemBuilder: (context, index) => DefaultText(
              text: HomeCubit.instance.wordsList[index]['word'],
            ),
            separatorBuilder: (context, index) => SizedBox(height: 12.h,),
            itemCount: HomeCubit.instance.wordsList.length
        );
      },
    );
  }
}