import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:untitled_client/src/api/graphql/graphql_api.dart';
import 'package:untitled_client/src/utils/notifications/notificationOptions.dart';
import 'package:untitled_client/src/utils/posts/postTypes.dart';

class NotificationRepository {
  final GraphQLClient client;
  NotificationRepository({
    required this.client,
  });

  Future<NotificationsResponse> notifications(
    int limit, 
    QueryResult? notificationsQueryResult, 
    bool isFetchMore,
    List<String> idsList
  ) async {
    QueryResult? result;
    if (isFetchMore) {
      result = await client.fetchMore(
        NotificationOptions().getMoreNotificationsQueryOptions(limit, idsList),
        originalOptions: NotificationOptions().notificationQueryOptions(limit, idsList),
        previousResult: notificationsQueryResult!
      );
    } else {
      result = await client.query(
        NotificationOptions().notificationQueryOptions(limit, idsList)
      );
    }

    if (result.hasException) {
      throw (result.exception as OperationException);
    } else {
       Map<String, dynamic> notificationsAndQueryResult = {
        "paginatedNotifications": Notifications$Query$PaginatedNotifications.fromJson(
          (result.data as Map<String, dynamic>)["notifications"]
        ),
        "queryResult": result
      };
      // print(result.data);
      return NotificationsResponse.fromJson(notificationsAndQueryResult);
    }
  }
}