import 'package:english/Features/home/presentation/cubit/home_states.dart';
import 'package:english/Features/home/presentation/pages/widgets/card_sentence_widget.dart';
import 'package:english/Features/home/presentation/pages/widgets/card_word_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widgets/default_search_box.dart';
import '../cubit/home_cubit.dart';

class WordsPage extends StatefulWidget {
  const WordsPage({super.key});
  @override
  State<WordsPage> createState() => _WordsPageState();
}

class _WordsPageState extends State<WordsPage> {

  TextEditingController searchController = TextEditingController();
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
        return Column(
          children: [
            SearchTextForm(
              searchController: searchController,
              radius: 12,
              onChanged: (value){
                HomeCubit.instance.searchForWord(searchController.text);
              },
            ),
            SizedBox(height: 14.h,),
            Expanded(
              child: HomeCubit.instance.searchWordData.isEmpty ? ListView.separated(
                  itemBuilder: (context, index) => CardWordWidget(
                    englishText: HomeCubit.instance.wordsList[index]['word'],
                    arabicText: HomeCubit.instance.wordsList[index]['translate'],
                  ),
                  separatorBuilder: (context, index) => SizedBox(height: 12.h,),
                  itemCount: HomeCubit.instance.wordsList.length
              ) : ListView.separated(
                  itemBuilder: (context, index) => CardWordWidget(
                    englishText: HomeCubit.instance.searchWordData[index]['sentence'],
                    arabicText: HomeCubit.instance.searchWordData[index]['translate'],
                  ),
                  separatorBuilder: (context, index) => SizedBox(height: 12.h,),
                  itemCount: HomeCubit.instance.searchWordData.length
              ),
            ),
          ],
        );
      },
    );
  }
}