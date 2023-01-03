import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:untitled_client/src/api/graphql/graphql_api.dart';
import 'package:untitled_client/src/bloc/follow/followCubit.dart';
import 'package:untitled_client/src/bloc/follow/followState.dart';
import 'package:untitled_client/src/bloc/loading/loadingUserFollow/loadingUserFollowCubit.dart';
import 'package:untitled_client/src/bloc/loading/loadingUserFollow/loadingUserFollowState.dart';
import 'package:untitled_client/src/bloc/userFollow/userFollowCubit.dart';
import 'package:untitled_client/src/bloc/userFollow/userFollowState.dart';
import 'package:untitled_client/src/ui/helpers/loader.dart';
import 'package:untitled_client/src/ui/screens/home/widgets/floatingActions.dart';
import 'package:untitled_client/src/ui/screens/user/widgets/userFollowTile.dart';
import 'package:uuid/uuid.dart';

class UserFollowers extends StatefulWidget {
  final int id;
  const UserFollowers({ 
    required this.id,
    required Key key  
  }) : super(key: key);

  @override
  _UserFollowersState createState() => _UserFollowersState();
}

class _UserFollowersState extends State<UserFollowers> {
  String uuid = Uuid().v4();

  late UserFollowCubit userFollowCubit;
  bool loading = false;
  UserFollowers$Query$PaginatedFollow? paginatedUsers;
  QueryResult? queryResult;
  bool hasMore = true;

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    userFollowCubit = BlocProvider.of<UserFollowCubit>(context);
    userFollowCubit.userFollowers(
      widget.id, null, queryResult, false, uuid, 
    );
    scrollController.addListener(() {
      scrollControllerListener();
    });
    BlocProvider.of<FollowCubit>(context).stream.listen((state) {
      if (state is FollowUserState || state is UnfollowUserState) {
        if (queryResult != null) {
          List<dynamic> idsUserList = paginatedUsers!.users.map((user) => user.id.toInt()).toList();

          int? followCubitUserId;
          var isFollow;

          if (state is FollowUserState) {
            followCubitUserId = state.userId;
            isFollow = true;
          } else if (state is UnfollowUserState) {
            followCubitUserId = state.userId;
            isFollow = false;
          }

          if (idsUserList.contains(followCubitUserId)) {
            userFollowCubit.changeUser(
              followCubitUserId!,
              paginatedUsers!,
              queryResult,
              uuid,
              {
                "followState": isFollow,
              },
              "userFollowers",
              true
            );
          }
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Container(
            child: FloatingActions(
              icon: EvaIcons.arrowBackOutline,
              size: 36,
              key: Key("goBack")
            ),
          ),
        ),
        title: Container(
          child: Text(
            'Followers',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w700
            )
          )
        )
      ),
      body: Container(
        child: BlocBuilder<UserFollowCubit, UserFollowState>(
          builder: (context, state) {
            if (state is UserFollowersState) {
              if (state.uuid == uuid) {
                paginatedUsers = state.paginatedUsers;
                hasMore = state.paginatedUsers.hasMore;
                queryResult = state.queryResult;
              }
            }
            return Container(
              child: ListView(
                controller: scrollController,
                physics: AlwaysScrollableScrollPhysics(),
                children: [
                  if (paginatedUsers != null) 
                  ...paginatedUsers!.users.map((user) {
                    return UserFollowTile(
                      user: user,
                      key: Key("userFollowers_${widget.id}_${user.id}")
                    );
                  }).toList(),
                  Container(
                    child: BlocConsumer<LoadingUserFollowCubit, LoadingUserFollowState>(
                      listener: (context, loadingState) {
                        if (
                          loadingState is GetUserFollowLoadingState &&
                          loadingState.userId == widget.id &&
                          loadingState.uuid == uuid &&
                          loadingState.isFollowers == true
                        ) {
                          loading = true;
                        } else if (
                          loadingState is GetUserFollowLoadedState &&
                          loadingState.userId == widget.id &&
                          loadingState.uuid == uuid &&
                          loadingState.isFollowers == true
                        ) {
                          loading = false;
                        }
                      },
                      builder: (context, loadingState) {
                        if (
                          loadingState is GetUserFollowLoadingState &&
                          loadingState.userId == widget.id &&
                          loadingState.uuid == uuid &&
                          loadingState.isFollowers == true
                        ) {
                          return Loader();
                        }
                        return Container();
                      }
                    )
                  ),
                ],
              )
            );
          }
        )
      )
    );
  }

  void scrollControllerListener() {
    if (paginatedUsers != null && paginatedUsers!.users.isNotEmpty) {
      double currentPosition = scrollController.position.pixels;
      double maxPosition = scrollController.position.maxScrollExtent;
      double threshold = MediaQuery.of(context).size.height * 1.5;
      if ((maxPosition - currentPosition) <= threshold) {
        if (hasMore == true && loading == false) {
          loading = true;
          userFollowCubit.userFollowers(
            widget.id,
            paginatedUsers!.users[paginatedUsers!.users.length - 1].createdAt,
            queryResult, 
            true, 
            uuid
          );
        }
      }
    }
  }
}