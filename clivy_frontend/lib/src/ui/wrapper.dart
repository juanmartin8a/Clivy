import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled_client/src/bloc/me/meBloc.dart';
import 'package:untitled_client/src/bloc/me/meState.dart';
import 'package:untitled_client/src/ui/screens/auth/auth.dart';
import 'package:untitled_client/src/ui/screens/home/home.dart';


class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: BlocBuilder<MeBloc, MeState>(
          builder: (context, state) {
            if (state is MeLoadingState) {
              return Container(color: Colors.yellow);
            } else if (state is MeIsAuthState) {
              return Home();
            } else {
              return AuthScreen();
            }
          }
        )
      )
    );
  }
}
