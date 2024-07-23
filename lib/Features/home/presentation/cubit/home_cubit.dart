import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:english/Features/home/presentation/cubit/home_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/shared/sql.dart';
import '../../../../main.dart';
import '../../domain/entity/sentence_entity.dart';
import '../../domain/entity/words_entity.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() :super(InitialHomeState());
  static final HomeCubit _homeCubit = BlocProvider.of<HomeCubit>(navigatorKey.currentState!.context);
  static HomeCubit get instance => _homeCubit;

  int currentNumber = 0;
  SqlDB database = SqlDB ();
  bool isBottomSheetShown = true;
  List <Map> sentenceList = [];
  List <Map> wordsList = [];
////////////////////////////////////////////////////////////////////////////////
  changeIndex(int index){
    currentNumber = index;
    emit(ChangeIndexState());
  }
////////////////////////////////////////////////////////////////////////////////
  insertData(String inputType) async {
    emit(InsertDataLoading());
    database.myDeleteDatabase();
    int response = 0;
    try{
      if (inputType == "word"){
        for(int i = 0 ; i < wordsDataOnlineList.length; i++){
          response = await HomeCubit.instance.database.insertData("INSERT INTO words (word, translate) VALUES ('${wordsDataOnlineList[i].word}', '${wordsDataOnlineList[i].translate}')");
        }
        isBottomSheetShown = true;
        readData(1);
        debugPrint("words $response");
        emit(InsertDataSuccess());
      }else if (inputType == "sentence"){
        for(int i = 0 ; i < sentencesDataOnlineList.length; i++){
          response = await HomeCubit.instance.database.insertData("INSERT INTO sentences (sentence, translate) VALUES ('${sentencesDataOnlineList[i].sentence}', '${sentencesDataOnlineList[i].translate}')");
        }
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
// ////////////////////////////////////////////////////////////////////////////////
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
////////////////////////////////////////////////////////////////////////////////
  List <Map> searchSentenceData = [];
  searchForSentence (String text) {
    emit(SearchStarting());
    searchSentenceData.clear();
    if(text.isNotEmpty){
      searchSentenceData.addAll(sentenceList.where((element) => element['sentence'].toLowerCase().contains(text.toLowerCase())));
    }
    emit(SearchEndState());
  }
////////////////////////////////////////////////////////////////////////////////
  List <Map> searchWordData = [];
  searchForWord (String text) {
    emit(SearchStarting());
    searchWordData.clear();
    if(text.isNotEmpty){
      searchWordData.addAll(wordsList.where((element) => element['word'].toLowerCase().contains(text.toLowerCase())));
    }
    emit(SearchEndState());
  }

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// online data
  CollectionReference sentenceDataTableOnline = FirebaseFirestore.instance.collection('sentenceData');
  insertSentenceOnline (String text, String translate){
    emit(InsertSentenceOnlineLoading());
    try{
      sentenceDataTableOnline.add({
        'sentence': text,
        'translate': translate,
      }).then((value){
        getSentencesOnline();
      });
      emit(InsertSentenceOnlineSuccess());
    } catch (e){
      emit(InsertSentenceOnlineError());
    }
  }
////////////////////////////////////////////////////////////////////////////////
  CollectionReference wordDataTableOnline = FirebaseFirestore.instance.collection('wordData');
  insertWordOnline (String text, String translate){
    emit(InsertWordOnlineLoading());
    try{
      wordDataTableOnline.add({
        'word': text,
        'translate': translate,
      }).then((value){
        getWordsOnline();
      });
      emit(InsertWordOnlineSuccess());
    } catch (e){
      emit(InsertWordOnlineError());
    }
  }
////////////////////////////////////////////////////////////////////////////////
  List <SentenceDataEntity> sentencesDataOnlineList = [];
  getSentencesOnline () async {
    emit(GetSentencesOnlineLoading());
    sentencesDataOnlineList.clear();
    await FirebaseFirestore.instance.collection('sentenceData').get().then((value){
      for(var i in value.docs){
        sentencesDataOnlineList.add(SentenceDataEntity.fromJson(i.data()));
      }
      // if(sentencesDataOnlineList.isNotEmpty){
      //   insertData("sentence");
      // }
      emit(GetSentencesOnlineSuccess());
    }).catchError((error){
      debugPrint('error ${error.toString()}');
      emit(GetSentencesOnlineError());
    });
  }
////////////////////////////////////////////////////////////////////////////////
  List <WordsDataEntity> wordsDataOnlineList = [];
  getWordsOnline () async {
    emit(GetWordsOnlineLoading());
    wordsDataOnlineList.clear();
    await FirebaseFirestore.instance.collection('wordData').get().then((value){
      for(var i in value.docs){
        wordsDataOnlineList.add(WordsDataEntity.fromJson(i.data()));
      }
      emit(GetWordsOnlineSuccess());
    }).catchError((error){
      debugPrint('error ${error.toString()}');
      emit(GetWordsOnlineError());
    });
  }
////////////////////////////////////////////////////////////////////////////////
  List <SentenceDataEntity> searchSentenceListOnline = [];
  searchForSentenceOnline (String text) {
    emit(SearchStarting());
    searchSentenceListOnline.clear();
    if(text.isNotEmpty){
      searchSentenceListOnline.addAll(sentencesDataOnlineList.where((element) => element.sentence.toLowerCase().contains(text.toLowerCase())));
    }
    emit(SearchEndState());
  }
////////////////////////////////////////////////////////////////////////////////
  List <WordsDataEntity> searchWordsListOnline = [];
  searchForWordsOnline (String text) {
    emit(SearchStarting());
    searchWordsListOnline.clear();
    if(text.isNotEmpty){
      searchWordsListOnline.addAll(wordsDataOnlineList.where((element) => element.word.toLowerCase().contains(text.toLowerCase())));
    }
    emit(SearchEndState());
  }
}