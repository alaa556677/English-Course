abstract class HomeStates {}

class InitialHomeState extends HomeStates{}

class ChangeIndexState extends HomeStates{}

class InsertDataLoading extends HomeStates{}
class InsertDataSuccess extends HomeStates{}
class InsertDataError extends HomeStates{}

class ReadDataLoading extends HomeStates{}
class ReadDataSuccess extends HomeStates{}
class ReadDataError extends HomeStates{}

class SearchStarting extends HomeStates{}
class SearchEndState extends HomeStates{}

class InsertSentenceOnlineLoading extends HomeStates{}
class InsertSentenceOnlineSuccess extends HomeStates{}
class InsertSentenceOnlineError extends HomeStates{}

class InsertWordOnlineLoading extends HomeStates{}
class InsertWordOnlineSuccess extends HomeStates{}
class InsertWordOnlineError extends HomeStates{}

class GetSentencesOnlineLoading extends HomeStates{}
class GetSentencesOnlineSuccess extends HomeStates{}
class GetSentencesOnlineError extends HomeStates{}

class GetWordsOnlineLoading extends HomeStates{}
class GetWordsOnlineSuccess extends HomeStates{}
class GetWordsOnlineError extends HomeStates{}