
import 'package:equatable/equatable.dart';

abstract class MeEvent extends Equatable {
  const MeEvent();

  @override
  List<Object?> get props => [];
}

class MeInitEvent extends MeEvent {}

class MeSignInEvent extends MeEvent {}

class MeSignOutEvent extends MeEvent {}