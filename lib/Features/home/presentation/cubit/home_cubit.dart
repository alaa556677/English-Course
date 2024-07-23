import 'package:bloc/bloc.dart';
import 'package:english/Features/home/presentation/cubit/home_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/shared/sql.dart';
import '../../../../main.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() :super(InitialHomeState());
  static final HomeCubit _homeCubit = BlocProvider.of<HomeCubit>(navigatorKey.currentState!.context);
  static HomeCubit get instance => _homeCubit;

  int currentNumber = 0;
  SqlDB database = SqlDB ();
  bool isBottomSheetShown = true;
  List <Map> sentenceList = [];
  List <Map> wordsList = [];

  changeIndex(int index){
    currentNumber = index;
    emit(ChangeIndexState());
  }

  insertData(String text, String translate, String inputType) async {
    emit(InsertDataLoading());
    int response = 0;
    try{
      if (inputType == "word"){
        response = await HomeCubit.instance.database.insertData("INSERT INTO words (word, translate) VALUES ('$text', '$translate')");
        isBottomSheetShown = true;
        readData(1);
        debugPrint("words $response");
        emit(InsertDataSuccess());
      }else if (inputType == "sentence"){
        response = await HomeCubit.instance.database.insertData("INSERT INTO sentences (sentence, translate) VALUES ('$text', '$translate')");
        isBottomSheetShown = true;
        readData(0);
        debugPrint("sentence $response");
        emit(InsertDataSuccess());
      }
    }catch(e){
      debugPrint("$e");
      emit(InsertDataError());
    }
  }

  readData(int index) async {
    try{
      emit(ReadDataLoading());
      if(index == 0){
        sentenceList = await database.readData ('SELECT * FROM sentences');
        emit(ReadDataSuccess());
      }else if (index == 1){
        wordsList = await database.readData ('SELECT * FROM words');
        emit(ReadDataSuccess());
      }
    }catch(e){
      debugPrint("$e");
      emit(ReadDataError());
    }

  }

}