import 'package:equatable/equatable.dart';

abstract class QueryVideogameState extends Equatable {
  const QueryVideogameState();

  @override
  List<Object?> get props => [];
}

class QueryVideogameInitState extends QueryVideogameState {}

class QueryVideogameSelectState extends QueryVideogameState {
  final int? videogameId;
  final String? videogameName;
  QueryVideogameSelectState({
    this.videogameId,
    this.videogameName
  });

  @override
  List<Object?> get props => [videogameId, videogameName];
}