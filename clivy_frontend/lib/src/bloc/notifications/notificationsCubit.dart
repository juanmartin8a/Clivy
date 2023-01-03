import 'package:bloc/bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:untitled_client/src/api/graphql/graphql_api.dart';
import 'package:untitled_client/src/bloc/loading/loadingNotifications/loadingNotificationsCubit.dart';
import 'package:untitled_client/src/bloc/notifications/notificationsState.dart';
import 'package:untitled_client/src/repos/notificationRepository.dart';
import 'package:untitled_client/src/utils/globalUtils.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  final NotificationRepository notificationRepo;
  final LoadingNotificationsCubit loadingCubit;
  NotificationsCubit({
    required this.notificationRepo,
    required this.loadingCubit
  }) : super(NotificationsInitState());
  
  void fetchNotifications(
    int limit,
    QueryResult? queryResult,
    bool isFetchMore,
  ) async {
    List<Notifications$Query$PaginatedNotifications$Notification> notifications =
      queryResult != null ? Notifications$Query$PaginatedNotifications.fromJson(
        (queryResult.data as Map<String, dynamic>)["notifications"]
      ).notifications : [];

    List<String> idsList = notifications
      .map((n) => n.concatenatedId).toList();
    try {
      loadingCubit.loader(true);
      final notificationsResponse = await notificationRepo.notifications(limit, queryResult, isFetchMore, idsList);
      loadingCubit.loader(false);
      emit(NotificationsLoadedState(
        notifications: notificationsResponse.paginatedNotifications,
        queryResult: notificationsResponse.queryResult
      ));
    } catch(e) {
      loadingCubit.loader(false);
      // print("error $e");
    }
  }

  void changeUser(
    int followUserId,
    dynamic notifications,
    QueryResult? queryResult,
    Map<String, dynamic> changeMap,
    String missingKey,
  ) {
    Map<String, dynamic> notificationsJson = notifications.toJson();

    int index = (notificationsJson["notifications"] as List).indexWhere((notification) => notification["followNotification"]["follower"]["id"].toInt() == followUserId);

    for (int i = 0; i < changeMap.length; i++) {
      notificationsJson['notifications'][index]["followNotification"]["follower"][changeMap.keys.toList()[i]] = changeMap.values.toList()[i];
    }

    var changedNotifications = Notifications$Query$PaginatedNotifications.fromJson(notificationsJson);

    final newQueryResult = GlobalUtils().generateQueryResult(
      QueryResultSource.network, changedNotifications.toJson(), missingKey // changeResponse.toJson()
    );

    emit(NotificationsLoadedState(
      notifications: changedNotifications,
      queryResult: newQueryResult,
    ));
  }
}