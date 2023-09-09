import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entites/Movie.dart';
import '../entites/TvShow.dart';
import '../repoistories/Movie_repositry.dart';

class GetByPageTvUseCase {
  final MovieRepository repository;

  GetByPageTvUseCase(this.repository);

  Future<Either<Failure, List<TvShow>>> call({
    required int currentPageTv,
    required int itemsPerPageTv,
  }) async {
    return await repository.getTvByPage(currentPageTv, itemsPerPageTv);
  }
}
