import 'package:english/core/constants/list_constants.dart';
import 'package:english/core/styles/colors.dart';
import 'package:flutter/material.dart';
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

  int currentNumber = 0;
  SqlDB database = SqlDB ();
  bool isBottomSheetShown = true;
  var scaffoldKey = GlobalKey <ScaffoldState> ();
  TextEditingController words = TextEditingController();
  TextEditingController translate = TextEditingController();
  var inputType = "word";

  @override
  Widget build(BuildContext context) {
    return DefaultScreen(
      title: titles [currentNumber],
      scaffoldKey: scaffoldKey,
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.book_outlined), label: "Sentence"),
          BottomNavigationBarItem(icon: Icon(Icons.palette_rounded), label: "Sentence"),
        ],
        backgroundColor: AppColors.blackColor.withOpacity(.5),
        type: BottomNavigationBarType.fixed,
        currentIndex: currentNumber,
        selectedItemColor: AppColors.whiteColor,
        unselectedItemColor: AppColors.whiteColor.withOpacity(.5),
        selectedLabelStyle: Theme.of(context).textTheme.labelSmall,
        unselectedLabelStyle: Theme.of(context).textTheme.labelSmall!.copyWith(
          color: AppColors.whiteColor.withOpacity(.5)
        ),
        onTap: (index){
          setState(() {
            currentNumber = index;
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if(isBottomSheetShown){
            scaffoldKey.currentState?.showBottomSheet((context) => SingleChildScrollView(
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
            )).closed.then((value){
              setState(() {isBottomSheetShown = true;});
            });
            setState(() {isBottomSheetShown = false;});
          }else{
            if (inputType == "word"){
              int response = await database.insertData("INSERT INTO words (word, translate) VALUES ('${words.text}', '${translate.text}')");
              Navigator.pop(context);
              setState((){isBottomSheetShown = true;});
            }else if (inputType == "sentence"){
              int response = await database.insertData("INSERT INTO sentences (sentence, translate) VALUES ('${words.text}', '${translate.text}')");
              Navigator.pop(context);
              setState((){isBottomSheetShown = true;});
            }
          }
        },
        backgroundColor: AppColors.blackColor.withOpacity(.7),
        child: Icon(Icons.add, color: AppColors.whiteColor,),
      ),
      body: screens[currentNumber],
    );
  }
}

