import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled_client/src/bloc/me/meBloc.dart';
import 'package:untitled_client/src/bloc/me/meEvent.dart';
import 'package:untitled_client/src/bloc/videogames/videogamesState.dart';
import 'package:untitled_client/src/repos/videogamesRepository.dart';
import 'package:uuid/uuid.dart';

class VideogamesCubit extends Cubit<VideogameState> {
  final VideogamesRepository videogameRepo;
  final MeBloc meBloc;
  VideogamesCubit({
    required this.videogameRepo,
    required this.meBloc,
  }) : super(VideogamesInitState());

  void fetchVideogames() async {
    final videogames = await videogameRepo.getAllVideogames();
    emit(FetchByPostCountVideogamesState(
      videogames: videogames
    ));
  }

  void fetchVideogameGenres() async {
    final videogameGenres = await videogameRepo.getAllVideogameGenres();
    emit(FetchVideogameGenresState(
      videogameGenres: videogameGenres
    ));
  }

  void fetchTapVideogames() async {
    final videogames = await videogameRepo.getAllTapsVideogame();
    emit(FetchByTapCountVideogamesState(
      videogames: videogames
    ));
  }

  void selectVideogameGenre(String id, bool exists) {
    emit(SelectVideogameGenreState(
      id: id,
      isSelect: !exists
    ));
  }

  void addUserInterests(List<int> videogameGenreIds) async {
    try {
      await videogameRepo.addUserInterests(videogameGenreIds);
      emit(AddUserInterestsState(
        uuid: Uuid().v4(),
        isDone: true,
      ));
      meBloc.add(MeSignInEvent());
    } catch(e) {
      print(e);
      emit(AddUserInterestsState(
        uuid: Uuid().v4(),
        isDone: false,
      ));
    }
  }
}