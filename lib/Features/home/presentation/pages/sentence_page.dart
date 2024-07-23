import 'package:english/Features/home/presentation/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/default_text.dart';
import '../cubit/home_states.dart';

class SentencePage extends StatefulWidget {
  const SentencePage({super.key});
  @override
  State<SentencePage> createState() => _SentencePageState();
}

class _SentencePageState extends State<SentencePage> {

  @override
  void initState() {
    HomeCubit.instance.readData(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer <HomeCubit, HomeStates> (
      listener: (context, state){},
      builder: (context, state) {
        return ListView.separated(
            itemBuilder: (context, index) => DefaultText(
              text: HomeCubit.instance.sentenceList[index]['sentence'],
            ),
            separatorBuilder: (context, index) => SizedBox(height: 12.h,),
            itemCount: HomeCubit.instance.sentenceList.length
        );
      },
    );
  }
}