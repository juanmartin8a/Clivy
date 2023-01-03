import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:untitled_client/src/api/graphql/graphql_api.dart';
import 'package:untitled_client/src/bloc/follow/followCubit.dart';
import 'package:untitled_client/src/bloc/follow/followState.dart';
import 'package:untitled_client/src/bloc/loading/loadingNotifications/loadingNotificationsCubit.dart';
import 'package:untitled_client/src/bloc/loading/loadingNotifications/loadingNotificationsState.dart';
import 'package:untitled_client/src/bloc/notifications/notificationsCubit.dart';
import 'package:untitled_client/src/bloc/notifications/notificationsState.dart';
import 'package:untitled_client/src/ui/helpers/loader.dart';
import 'package:untitled_client/src/ui/screens/activity/notification.dart';

class Activity extends StatefulWidget {
  const Activity({ Key? key }) : super(key: key);

  @override
  _ActivityState createState() => _ActivityState();
}

class _ActivityState extends State<Activity> with AutomaticKeepAliveClientMixin {

  Notifications$Query$PaginatedNotifications? paginatedNotifications;
  QueryResult? queryResult;
  bool loading = false;
  bool hasMore = true;

  late NotificationsCubit _notificationsCubit;

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    _notificationsCubit = BlocProvider.of<NotificationsCubit>(context);
    _notificationsCubit.fetchNotifications(
      1,
      null,
      false
    );
    scrollController.addListener(() {
      scrollControllerListener();
    });
    BlocProvider.of<FollowCubit>(context).stream.listen((state)  {
      if (state is FollowUserState || state is UnfollowUserState) {
        if (queryResult != null) {
          List<dynamic> modifiedNotificationsList = paginatedNotifications!.notifications.where((notification) => notification.type == "follow").toList();
          List<dynamic> idsFollowerList = modifiedNotificationsList.map((notification) => notification.followNotification!.follower.id.toInt()).toList();

          int? followCubitUserId;
          var isFollow;

          if (state is FollowUserState) {
            followCubitUserId = state.userId;
            isFollow = true;
          } else if (state is UnfollowUserState) {
            followCubitUserId = state.userId;
            isFollow = false;
          }


          if (idsFollowerList.contains(followCubitUserId)) {
            _notificationsCubit.changeUser(
              followCubitUserId!,
              paginatedNotifications!,
              queryResult,
              {
                "followState": isFollow,
              },
              "notifications",
            );
          }
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      top: true,
      bottom: false,
      left: false,
      right: false,
      child: Material(
        color: Colors.black,
        child: Container(
          child: Column(
            children: [
              SizedBox(height: 50),
              Expanded(
                child: Container(
                  child: BlocBuilder<NotificationsCubit, NotificationsState>(
                    builder: (context, state) {
                      if (state is NotificationsLoadedState) {
                        paginatedNotifications = state.notifications;
                        hasMore = state.notifications.hasMore;
                        queryResult = state.queryResult;
                      }
                      return ListView(
                        padding: EdgeInsets.zero,
                        controller: scrollController,
                        physics: AlwaysScrollableScrollPhysics(),
                        children: [
                          if (paginatedNotifications != null) 
                          ...paginatedNotifications!.notifications.map((notification) {
                            return NotificationWidget(
                              notification: notification,
                              id: "${notification.parentId}-${notification.type}",
                              type: notification.type,
                              key: Key("notification_${notification.parentId}-${notification.type}")
                            );
                          }).toList(),
                          Container(
                            child: BlocConsumer<LoadingNotificationsCubit, LoadingNotificationsState>(
                              listener: (context, loadingState) {
                                if (
                                  loadingState is GetNotificationsLoadingState
                                ) {
                                  loading = true;
                                } else if (
                                  loadingState is GetNotificationsLoadedState
                                ) {
                                  loading = false;
                                }
                              },
                              builder: (context, loadingState) {
                                if (
                                  loadingState is GetNotificationsLoadingState
                                ) {
                                  return Loader();
                                }
                                return Container();
                              }
                            )
                          ),
                        ]
                      );
                    }
                  ),
                )
              )
            ],
          )
        ),
      ),
    );
  }

  void scrollControllerListener() {
    if (paginatedNotifications != null && paginatedNotifications!.notifications.isNotEmpty) {
      double currentPosition = scrollController.position.pixels;
      double maxPosition = scrollController.position.maxScrollExtent;
      double threshold = MediaQuery.of(context).size.height * 1.5;
      if ((maxPosition - currentPosition) <= threshold) {
        if (hasMore == true && loading == false) {
          loading = true;
          _notificationsCubit.fetchNotifications(
            1, 
            queryResult, 
            true
          );
        }
      }
    }
  }

  @override
  bool get wantKeepAlive => true;
}