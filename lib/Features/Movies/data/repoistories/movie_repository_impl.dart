import 'package:dartz/dartz.dart';
import 'package:movie_task/Features/Movies/domain/entites/Movie.dart';
import 'package:movie_task/Features/Movies/domain/entites/TvShow.dart';
import 'package:movie_task/Features/Movies/domain/repoistories/Movie_repositry.dart';
import 'package:movie_task/core/error/failure.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/movie_local_data_source].dart';
import '../datasources/movie_remote_data_source.dart';

class MovieRepoistoryImpl implements MovieRepository{
final MovieRemoteDataSource remoteDataSource;
final MovieLocalDataSource localDataSource;
final NetworkInfo networkInfo;
  MovieRepoistoryImpl({required this.remoteDataSource,required this.localDataSource,required this.networkInfo});


  @override
  Future<Either<Failure, List<Movie>>> getMoviesByPage(int currentPage, int itemsPerPage) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteMovies = await remoteDataSource.getAllMoviesbyPages(itemsPerPage:itemsPerPage , currentPage: currentPage);
        return Right(remoteMovies);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localMoviePage= await localDataSource.getCachedMovies();
        return Right(localMoviePage);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<TvShow>>> getTvByPage(int currentPageTv, int itemsPerPageTv) async {
    if (await networkInfo.isConnected) {
      try {
        final RemoteTv = await remoteDataSource.getAllTvByPages(itemsPerPageTv:itemsPerPageTv , currentPageTv: currentPageTv);
        return Right(RemoteTv);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localTvPage= await localDataSource.getCachedTvShow();
        return Right(localTvPage);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

}