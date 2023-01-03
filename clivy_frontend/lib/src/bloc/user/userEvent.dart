import 'package:equatable/equatable.dart';
import 'package:untitled_client/src/api/graphql/graphql_api.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class UserInitEvent extends UserEvent {}

class FetchUserEvent extends UserEvent {
  final int userId;
  final String id;
  FetchUserEvent({
    required this.userId,
    required this.id,
  });

  @override
  List<Object?> get props => [userId, id];
}

class UpdateUserEvent extends UserEvent {
  final User$Query$User user;
  UpdateUserEvent({
    required this.user
  });

  @override
  List<Object?> get props => [user];
}

class ChangeUserEvent extends UserEvent {
  final User$Query$User user;
  final int userId;
  final Map<String, dynamic> changeMap;
  // final dynamic changeFieldVal;
  final String uuid;
  // final String missingKey;
  ChangeUserEvent({
    required this.user,
    required this.userId,
    required this.changeMap,
    // required this.changeFieldVal,
    required this.uuid
  });

  @override
  List<Object?> get props => [user, userId, changeMap, uuid];
}