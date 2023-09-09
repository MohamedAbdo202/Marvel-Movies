

abstract class MyState {}


class MovieInitial extends MyState {}

class LoadingMovieState extends MyState {}

class LoadedMovieState extends MyState {

}

class ErrorMovieState extends MyState {
  final String message;

  ErrorMovieState({required this.message});

}

class LoadingTVState extends MyState {}

class LoadedTVState extends MyState {

}

class ErrorTVState extends MyState {
  final String message;

  ErrorTVState({required this.message});

}

class LoadingRelatedState extends MyState {}

class LoadedRelatedState extends MyState {

}
class MarvelBottomNavState extends MyState{}
