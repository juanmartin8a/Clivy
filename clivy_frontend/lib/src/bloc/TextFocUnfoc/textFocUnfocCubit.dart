import 'package:bloc/bloc.dart';
import 'package:untitled_client/src/bloc/TextFocUnfoc/textFocUnfocState.dart';

class TextFocusUnfocusCubit extends Cubit<TextFocusUnfocusState> {
  TextFocusUnfocusCubit() : super(TextUnfocusState());

  void focusUnfocus(bool isFocus) async {
    if (isFocus) {
      emit(TextFocusState());
    } else {
      emit(TextUnfocusState());
    }
  }
}