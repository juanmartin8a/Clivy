import 'package:bloc/bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:untitled_client/src/api/graphql/graphql_api.dart';
import 'package:untitled_client/src/bloc/loading/loadingUserFollow/loadingUserFollowCubit.dart';
import 'package:untitled_client/src/bloc/userFollow/userFollowState.dart';
import 'package:untitled_client/src/repos/userRepository.dart';
import 'package:untitled_client/src/utils/globalUtils.dart';

class UserFollowCubit extends Cubit<UserFollowState> {
  final LoadingUserFollowCubit loadingCubit;
  final UserRepository userRepo;
  UserFollowCubit({
    required this.loadingCubit,
    required this.userRepo
  }) : super(UserFollowInitState());
  
  void userFollowing(
    int followUserId, 
    String? cursor, 
    QueryResult? queryResult, 
    bool isFetchMore,
    String uuid,
  ) async {
    List<UserFollowing$Query$PaginatedFollow$User> followingUsers =
      queryResult != null ? UserFollowing$Query$PaginatedFollow.fromJson(
        (queryResult.data as Map<String, dynamic>)["users"]
      ).users : [];

    List<int> idsList = followingUsers
      .map((u) => u.id.toInt()).toList();

    loadingCubit.loader(true, followUserId, false, uuid);
    try {
      int limit = 20;
      final res = await userRepo.userFollowing(
        followUserId, limit, cursor, queryResult, isFetchMore, idsList
      );
      loadingCubit.loader(false, followUserId, false, uuid);
      emit(UserFollowingState(
        paginatedUsers: res.paginatedUsers,
        queryResult: res.queryResult,
        uuid: uuid,
        userId: res.paginatedUsers.userId
      ));
    } catch(e) {
      loadingCubit.loader(false, followUserId, false, uuid);
    }
  }

  void userFollowers(
    int followUserId,
    String? cursor,
    QueryResult? queryResult,
    bool isFetchMore,
    String uuid,
  ) async {
    List<UserFollowers$Query$PaginatedFollow$User> followerUsers =
      queryResult != null ? UserFollowers$Query$PaginatedFollow.fromJson(
        (queryResult.data as Map<String, dynamic>)["users"]
      ).users : [];

    List<int> idsList = followerUsers
      .map((u) => u.id.toInt()).toList();

    loadingCubit.loader(true, followUserId, true, uuid);
    try {
      int limit = 20;
      final res = await userRepo.userFollowers(
        followUserId, limit, cursor, queryResult, isFetchMore, idsList
      );
      loadingCubit.loader(false, followUserId, true, uuid);
      emit(UserFollowersState(
        paginatedUsers: res.paginatedUsers,
        queryResult: res.queryResult,
        uuid: uuid,
        userId: res.paginatedUsers.userId
      ));
    } catch(e) {
      loadingCubit.loader(false, followUserId, true, uuid);
    }
  }

  void changeUser(
    int followUserId,
    dynamic users,
    QueryResult? queryResult,
    String uuid,
    Map<String, dynamic> changeMap,
    String missingKey,
    bool isFollowers
  ) {
    Map<String, dynamic> usersJson = users.toJson();

    int index = (usersJson["users"] as List).indexWhere((user) => user["id"].toInt() == followUserId);

    for (int i = 0; i < changeMap.length; i++) {
      usersJson['users'][index][changeMap.keys.toList()[i]] = changeMap.values.toList()[i];
    }

    var changedUser;
    if (isFollowers) {
      changedUser = UserFollowers$Query$PaginatedFollow.fromJson(usersJson);
    } else {
      changedUser = UserFollowing$Query$PaginatedFollow.fromJson(usersJson);
    }

    final newQueryResult = GlobalUtils().generateQueryResult(
      QueryResultSource.network, changedUser.toJson(), missingKey // changeResponse.toJson()
    );

    if (isFollowers) {
      emit(UserFollowersState(
        paginatedUsers: changedUser,
        queryResult: newQueryResult,
        uuid: uuid,
        userId: followUserId
      ));
    } else {
      emit(UserFollowingState(
        paginatedUsers: changedUser,
        queryResult: newQueryResult,
        uuid: uuid,
        userId: followUserId
      ));
    }
  }
}