import 'package:equatable/equatable.dart';

abstract class LoadingNotificationsState extends Equatable {
  const LoadingNotificationsState();

  @override
  List<Object?> get props => [];
}

class LoadingNotificationsInitState extends LoadingNotificationsState {}

class GetNotificationsLoadingState extends LoadingNotificationsState {}

class GetNotificationsLoadedState extends LoadingNotificationsState {}