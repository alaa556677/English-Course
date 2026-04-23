import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:english/Features/home/presentation/cubit/home_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/shared/sql.dart';
import '../../../../main.dart';
import '../../domain/entity/interview_entity.dart';
import '../../domain/entity/sentence_entity.dart';
import '../../domain/entity/words_entity.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(InitialHomeState());
  static final HomeCubit _homeCubit =
      BlocProvider.of<HomeCubit>(navigatorKey.currentState!.context);
  static HomeCubit get instance => _homeCubit;

  int currentNumber = 0;
  SqlDB database = SqlDB();

  bool isLoadingSentences = false;
  bool isLoadingWords = false;
  bool isLoadingInterview = false;
  bool hasErrorSentences = false;
  bool hasErrorWords = false;
  bool hasErrorInterview = false;

  List<Map> sentenceList = [];
  List<Map> wordsList = [];

  changeIndex(int index) {
    currentNumber = index;
    emit(ChangeIndexState());
  }

  // ── offline ──────────────────────────────────────────────────────────────

  insertData(String inputType) async {
    emit(InsertDataLoading());
    database.myDeleteDatabase();
    int response = 0;
    try {
      if (inputType == "word") {
        for (int i = 0; i < wordsDataOnlineList.length; i++) {
          response = await HomeCubit.instance.database.insertData(
              "INSERT INTO words (word, translate, time) VALUES ('${wordsDataOnlineList[i].word}', '${wordsDataOnlineList[i].translate}', '${wordsDataOnlineList[i].time.toString()}')");
        }
        readData(1);
        debugPrint("words $response");
        emit(InsertDataSuccess());
      } else if (inputType == "sentence") {
        for (int i = 0; i < sentencesDataOnlineList.length; i++) {
          response = await HomeCubit.instance.database.insertData(
              "INSERT INTO sentences (sentence, translate, time) VALUES ('${sentencesDataOnlineList[i].sentence}', '${sentencesDataOnlineList[i].translate}', '${sentencesDataOnlineList[i].time.toString()}')");
        }
        readData(0);
        debugPrint("sentence $response");
        emit(InsertDataSuccess());
      }
    } catch (e) {
      debugPrint("$e");
      emit(InsertDataError());
    }
  }

  readData(int index) async {
    try {
      emit(ReadDataLoading());
      if (index == 0) {
        sentenceList = await database.readData('SELECT * FROM sentences');
        emit(ReadDataSuccess());
      } else if (index == 1) {
        wordsList = await database.readData('SELECT * FROM words');
        emit(ReadDataSuccess());
      }
    } catch (e) {
      debugPrint("$e");
      emit(ReadDataError());
    }
  }

  List<Map> searchSentenceData = [];
  searchForSentence(String text) {
    emit(SearchStarting());
    searchSentenceData.clear();
    if (text.isNotEmpty) {
      searchSentenceData.addAll(sentenceList.where(
          (e) => e['sentence'].toLowerCase().contains(text.toLowerCase())));
    }
    emit(SearchEndState());
  }

  List<Map> searchWordData = [];
  searchForWord(String text) {
    emit(SearchStarting());
    searchWordData.clear();
    if (text.isNotEmpty) {
      searchWordData.addAll(wordsList
          .where((e) => e['word'].toLowerCase().contains(text.toLowerCase())));
    }
    emit(SearchEndState());
  }

  // ── online insert ─────────────────────────────────────────────────────────

  CollectionReference sentenceDataTableOnline = FirebaseFirestore.instance.collection('sentenceData');

  insertSentenceOnline(String text, String translate) {
    emit(InsertSentenceOnlineLoading());
    try {
      sentenceDataTableOnline.doc().set({
        'sentence': text,
        'translate': translate,
        'time': DateTime.now().toIso8601String(),
      }).then((_) => getSentencesOnline());
      emit(InsertSentenceOnlineSuccess());
    } catch (e) {
      emit(InsertSentenceOnlineError());
    }
  }

  CollectionReference wordDataTableOnline = FirebaseFirestore.instance.collection('wordData');

  insertWordOnline(String text, String translate) {
    emit(InsertWordOnlineLoading());
    try {
      wordDataTableOnline.add({
        'word': text,
        'translate': translate,
        'time': DateTime.now().toIso8601String(),
      }).then((_) => getWordsOnline());
      emit(InsertWordOnlineSuccess());
    } catch (e) {
      emit(InsertWordOnlineError());
    }
  }

  CollectionReference interviewDataOnline = FirebaseFirestore.instance.collection('interviewData');

  insertInterviewOnline(String text, String translate) {
    emit(InsertInterviewOnlineLoading());
    try {
      interviewDataOnline.add({
        'interview': text,
        'translate': translate,
        'time': DateTime.now().toIso8601String(),
      }).then((_) => getInterviewOnline());
      emit(InsertInterviewOnlineSuccess());
    } catch (e) {
      emit(InsertInterviewOnlineError());
    }
  }

  // ── online fetch ──────────────────────────────────────────────────────────

  List<SentenceDataEntity> sentencesDataOnlineList = [];
  getSentencesOnline() async {
    isLoadingSentences = true;
    hasErrorSentences = false;
    emit(GetSentencesOnlineLoading());
    sentencesDataOnlineList.clear();
    searchSentenceListOnline.clear();
    try {
      final value = await FirebaseFirestore.instance.collection('sentenceData').get();
      for (var i in value.docs) {
        sentencesDataOnlineList
            .add(SentenceDataEntity.fromJson(i.data(), id: i.id));
      }
      sentencesDataOnlineList.sort((a, b) => b.time.compareTo(a.time));
      isLoadingSentences = false;
      emit(GetSentencesOnlineSuccess());
    } catch (error) {
      debugPrint('getSentencesOnline error: $error');
      isLoadingSentences = false;
      hasErrorSentences = true;
      emit(GetSentencesOnlineError());
    }
  }

  List<WordsDataEntity> wordsDataOnlineList = [];
  getWordsOnline() async {
    isLoadingWords = true;
    hasErrorWords = false;
    emit(GetWordsOnlineLoading());
    wordsDataOnlineList.clear();
    searchWordsListOnline.clear();
    try {
      final value = await FirebaseFirestore.instance.collection('wordData').get();
      for (var i in value.docs) {
        wordsDataOnlineList.add(WordsDataEntity.fromJson(i.data(), id: i.id));
      }
      wordsDataOnlineList.sort((a, b) => b.time.compareTo(a.time));
      isLoadingWords = false;
      emit(GetWordsOnlineSuccess());
    } catch (error) {
      debugPrint('getWordsOnline error: $error');
      isLoadingWords = false;
      hasErrorWords = true;
      emit(GetWordsOnlineError());
    }
  }

  List<InterviewDataEntity> interviewDataOnlineList = [];
  getInterviewOnline() async {
    isLoadingInterview = true;
    hasErrorInterview = false;
    emit(GetInterviewOnlineLoading());
    interviewDataOnlineList.clear();
    searchInterviewListOnline.clear();
    try {
      final value = await FirebaseFirestore.instance.collection('interviewData').get();
      for (var i in value.docs) {
        interviewDataOnlineList
            .add(InterviewDataEntity.fromJson(i.data(), id: i.id));
      }
      interviewDataOnlineList.sort((a, b) => b.time.compareTo(a.time));
      isLoadingInterview = false;
      emit(GetInterviewsOnlineSuccess());
    } catch (error) {
      debugPrint('getInterviewOnline error: $error');
      isLoadingInterview = false;
      hasErrorInterview = true;
      emit(GetInterviewsOnlineError());
    }
  }

  // ── online search ─────────────────────────────────────────────────────────

  List<SentenceDataEntity> searchSentenceListOnline = [];
  searchForSentenceOnline(String text) {
    emit(SearchStarting());
    searchSentenceListOnline.clear();
    if (text.isNotEmpty) {
      searchSentenceListOnline.addAll(sentencesDataOnlineList.where(
          (e) => e.sentence.toLowerCase().contains(text.toLowerCase())));
    }
    emit(SearchEndState());
  }

  List<WordsDataEntity> searchWordsListOnline = [];
  searchForWordsOnline(String text) {
    emit(SearchStarting());
    searchWordsListOnline.clear();
    if (text.isNotEmpty) {
      searchWordsListOnline.addAll(wordsDataOnlineList
          .where((e) => e.word.toLowerCase().contains(text.toLowerCase())));
    }
    emit(SearchEndState());
  }

  List<InterviewDataEntity> searchInterviewListOnline = [];
  searchForInterviewOnline(String text) {
    emit(SearchStarting());
    searchInterviewListOnline.clear();
    if (text.isNotEmpty) {
      searchInterviewListOnline.addAll(interviewDataOnlineList.where(
          (e) => e.interview.toLowerCase().contains(text.toLowerCase())));
    }
    emit(SearchEndState());
  }

  // ── delete ────────────────────────────────────────────────────────────────

  deleteDocument(String collection, String docId) async {
    try {
      emit(DeleteDocumentLoading());
      await FirebaseFirestore.instance
          .collection(collection)
          .doc(docId)
          .delete();
      if (collection == "sentenceData") {
        await getSentencesOnline();
      } else if (collection == "wordData") {
        await getWordsOnline();
      } else if (collection == "interviewData") {
        await getInterviewOnline();
      }
      emit(DeleteDocumentSuccess());
    } catch (e) {
      debugPrint('deleteDocument error: $e');
      emit(DeleteDocumentError());
    }
  }

  // ── update ────────────────────────────────────────────────────────────────

  updateDocument(String collection, String docId, String contentField,
      String contentValue, String translateValue) async {
    try {
      emit(UpdateDocumentLoading());
      await FirebaseFirestore.instance
          .collection(collection)
          .doc(docId)
          .update({
        contentField: contentValue,
        'translate': translateValue,
      });
      if (collection == "sentenceData") {
        await getSentencesOnline();
      } else if (collection == "wordData") {
        await getWordsOnline();
      } else if (collection == "interviewData") {
        await getInterviewOnline();
      }
      emit(UpdateDocumentSuccess());
    } catch (e) {
      debugPrint('updateDocument error: $e');
      emit(UpdateDocumentError());
    }
  }
}
