import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hive/hive.dart';
import 'package:untitled_client/src/bloc/me/meBloc.dart';
import 'package:untitled_client/src/bloc/signUp/signUpState.dart';
import 'package:untitled_client/src/repos/userRepository.dart';
import 'package:uuid/uuid.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final UserRepository userRepo;
  final MeBloc meBloc;

  SignUpCubit({
    required this.userRepo,
    required this.meBloc
  }) : super(SignUpInitState());

  String? birthday;

  void signUp({
    required String name,
    required String username,
    required String email,
    required String password
  }) async {
    emit(SignUpLoadingState());
    try {
      FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
      String? token = await firebaseMessaging.getToken();
      bool? platformIsIOS;

      if (token != null) {
        platformIsIOS = Platform.isIOS;
      }
      
      final signUp = await userRepo.signUserUp(
        name,
        username,
        email,
        password,
        birthday!,
        token,
        platformIsIOS
      );
      if (signUp.errors != null) {
        print("errorsssss");
        emit(SignUpFieldErrorState(
          errors: signUp.errors!
        ));
      } else {
        Box hiveBox = Hive.box("deviceTokenBox");
        await hiveBox.put('deviceToken', token);
        // meBloc.add(MeSignInEvent());
        emit(SignUpCompleteState(
          signUpResponse: signUp,
        ));
      }
    } catch (err) {
      emit(SignUpErrorState());
    }
  }

  void next(int index, String? birthdayNext) {
    if (index == 1) {
      birthday = birthdayNext;
    }
    emit(SignUpNextState(
      uuid: Uuid().v4(),
      index: index,
    ));
  }
}