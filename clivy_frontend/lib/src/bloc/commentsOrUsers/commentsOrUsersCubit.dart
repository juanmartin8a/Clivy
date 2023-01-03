import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled_client/src/bloc/commentsOrUsers/commentsOrUsersState.dart';

class CommentsOrUsersCubit extends Cubit<CommentsOrUsersState> {
  CommentsOrUsersCubit() : super(CommentsOrUsersInitState());

  void setComments(String id) {
    emit(SetCommentsState(id: id));
  }

  void setUsers(String id) {
    emit(SetUsersState(id: id));
  }
}