import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:untitled_client/src/bloc/signUp/signUpCubit.dart';
import 'package:untitled_client/src/bloc/signUp/signUpState.dart';
import 'package:untitled_client/src/ui/screens/auth/signUp/birthdaySreen.dart';
import 'package:untitled_client/src/ui/screens/auth/signUp/setUpAccount.dart';
import 'package:untitled_client/src/ui/screens/auth/signUp/videogameGenreSelection.dart';
import 'package:untitled_client/src/ui/screens/home/widgets/floatingActions.dart';

class SignUp extends StatefulWidget {

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final PageController _pageController = PageController();

  SignUpCubit? _signUpCubit;

  @override
  void initState() {
    _signUpCubit = BlocProvider.of<SignUpCubit>(context);
    _signUpCubit?.stream.listen((state) {
      if (state is SignUpNextState) {
        nextPage(state.index);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Container(
              child: PageView(
                controller: _pageController,
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                children: [
                  BirthdayScreen(),
                  SetUpAccount(),
                  VideogameGenreSelection(),
                  // Container(
                  //   color: Colors.green,
                  // )
                ]
              )
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 45 + MediaQuery.of(context).padding.top,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  height: 45 + MediaQuery.of(context).padding.top,
                  width: 45,
                  // color: Colors.red,
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: FloatingActions(
                        icon: EvaIcons.arrowBackOutline,
                        padding: EdgeInsets.only(left: 8),
                        color: Colors.grey[800]!,
                        size: 34,
                        key: Key("goBack")
                      )
                    ),
                  ),
                ),
              ),
            )
          ],
        )
      )
    );
  }

  void nextPage(int index) {
    if (_pageController.hasClients) {
      _pageController.animateToPage(
        index, 
        duration: Duration(milliseconds: 300), 
        curve: Curves.decelerate
      );
    }
  }
}