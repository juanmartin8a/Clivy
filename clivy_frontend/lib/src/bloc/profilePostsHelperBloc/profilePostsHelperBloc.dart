import 'package:bloc/bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:untitled_client/src/api/graphql/graphql_api.dart';
import 'package:untitled_client/src/bloc/profilePostsHelperBloc/profilePostsHelperState.dart';

class ProfilePostsHelperCubit extends Cubit<ProfilePostsHelperState> {
  ProfilePostsHelperCubit() : super(ProfilePostsHelperInitState());

  void posts(
    String uuid,
    UserPosts$Query$PaginatedPosts newPosts,
    QueryResult newQueryResult,
  ) {
    emit(ProfilePostsHelperPostsState(
      uuid: uuid,
      newPosts: newPosts,
      newQueryResult: newQueryResult,
    ));
  }

}