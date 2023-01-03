import 'package:equatable/equatable.dart';
import 'package:untitled_client/src/models/customMultipartFile.dart';

abstract class EditUserEvent extends Equatable {

  const EditUserEvent();

  @override
  List<Object?> get props => [];

}

class EditUserInitEvent extends EditUserEvent {}

class EditUserButtonPressedEvent extends EditUserEvent{
  final String? name;
  final String? username;
  final String? bio;
  final CustomMultipartFile? file;
  EditUserButtonPressedEvent({
    this.name,
    this.username,
    this.bio,
    this.file
  });

  @override
  List<Object?> get props => [name, username, bio, file];
}

class EditUserCheckEvent extends EditUserEvent {
  final String name;
  final String username;
  final String bio;

  final String editName;
  final String editUsername;
  final String editBio;
  final String? editFile;
  
  EditUserCheckEvent({
    required this.name,
    required this.username,
    required this.bio,
    required this.editName,
    required this.editUsername,
    required this.editBio,
    this.editFile
  });

  @override
  List<Object?> get props => [
    name, username, bio, editName, editUsername, editBio, editFile
  ];
}

class EditUserBackEvent extends EditUserEvent {}