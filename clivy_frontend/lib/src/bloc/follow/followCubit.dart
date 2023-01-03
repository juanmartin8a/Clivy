import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled_client/src/bloc/follow/followState.dart';
import 'package:untitled_client/src/repos/userRepository.dart';
import 'package:uuid/uuid.dart';

class FollowCubit extends Cubit<FollowState> {
  final UserRepository userRepo;
  FollowCubit({
    required this.userRepo
  }) : super(FollowInitState());

  void followUnfollowUser({
    required int userId,
    required bool isFollow
  }) async {
    try {
      String newClientId = Uuid().v4();
      if (!isFollow) {
        emit(FollowUserState(
          userId: userId,
          isPre: true,
          clientId: newClientId
        ));
      } else {
        emit(UnfollowUserState(
          userId: userId,
          isPre: true,
          clientId: newClientId
        ));
      } 
      final followRes = await userRepo.followUnfollowUser(userId, newClientId);
      if (followRes.value == 1) {
        emit(FollowUserState(
          userId: userId,
          clientId: followRes.clientId!
        ));
      } else if (followRes.value == -1) {
        emit(UnfollowUserState(
          userId: userId,
          clientId: followRes.clientId!
        ));
      } 
    } catch (err) {
      print("salsachoque error $err");
    }
  }
}