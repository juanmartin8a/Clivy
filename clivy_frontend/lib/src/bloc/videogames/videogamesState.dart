
import 'package:equatable/equatable.dart';
import 'package:untitled_client/src/api/graphql/graphql_api.dart';

abstract class VideogameState extends Equatable {
  const VideogameState();

  @override
  List<Object?> get props => [];
}

class VideogamesInitState extends VideogameState {}

class FetchByPostCountVideogamesState extends VideogameState {
  final AllVideogames$Query videogames;
  const FetchByPostCountVideogamesState({
    required this.videogames
  });

  @override
  List<Object?> get props => [videogames];
}

class FetchByTapCountVideogamesState extends VideogameState {
  final AllTapsVideogames$Query videogames;
  const FetchByTapCountVideogamesState({
    required this.videogames
  });

  @override
  List<Object?> get props => [videogames];
}

class FetchVideogameGenresState extends VideogameState {
  final AllVideogameGenres$Query videogameGenres;
  const FetchVideogameGenresState({
    required this.videogameGenres
  });

  @override
  List<Object?> get props => [videogameGenres];
}

class SelectVideogameGenreState extends VideogameState {
  final String id;
  final bool isSelect;
  const SelectVideogameGenreState({
    required this.id,
    this.isSelect = true
  });

  @override
  List<Object?> get props => [id, isSelect];
}

class AddUserInterestsState extends VideogameState {
  final String uuid;
  final bool isDone;
  const AddUserInterestsState({
    required this.uuid,
    required this.isDone
  });

  @override
  List<Object?> get props => [uuid, isDone];
}