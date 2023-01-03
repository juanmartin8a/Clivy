import 'package:equatable/equatable.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:untitled_client/src/api/graphql/graphql_api.dart';

abstract class NotificationsState extends Equatable {
  const NotificationsState();

  @override
  List<Object?> get props => [];
}

class NotificationsInitState extends NotificationsState {}

class NotificationsLoadedState extends NotificationsState {
  final Notifications$Query$PaginatedNotifications notifications;
  final QueryResult queryResult;
  NotificationsLoadedState({
    required this.notifications,
    required this.queryResult
  });

  @override
  List<Object?> get props => [notifications, queryResult];
}