import 'package:english/Features/home/presentation/cubit/home_cubit.dart';
import 'package:english/Features/home/presentation/pages/widgets/card_sentence_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widgets/default_no_data_found.dart';
import '../../../../core/widgets/default_search_box.dart';
import '../cubit/home_states.dart';

class SentencePage extends StatefulWidget {
  const SentencePage({super.key});
  @override
  State<SentencePage> createState() => _SentencePageState();
}

class _SentencePageState extends State<SentencePage> {

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    // HomeCubit.instance.readData(0);
    onInit();
    super.initState();
  }

  onInit() async{
    await HomeCubit.instance.getSentencesOnline();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer <HomeCubit, HomeStates> (
      listener: (context, state){},
      builder: (context, state) {
        return state is GetSentencesOnlineLoading ? const Center(child: CircularProgressIndicator()) : HomeCubit.instance.sentencesDataOnlineList.isEmpty ? const NotFoundPage(label: "No Data",) :Column(
          children: [
            SearchTextForm(
              searchController: searchController,
              radius: 12,
              onChanged: (value){
                HomeCubit.instance.searchForSentenceOnline(searchController.text);
              },
            ),
            SizedBox(height: 14.h,),
            Expanded(
              child: HomeCubit.instance.searchSentenceListOnline.isNotEmpty ? ListView.separated(
              // child: false ? ListView.separated(
                  itemBuilder: (context, index) => CardSentenceWidget(
                    englishText: HomeCubit.instance.searchSentenceListOnline[index].sentence,
                    arabicText: HomeCubit.instance.searchSentenceListOnline[index].translate,
                  ),
                  separatorBuilder: (context, index) => SizedBox(height: 12.h,),
                  itemCount: HomeCubit.instance.searchSentenceListOnline.length
              ) : ListView.separated(
                  itemBuilder: (context, index) => CardSentenceWidget(
                    // englishText: HomeCubit.instance.sentenceList[index]['sentence'],
                    englishText: HomeCubit.instance.sentencesDataOnlineList[index].sentence,
                    // arabicText: HomeCubit.instance.sentenceList[index]['translate'],
                    arabicText: HomeCubit.instance.sentencesDataOnlineList[index].translate,
                  ),
                  separatorBuilder: (context, index) => SizedBox(height: 12.h,),
                  // itemCount: HomeCubit.instance.sentenceList.length
                  itemCount: HomeCubit.instance.sentencesDataOnlineList.length
              ),
            ),
          ],
        );
      },
    );
  }
}