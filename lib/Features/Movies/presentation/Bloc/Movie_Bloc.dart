import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_task/Features/Movies/domain/entites/Movie.dart';
import 'package:movie_task/Features/Movies/domain/entites/TvShow.dart';
import 'package:movie_task/Features/Movies/presentation/pages/ForBottom2.dart';
import 'package:movie_task/Features/Movies/presentation/pages/Home.dart';
import 'package:movie_task/Features/Movies/presentation/pages/forbottom3.dart';

import '../../../../core/Strings/failures.dart';
import '../../../../core/error/failure.dart';
import '../../domain/usecases/get_all_TvByPage.dart';
import '../../domain/usecases/get_all_byPage.dart';
import 'Movie_stats.dart';


class MovieCubit extends Cubit<MyState> {

  final GetByPageUseCase getByPageUseCase;
  final GetByPageTvUseCase getByPageTvUseCase;
  MovieCubit({required this.getByPageUseCase ,required this.getByPageTvUseCase}) : super(MovieInitial());

  static MovieCubit get(context)=> BlocProvider.of(context);


  late List<TvShow>Tvshow=[];
  late List<Movie>movies=[];
  late List<Movie>Relatedmovies=[];

  int currentPage = 1;
  int itemsPerPage = 5;

  int currentPageTv = 1;
  int itemsPerPageTv = 5;
  Future<void> fetchMovies() async {

    emit(LoadingMovieState());

    // Call the use case to get movies by page
    final failureOrMovies = await getByPageUseCase(
      currentPage: currentPage,
      itemsPerPage: itemsPerPage,
    );

    failureOrMovies.fold(
          (failure) {
        emit(ErrorMovieState(message: _mapFailureToMessage(failure)));
      },
          (movies) {
        this.movies.addAll(movies); // Append the new page of movies to the existing list
        currentPage++; // Increment the page for the next fetch
        emit(LoadedMovieState());

      },
    );
  }


  Future<void> fetchTvShow() async {
    emit(LoadingTVState());

    final failureorTvShow = await getByPageTvUseCase(
      currentPageTv: currentPageTv,
      itemsPerPageTv: itemsPerPageTv,
    );
    failureorTvShow.fold(
          (failure) {
        emit(ErrorTVState(message: _mapFailureToMessage(failure)));
      },
          (tvshow) {
        // Update the movies list with the fetched movies
        this.Tvshow.addAll(tvshow);
        currentPageTv++;
        emit(LoadedTVState());
      },
    );
  }


// Function to add related movies by a specific title
  void addRelatedMoviesByTitle(String enteredTitle) {
    emit(LoadingRelatedState());

    // Extract the first part of the entered title
    final enteredTitleFirstPart = enteredTitle.split(' ')[0];

    if (movies.isNotEmpty) {
      Relatedmovies = movies.where((movie) {
        final movieFirstPart = movie.title.split(' ')[0];
        // Filter out the movie with the same title as the entered title
        return movieFirstPart == enteredTitleFirstPart && movie.title != enteredTitle;
      }).toList();
      emit(LoadedRelatedState());


    }
  }
  int currentIndex=0;
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: SvgPicture.asset(
        'assets/images/bottom1.svg',
        width: 30.0.w,
        height: 35.0.h,
      ),
      label: '',

    ),
    BottomNavigationBarItem(
      icon: SvgPicture.asset(
        'assets/images/bottom2.svg',
        width: 24.w,
        height: 24.h,
      ),
      label: '',

    ),
    BottomNavigationBarItem(
      icon: SvgPicture.asset(
        'assets/images/bottom3.svg',
        width: 24.w,
        height: 24.h,
      ),
      label: '',

    ),
  ];

  List<Widget>bottomScreens = [
    HomePage(),
    const Bottom2(),
    const Bottom3()
  ];
  void changeBottom(int index){
    currentIndex=index;
    emit(MarvelBottomNavState());
  }


  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case EmptyCacheFailure:
        return EMPTY_CACHE_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Unexpected Error , Please try again later .";
    }
  }
  }


