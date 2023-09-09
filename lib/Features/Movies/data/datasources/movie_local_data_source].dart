import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:movie_task/Features/Movies/data/models/TvShow_model.dart';
import 'package:movie_task/Features/Movies/data/models/movie_model.dart';
import 'package:movie_task/core/error/exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class MovieLocalDataSource{
  Future<List<TvShowModel>> getCachedTvShow();
  Future<Unit> cacheTvShow(List<TvShowModel>TvModel);


  Future<List<MovieModel>> getCachedMovies();
 Future<Unit> cacheMovies(List<MovieModel>movieModel);
}
class MovieLocalDataSourceImpl  implements MovieLocalDataSource{
  @override

  final SharedPreferences sharedPreferences;

  MovieLocalDataSourceImpl({required this.sharedPreferences});

  Future<Unit> cacheMovies(List<MovieModel> movieModels) {
    List movieModelToJson=movieModels.map<Map<String,dynamic>>((movieModel) =>movieModel.toJson() ).toList();
sharedPreferences.setString("Cached_Movies", json.encode(movieModelToJson));
return Future.value(unit);
  }

  @override
  Future<List<MovieModel>> getCachedMovies() {
   final jsonString =sharedPreferences.getString('Cached_Movies');
   if(jsonString!=null){
    List decodeJsonData =json.decode(jsonString);
    List<MovieModel>jsonToMovieModel= decodeJsonData.map<MovieModel>((jsonMovieModel) => MovieModel.fromJson(jsonMovieModel)).toList();
return Future.value(jsonToMovieModel);
   }else{

     throw EmptyCacheException();
   }
  }


  Future<Unit> cacheTvShow(List<TvShowModel> TvModel) {
    List TvShowModelToJson=TvModel.map<Map<String,dynamic>>((TvShowModel) =>TvShowModel.toJson() ).toList();
    sharedPreferences.setString("Cached_TvShow", json.encode(TvShowModelToJson));
    return Future.value(unit);
  }

  @override
  Future<List<TvShowModel>> getCachedTvShow() {
    final jsonString =sharedPreferences.getString("Cached_TvShow");
    if(jsonString!=null){
      List decodeJsonData =json.decode(jsonString);
      List<TvShowModel>jsonToMovieModel= decodeJsonData.map<TvShowModel>((jsonTVModel) => TvShowModel.fromJson(jsonTVModel)).toList();
      return Future.value(jsonToMovieModel);
    }else{

      throw EmptyCacheException();
    }
  }
}