import 'package:movie_task/Features/Movies/domain/entites/Movie.dart';

class MovieModel extends Movie{
  MovieModel({required super.id, required super.title, required super.releaseDate, required super.boxOffice, required super.duration, required super.overview, required super.coverUrl, required super.trailerUrl, required super.directedBy, required super.phase, required super.saga, required super.chronology, required super.postCreditScenes, required super.imdbId, required super.updatedAt});

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'] ,
      title: json['title'] ,
      releaseDate: json['release_date'],
      boxOffice: json['box_office'] ,
      duration: json['duration'] ,
      overview: json['overview'] ,
      coverUrl: json['cover_url'] ,
      trailerUrl: json['trailer_url'] ,
      directedBy: json['directed_by'] ,
      phase: json['phase'] ,
      saga: json['saga'] ,
      chronology: json['chronology'] ,
      postCreditScenes: json['post_credit_scenes'],
      imdbId: json['imdb_id'] as String,
      updatedAt: DateTime.parse(json['updated_at'] ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'release_date': releaseDate,
      'box_office': boxOffice,
      'duration': duration,
      'overview': overview,
      'cover_url': coverUrl,
      'trailer_url': trailerUrl,
      'directed_by': directedBy,
      'phase': phase,
      'saga': saga,
      'chronology': chronology,
      'post_credit_scenes': postCreditScenes,
      'imdb_id': imdbId,
      'updated_at': updatedAt.toIso8601String(),
    };  }
}