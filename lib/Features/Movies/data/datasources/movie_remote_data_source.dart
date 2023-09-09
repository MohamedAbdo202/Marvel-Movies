
import 'package:movie_task/Features/Movies/data/models/movie_model.dart';
import 'package:dio/dio.dart';
import 'package:movie_task/core/error/exception.dart';

import '../models/TvShow_model.dart';

abstract class MovieRemoteDataSource{




  Future<List<MovieModel>> getAllMoviesbyPages({
    required int currentPage,
    required int itemsPerPage,
  });
  Future<List<TvShowModel>> getAllTvByPages({
    required int currentPageTv,
    required int itemsPerPageTv,
  });



}
const Base_URL="https://mcuapi.herokuapp.com/api/v1/movies";
const Tv_URL='https://mcuapi.herokuapp.com/api/v1/tvshows';
class MovieRemoteImplWithDio implements MovieRemoteDataSource {
  final Dio dio;

  MovieRemoteImplWithDio({required this.dio});

  // API  FOR MOVIES



  @override
  Future<List<MovieModel>> getAllMoviesbyPages({
    required int currentPage,
    required int itemsPerPage,
  }) async {
    final response = await dio.get(
      '$Base_URL?page=$currentPage&limit=$itemsPerPage', // Append query parameters for pagination
      options: Options(
        headers: {
          "Content-Type": "application/json",
        },
      ),
    );

    if (response.statusCode == 200) {
      final List<dynamic> decodedJson = (response.data['data'] as List<dynamic>);
      final List<MovieModel> movieModels = decodedJson
          .map<MovieModel>((jsonMovieModel) => MovieModel.fromJson(jsonMovieModel))
          .toList();


      return movieModels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvShowModel>> getAllTvByPages({required int currentPageTv, required int itemsPerPageTv}) async {
    final response = await dio.get(
      '$Tv_URL?page=$currentPageTv&limit=$itemsPerPageTv',
      // Append query parameters for pagination
      options: Options(
        headers: {
          "Content-Type": "application/json",
        },
      ),
    );

    if (response.statusCode == 200) {
      final List<dynamic> decodedJson = (response.data['data'] as List<
          dynamic>);
      final List<TvShowModel> TvModelss = decodedJson
          .map<TvShowModel>((jsonTvModel) => TvShowModel.fromJson(jsonTvModel))
          .toList();

      return TvModelss;
    } else {
      throw ServerException();
    }
  }}