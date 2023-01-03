import 'package:bloc/bloc.dart';
import 'package:untitled_client/src/bloc/userTagAutocomplete/userTagAutocompleteState.dart';
import 'package:uuid/uuid.dart';

class UserTagAutocompleteCubit extends Cubit<UserTagAutocompleteState> {
  UserTagAutocompleteCubit() : super(UserTagAutocompleteInitState());
  
  void autocompleteUserTag(String id, int userId, String username) {
    emit(AutocompleteUserTagState(
      id: id,
      userId: userId,
      username: username,
      randomId: Uuid().v4()
    ));
  }
}