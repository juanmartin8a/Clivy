import 'package:equatable/equatable.dart';

abstract class HomeAppBarState extends Equatable {
  const HomeAppBarState();

  @override
  List<Object?> get props => [];
}

class HomeAppBarInitState extends HomeAppBarState {}

class HomeAppBarChangePageState extends HomeAppBarState {
  final double clivyOpacity;
  final double usernameOpacity;
  final double activityOpacity;
  final double createClipOpacity;
  HomeAppBarChangePageState({
    required this.clivyOpacity,
    required this.usernameOpacity,
    required this.activityOpacity,
    required this.createClipOpacity
  });

  @override
  List<Object?> get props => [clivyOpacity, usernameOpacity, activityOpacity, createClipOpacity];
}