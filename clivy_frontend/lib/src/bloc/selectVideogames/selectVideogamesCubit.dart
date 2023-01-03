import 'package:bloc/bloc.dart';
import 'package:untitled_client/src/api/graphql/graphql_api.dart';
import 'package:untitled_client/src/bloc/selectVideogames/selectVideogamesState.dart';

class SelectVideogamesCubit extends Cubit<SelectVideogameState> {
  SelectVideogamesCubit() : super(SelectVideogameInitState());

  void selectVideogame(
    int id, 
    String file,
    String name,
    List<AllVideogames$Query$Videogame$VideogameGenreVideogame> genreList,
    bool isSelect
  ) {
    if (isSelect) {
      List<int> newGenreList = [];
      genreList.forEach((element) {
        newGenreList.add(element.videogameGenre.id);
      });
      emit(VideogameSelectedState(
        id: id,
        file: file,
        genreList: newGenreList,
        name: name
      ));
    } else {
      emit(RemoveSelectedVideogameState(
        id: id,
        file: file,
        genreList: [],
        name: name
      ));
    }
  }

  void selectGenre(
    int id, 
    String name,
    List<int> genreList,
    bool isSelect
  ) {
    if (isSelect) {
      List<int> newGenreList = [];
      newGenreList = genreList;
      newGenreList.add(id);
      emit(GenreSelectedState(
        id: id,
        name: name,
        genreList: newGenreList
      ));
    } else {
      List<int> newGenreList = [];
      newGenreList = genreList;
      newGenreList.removeWhere((element) => element == id);
      emit(RemoveSelectedGenreState(
        id: id,
        name: name,
        genreList: newGenreList
      ));
    }
  }
}