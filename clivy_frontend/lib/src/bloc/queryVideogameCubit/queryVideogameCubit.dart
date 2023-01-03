import 'package:bloc/bloc.dart';
import 'package:untitled_client/src/bloc/queryVideogameCubit/queryVideogameState.dart';

class QueryVideogameCubit extends Cubit<QueryVideogameState> {
  QueryVideogameCubit() : super(QueryVideogameInitState());

  void selectQueryVideogame(int? videogameId, String? videogameName) {
    emit(QueryVideogameSelectState(
      videogameId: videogameId,
      videogameName: videogameName
    ));
  }
}