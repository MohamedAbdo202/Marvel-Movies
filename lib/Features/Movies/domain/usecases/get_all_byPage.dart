import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entites/Movie.dart';
import '../repoistories/Movie_repositry.dart';

class GetByPageUseCase {
  final MovieRepository repository;

  GetByPageUseCase(this.repository);

  Future<Either<Failure, List<Movie>>> call({
    required int currentPage,
    required int itemsPerPage,
  }) async {
    return await repository.getMoviesByPage(currentPage, itemsPerPage);
  }
}
