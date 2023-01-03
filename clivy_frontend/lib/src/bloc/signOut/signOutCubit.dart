import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:untitled_client/src/bloc/me/meBloc.dart';
import 'package:untitled_client/src/bloc/me/meEvent.dart';
import 'package:untitled_client/src/bloc/signOut/signOutState.dart';
import 'package:untitled_client/src/repos/userRepository.dart';
import 'package:untitled_client/src/ui/wrapper.dart';

class SignOutCubit extends Cubit<SignOutState> {
  final UserRepository userRepo;
  final MeBloc meBloc;

  SignOutCubit({
    required this.userRepo,
    required this.meBloc
  }) : super(SignOutInitialState());

  void signOut() async {
    try {
      emit(SignOutLoadingState());
      final signOut = await userRepo.signOut();
      if (signOut.signOut != true) {
        emit(SignOutFailedState());
      } else {
        Get.offAll(Wrapper());
        meBloc.add(MeSignOutEvent());
        await HiveStore().reset();
        emit(SignOutSuccessState());
      }
    } catch(e) {
      emit(SignOutFailedState());
    }
  }

}