import 'package:equatable/equatable.dart';
import 'package:untitled_client/src/api/graphql/graphql_api.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

class UserInitState extends UserState {}

class UserLoadedState extends UserState {
  final User$Query$User user;
  final bool isMyProfile;
  final bool isNotEdit;
  final String? id;
  UserLoadedState({
    required this.user,
    required this.isMyProfile,
    this.isNotEdit = false,
    this.id
  });

  @override
  List<Object?> get props => [user, isMyProfile, isNotEdit, id];
}

// class UserErrorState extends UserState {
//   final String error;
//   UserErrorState({
//     required this.error
//   });

//   @override
//   List<Object?> get props => [error];
// }