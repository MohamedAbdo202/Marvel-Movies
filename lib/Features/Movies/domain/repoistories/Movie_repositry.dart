
import 'package:dartz/dartz.dart';
import 'package:movie_task/Features/Movies/domain/entites/TvShow.dart';

import '../../../../core/error/failure.dart';
import '../entites/Movie.dart';

abstract class MovieRepository {

  Future<Either<Failure, List<Movie>>> getMoviesByPage(
      int currentPage,
      int itemsPerPage,
      );
  Future<Either<Failure, List<TvShow>>> getTvByPage(
      int currentPageTv,
      int itemsPerPageTv,
      );

}