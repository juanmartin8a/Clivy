import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:untitled_client/src/bloc/me/meBloc.dart';
import 'package:untitled_client/src/bloc/me/meEvent.dart';
import 'package:untitled_client/src/bloc/signIn/signInState.dart';
import 'package:untitled_client/src/repos/userRepository.dart';

class SignInCubit extends Cubit<SignInState> {
  final UserRepository userRepo;
  final MeBloc meBloc;

  SignInCubit({
    required this.userRepo,
    required this.meBloc
  }): super(SignInInitState());

  void signIn({
    required String usernameOrEmail,
    required String password
  }) async {
    emit(SignInLoadingState());
    try {
      FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
      String? token = await firebaseMessaging.getAPNSToken();
      bool? platformIsIOS;

      if (token != null) {
        platformIsIOS = Platform.isIOS;
      }

      final signIn = await userRepo.signUserIn(usernameOrEmail, password, token, platformIsIOS);
      if (signIn.errors != null) {
        emit(SignInFieldErrorState(
          errors: signIn.errors!
        ));
      } else {
        Box hiveBox = Hive.box("deviceTokenBox");
        await hiveBox.put('deviceToken', token);
        meBloc.add(MeSignInEvent());
        emit(SignInCompleteState(
          signInResponse: signIn,
        ));
      }
    } catch (err) {
      // emit(SignInErrorState());
    }
  }
}