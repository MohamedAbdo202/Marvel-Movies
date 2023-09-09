import 'package:equatable/equatable.dart';

class TvShow extends Equatable{
  final int id;
  final String title;
  final String ? releaseDate;
  final int season;
  final String ? last_aired_date;
  final String ?overview;
  final String coverUrl;
  final String ? trailerUrl;
  final String ? directedBy;
  final int number_episodes;
  final int phase;
  final String saga;
  final String imdbId;
  final String ? trailer_url;

  const TvShow({
    required this.id,
    required this.title,
    required this.releaseDate,
    required this.season,
    required this.last_aired_date,
    required this.overview,
    required this.coverUrl,
    required this.trailerUrl,
    required this.directedBy,
    required this.number_episodes,
    required this.phase,

    required this.saga,
    required this.imdbId,
    required this.trailer_url,
  });
  @override
  List<Object?> get props => [id, title, releaseDate,last_aired_date,number_episodes,overview,coverUrl,trailerUrl,directedBy,phase,saga,imdbId,trailer_url];
}
