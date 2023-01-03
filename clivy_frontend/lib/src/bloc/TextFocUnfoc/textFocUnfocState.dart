import 'package:equatable/equatable.dart';

abstract class TextFocusUnfocusState extends Equatable {
  const TextFocusUnfocusState();

  @override
  List<Object?> get props => [];
}

class TextUnfocusState extends TextFocusUnfocusState {}

class TextFocusState extends TextFocusUnfocusState {}