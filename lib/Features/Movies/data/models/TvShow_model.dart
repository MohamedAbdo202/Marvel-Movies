
import '../../domain/entites/TvShow.dart';

class TvShowModel extends TvShow {
  TvShowModel({
    required super.id,
    required super.title,
    required super.releaseDate,
    required super.season,
    required super.last_aired_date,
    required super.overview,
    required super.coverUrl,
    required super.trailerUrl,
    required super.directedBy,
    required super.number_episodes,
    required super.phase,
    required super.saga,
    required super.imdbId,
    required super.trailer_url,
  });

  factory TvShowModel.fromJson(Map<String, dynamic> json) {
    return TvShowModel(
      id: json['id'],
      title: json['title'],
      releaseDate: json['release_date'],
      season: json['season'],
      last_aired_date: json['last_aired_date'],
      overview: json['overview'],
      coverUrl: json['cover_url'],
      trailerUrl: json['trailer_url'],
      directedBy: json['directed_by'],
      number_episodes: json['number_episodes'],
      phase: json['phase'],
      saga: json['saga'],
      imdbId: json['imdb_id'] as String,
      trailer_url: json['trailer_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'release_date': releaseDate,
      'season': season,
      'last_aired_date': last_aired_date,
      'overview': overview,
      'cover_url': coverUrl,
      'trailer_url': trailerUrl,
      'directed_by': directedBy,
      'number_episodes': number_episodes,
      'phase': phase,
      'saga': saga,
      'imdb_id': imdbId,
      'trailer_url': trailer_url,
    };
  }
}
