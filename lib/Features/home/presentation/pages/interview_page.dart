import 'package:english/Features/home/presentation/cubit/home_states.dart';
import 'package:english/Features/home/presentation/pages/widgets/card_sentence_widget.dart';
import 'package:english/Features/home/presentation/pages/widgets/card_word_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widgets/default_no_data_found.dart';
import '../../../../core/widgets/default_search_box.dart';
import '../../../../core/widgets/default_text.dart';
import '../cubit/home_cubit.dart';

class InterviewPage extends StatefulWidget {
  const InterviewPage({super.key});
  @override
  State<InterviewPage> createState() => _InterviewPageState();
}

class _InterviewPageState extends State<InterviewPage> {

  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    // HomeCubit.instance.readData(1);
    HomeCubit.instance.getInterviewOnline();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer <HomeCubit, HomeStates> (
      listener: (context, state){},
      builder: (context, state) {
        return state is GetInterviewOnlineLoading ? const Center(child: CircularProgressIndicator(),) : HomeCubit.instance.interviewDataOnlineList.isEmpty ? const NotFoundPage(label: "No Data",) : Column(
          children: [
            SearchTextForm(
              searchController: searchController,
              radius: 12,
              onChanged: (value){
                HomeCubit.instance.searchForInterviewOnline(searchController.text);
              },
            ),
            SizedBox(height: 14.h,),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DefaultText(
                  text: "Count ",
                  themeStyle: Theme.of(context).textTheme.labelMedium,
                ),
                SizedBox(width: 4.w,),
                DefaultText(
                  text: HomeCubit.instance.searchInterviewListOnline.isNotEmpty ? "${HomeCubit.instance.searchInterviewListOnline.length}" : "${HomeCubit.instance.interviewDataOnlineList.length}",
                  themeStyle: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),
            SizedBox(height: 14.h,),
            Expanded(
              child: HomeCubit.instance.searchInterviewListOnline.isNotEmpty ? ListView.separated(
                // child: false ? ListView.separated(
                  itemBuilder: (context, index) => CardSentenceWidget(
                    englishText: HomeCubit.instance.searchInterviewListOnline[index].interview,
                    arabicText: HomeCubit.instance.searchInterviewListOnline[index].translate,
                  ),
                  separatorBuilder: (context, index) => SizedBox(height: 12.h,),
                  itemCount: HomeCubit.instance.searchInterviewListOnline.length
              ) : ListView.separated(
                  itemBuilder: (context, index) => Dismissible(
                    key:  Key(UniqueKey().toString()),
                    direction: DismissDirection.none,
                    onDismissed: (direction){
                      debugPrint("alaaaaaa ${HomeCubit.instance.documentIdWord[index]}");
                      // HomeCubit.instance.deleteDocument("wordData", HomeCubit.instance.documentIdWord[index]);
                    },
                    child: CardSentenceWidget(
                      englishText: HomeCubit.instance.interviewDataOnlineList[index].interview,
                      arabicText: HomeCubit.instance.interviewDataOnlineList[index].translate,
                    ),
                  ),
                  separatorBuilder: (context, index) => SizedBox(height: 12.h,),
                  itemCount: HomeCubit.instance.interviewDataOnlineList.length
              ),
            ),
          ],
        );
      },
    );
  }
}