abstract class HomeStates {}

class InitialHomeState extends HomeStates{}

class ChangeIndexState extends HomeStates{}

class InsertDataLoading extends HomeStates{}
class InsertDataSuccess extends HomeStates{}
class InsertDataError extends HomeStates{}

class ReadDataLoading extends HomeStates{}
class ReadDataSuccess extends HomeStates{}
class ReadDataError extends HomeStates{}