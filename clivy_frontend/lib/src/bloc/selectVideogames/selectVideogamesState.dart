import 'package:equatable/equatable.dart';
import 'package:untitled_client/src/api/graphql/graphql_api.dart';

abstract class SelectVideogameState extends Equatable {
  const SelectVideogameState();

  @override
  List<Object?> get props => [];
}

class SelectVideogameInitState extends SelectVideogameState {}

class VideogameSelectedState extends SelectVideogameState {
  final int id;
  final String? file;
  final String name;
  final List<int> genreList;
  VideogameSelectedState({
    required this.id,
    required this.file,
    required this.name,
    required this.genreList
  });

  @override
  List<Object?> get props => [id, file, name, genreList];
}

class RemoveSelectedVideogameState extends SelectVideogameState {
  final int id;
  final String file;
  final String name;
  final List<int> genreList;
  RemoveSelectedVideogameState({
    required this.id,
    required this.file,
    required this.name,
    required this.genreList
  });

  @override
  List<Object?> get props => [id, file, name, genreList];
}

class GenreSelectedState extends SelectVideogameState {
  final int id;
  final String name;
  final List<int> genreList;
  GenreSelectedState({
    required this.id,
    required this.name,
    required this.genreList
  });

  @override
  List<Object?> get props => [id, name, genreList];
}

class RemoveSelectedGenreState extends SelectVideogameState {
  final int id;
  final String name;
  final List<int> genreList;
  RemoveSelectedGenreState({
    required this.id,
    required this.name,
    required this.genreList
  });

  @override
  List<Object?> get props => [id, name, genreList];
}