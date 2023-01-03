import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:untitled_client/src/client/client.dart';
import 'package:untitled_client/src/models/currentUser.dart';
import 'package:untitled_client/src/repos/userRepository.dart';
import 'package:untitled_client/src/bloc/me/meEvent.dart';
import 'package:untitled_client/src/bloc/me/meState.dart';
import 'package:untitled_client/src/ui/wrapper.dart';

class MeBloc extends Bloc<MeEvent, MeState> {
  final UserRepository userRepo;

  MeBloc({
    required this.userRepo,
  }) : super(MeInitialState());

  @override
  Stream<MeState> mapEventToState(MeEvent event) async* {
    if (event is MeInitEvent) {
      yield MeLoadingState();
      try {
        // print("aaaaa");
        final user = await userRepo.me();
        // print(user);
        CurrentUser.userId = user.id.toInt();
        CurrentUser.user = user;
        FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
        String? token = await _firebaseMessaging.getAPNSToken();
        Box deviceTokenBox = Hive.box("deviceTokenBox");
        var savedDeviceToken = await deviceTokenBox.get("deviceToken");
        if (token != null) {
          if (token != savedDeviceToken) {
            try {
              await UserRepository(client: Client.client!).addNewDeviceTokenMutation(
                token, Platform.isIOS
              );
            } catch(e) {}
          }
        }
        yield MeIsAuthState(
          user: user,
        );
      } catch (error) {
        Box hiveBox = Hive.box("deviceTokenBox");
        var savedDeviceToken = await hiveBox.get('deviceToken');
        if (savedDeviceToken != null) {
          await hiveBox.delete('deviceToken');
        }
        CurrentUser.userId = null;
        CurrentUser.user = null;
        yield MeIsNotAuthState();
      }
    } else if (event is MeSignInEvent) {
      await userRepo.client.resetStore();
      final user = await userRepo.me();
      CurrentUser.userId = user.id.toInt();
      CurrentUser.user = user;
      Get.offAll(Wrapper());
      yield MeIsAuthState(
        user: user,
      );
    } else if (event is MeSignOutEvent) {
      await userRepo.client.resetStore();
      CurrentUser.userId = null;
      CurrentUser.user = null;
      Box hiveBox = Hive.box("deviceTokenBox");
      var savedDeviceToken = await hiveBox.get('deviceToken');
      if (savedDeviceToken != null) {
        await hiveBox.delete('deviceToken');
      }
      yield MeIsNotAuthState();
    }
  } 
}