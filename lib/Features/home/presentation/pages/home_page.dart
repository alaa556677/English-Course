import 'package:english/Features/home/presentation/cubit/home_cubit.dart';
import 'package:english/Features/home/presentation/cubit/home_states.dart';
import 'package:english/core/constants/list_constants.dart';
import 'package:english/core/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/shared/sql.dart';
import '../../../../core/widgets/default_screen.dart';
import '../../../../core/widgets/default_text.dart';
import '../../../../core/widgets/default_textFormField.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var scaffoldKey = GlobalKey <ScaffoldState> ();
  TextEditingController words = TextEditingController();
  TextEditingController translate = TextEditingController();
  var inputType = "word";

  @override
  Widget build(BuildContext context) {
    return BlocConsumer <HomeCubit, HomeStates> (
      listener: (context, state){},
      builder: (context, state) {
        return DefaultScreen(
          title: titles [HomeCubit.instance.currentNumber],
          scaffoldKey: scaffoldKey,
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.book_outlined), label: "Sentence"),
              BottomNavigationBarItem(icon: Icon(Icons.palette_rounded), label: "Words"),
            ],
            backgroundColor: AppColors.blackColor.withOpacity(.5),
            type: BottomNavigationBarType.fixed,
            currentIndex: HomeCubit.instance.currentNumber,
            selectedItemColor: AppColors.whiteColor,
            unselectedItemColor: AppColors.whiteColor.withOpacity(.5),
            selectedLabelStyle: Theme.of(context).textTheme.labelSmall,
            unselectedLabelStyle: Theme.of(context).textTheme.labelSmall!.copyWith(
                color: AppColors.whiteColor.withOpacity(.5)
            ),
            onTap: (index){
              HomeCubit.instance.changeIndex(index);
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              if(HomeCubit.instance.isBottomSheetShown){
                scaffoldKey.currentState?.showBottomSheet((context) => BlocConsumer <HomeCubit, HomeStates> (
                  listener: (context, state){},
                  builder: (context, state){
                    return SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsetsDirectional.symmetric(horizontal: 12.w, vertical: 16.h),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ChatTextFormField(
                              controller: words,
                              hintText: 'word',
                              label: "The words",
                            ),
                            SizedBox(height: 20.h,),
                            ChatTextFormField(
                              controller: translate,
                              hintText: 'translate',
                              label: "The translate",
                            ),
                            SizedBox(height: 20.h,),
                            DefaultText(
                              text: "Input Type",
                              themeStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
                                  color: AppColors.blackColor
                              ),
                            ),
                            SizedBox(height: 10.h,),
                            DropdownButtonFormField(
                              isExpanded: true,
                              value: inputType,
                              onChanged: (val){
                                setState(() {
                                  inputType = val!;
                                });
                              },
                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                                  constraints: const BoxConstraints(maxHeight: 56),
                                  filled: true,
                                  fillColor: Theme.of(context).cardColor,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(color: AppColors.blackColor)
                                  )
                              ),
                              items: ["word", "sentence"].map((e) => DropdownMenuItem(
                                  value: e,
                                  child: DefaultText(
                                    text: e,
                                    themeStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
                                        color: AppColors.blackColor
                                    ),
                                  ))
                              ).toList(),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )).closed.then((value){
                  setState(() {HomeCubit.instance.isBottomSheetShown = true;});
                });
                setState(() {HomeCubit.instance.isBottomSheetShown = false;});
              }else{
                HomeCubit.instance.insertData(words.text, translate.text, inputType);
                Navigator.pop(context);
              }
            },
            backgroundColor: AppColors.blackColor.withOpacity(.7),
            child: Icon(Icons.add, color: AppColors.whiteColor,),
          ),
          body: screens[HomeCubit.instance.currentNumber],
        );
      },
    );
  }
}

