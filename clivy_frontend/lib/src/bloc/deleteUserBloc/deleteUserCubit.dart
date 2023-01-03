import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:untitled_client/src/bloc/deleteUserBloc/deleteUserState.dart';
import 'package:untitled_client/src/bloc/me/meBloc.dart';
import 'package:untitled_client/src/bloc/me/meEvent.dart';
import 'package:untitled_client/src/models/currentUser.dart';
import 'package:untitled_client/src/repos/userRepository.dart';
import 'package:untitled_client/src/ui/wrapper.dart';
import 'package:uuid/uuid.dart';

class DeleteUserCubit extends Cubit<DeleteUserState> {
  final UserRepository userRepo;
  final MeBloc meBloc;
  DeleteUserCubit({
    required this.userRepo,
    required this.meBloc,
  }) : super(DeleteUserInitState(uuid: Uuid().v4()));

  void deleteUser() async {
    emit(DeleteUserLoadingState(uuid: Uuid().v4()));
    try {
      if (CurrentUser.user != null) {
        await userRepo.deleteUser();
      }
      emit(DeleteUserDeletedState(uuid: Uuid().v4()));
      // emit(DeleteUserErrorState(uuid: Uuid().v4()));
      meBloc.add(MeSignOutEvent());
      Get.offAll(Wrapper());
      await HiveStore().reset();
    } catch(e) {
      // print(e);
      emit(DeleteUserErrorState(uuid: Uuid().v4()));
    }
  }

  void changeToInit() {
    emit(DeleteUserInitState(uuid: Uuid().v4()));
  }
}