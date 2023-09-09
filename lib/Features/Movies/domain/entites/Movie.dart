import 'package:equatable/equatable.dart';

class Movie extends Equatable{
  final int id;
  final String title;
  final String releaseDate;
  final String boxOffice;
  final int duration;
  final String ?overview;
  final String coverUrl;
  final String ? trailerUrl;
  final String directedBy;
  final int phase;
  final String saga;
  final int chronology;
  final int postCreditScenes;
  final String imdbId;
  final DateTime updatedAt;

  const Movie({
    required this.id,
    required this.title,
    required this.releaseDate,
    required this.boxOffice,
    required this.duration,
    required this.overview,
    required this.coverUrl,
    required this.trailerUrl,
    required this.directedBy,
    required this.phase,
    required this.saga,
    required this.chronology,
    required this.postCreditScenes,
    required this.imdbId,
    required this.updatedAt,
  });
  @override
  List<Object?> get props => [id, title, releaseDate,boxOffice,duration,overview,coverUrl,trailerUrl,directedBy,phase,saga,chronology,postCreditScenes,imdbId,updatedAt];
}
