import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:untitled_client/src/api/graphql/graphql_api.dart';

class NotificationOptions {

  NotificationsQuery notificationsQuery(int limit, List<String> idsList) {
    NotificationsQuery notificationsQuery = NotificationsQuery(
      variables: NotificationsArguments(
        limit: limit,
        idsList: idsList
      )
    );

    return notificationsQuery;
  }

  QueryOptions notificationQueryOptions(int limit, List<String> idsList) {
    QueryOptions queryOptions = QueryOptions(
      document: notificationsQuery(limit, idsList).document,
      variables: {
        "limit": limit,
        "idsList": idsList
      },
      fetchPolicy: FetchPolicy.noCache
    );

    return queryOptions;
  }

  FetchMoreOptions getMoreNotificationsQueryOptions(
    int limit, List<String> idsList
  ) {
    FetchMoreOptions queryOptions = FetchMoreOptions(
      document: notificationsQuery(
        limit, idsList
      ).document,
      variables: { 
        "limit": limit,
        "idsList": idsList
      },
      updateQuery: (prevData, newData) {
        final List<dynamic> notifications = [
          ...prevData!['notifications']['notifications'] as List<dynamic>,
          ...newData!['notifications']['notifications'] as List<dynamic>
        ];

        newData['notifications']['notifications'] = notifications;

        return newData;
      },
    );

    return queryOptions;
  }
}