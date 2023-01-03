import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled_client/src/bloc/forgotPassword/forgotPasswordState.dart';
import 'package:untitled_client/src/bloc/me/meBloc.dart';
import 'package:untitled_client/src/bloc/me/meEvent.dart';
import 'package:untitled_client/src/repos/userRepository.dart';
import 'package:uuid/uuid.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final UserRepository userRepo;
  final MeBloc meBloc;
  ForgotPasswordCubit({
    required this.userRepo,
    required this.meBloc
  }) : super(ForgotPasswordInitState());

  void sendResetPasswordEmail(String email) async {
    try {
      emit(ForgotPasswordSendEmail(
        uuid: Uuid().v4(),
        isPre: true,
      ));
      await userRepo.sendResetPasswordEmail(email);
      // print("aaa");
      emit(ForgotPasswordSendEmail(
        uuid: Uuid().v4()
      ));
    } catch(err) {}
  }

  void verifyResetCode(String email, String code) async {
    try {
      final res = await userRepo.verifyResetCode(email, code);
      emit(ForgotPasswordVerifyCode(
        uuid: Uuid().v4(),
        isValid: res.verifyResetCode,
        code: code,
      ));
    } catch(err) {}
  }

  void changePasswordAndSignIn(String newPassword, String email, String code) async {
    try {
      FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
      String? token = await firebaseMessaging.getAPNSToken();
      bool? platformIsIOS;

      if (token != null) {
        platformIsIOS = Platform.isIOS;
      }
      
      final res = await userRepo.changePasswordAndSignIn(
        newPassword, email, code, token, platformIsIOS
      );

      if (res.errors != null) {
        emit(ForgotPasswordFieldErrorState(
          errors: res.errors!
        ));
      } else {
        meBloc.add(MeSignInEvent());
      }

      emit(ForgotPasswordInitState());
      
    } catch(err) {
      emit(ForgotPasswordInitState());
    }
  }
}