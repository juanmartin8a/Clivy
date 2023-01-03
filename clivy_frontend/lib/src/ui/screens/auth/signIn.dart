import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:untitled_client/src/bloc/signIn/signInCubit.dart';
import 'package:untitled_client/src/bloc/signIn/signInState.dart';
import 'package:untitled_client/src/ui/screens/auth/forgotPassword/forgotPassword.dart';
import 'package:untitled_client/src/ui/screens/home/widgets/floatingActions.dart';
import 'package:uuid/uuid.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  SignInCubit? _signInCubit;

  final _usernameOrEmailController = TextEditingController();
  final _passwordController = TextEditingController();

  String? usernameOrEmailError;
  String? passwordError;

  bool isPasswordVisible = false;

  void initState() {
    super.initState();
    _signInCubit = BlocProvider.of<SignInCubit>(context);
    _signInCubit!.stream.listen((state) {
      if (state is SignInFieldErrorState) {
        usernameOrEmailError = null;
        passwordError = null;
        for (var error in state.errors) {
          if (error.field == "usernameOrEmail") {
            usernameOrEmailError = error.message;
          } 
          if (error.field == "password") {
            passwordError = error.message;
          }
        }
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  void dispose() {
    super.dispose();
    _usernameOrEmailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: Container(
        width: MediaQuery.of(context).size.width,
        // height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            
            Container(
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 45 + MediaQuery.of(context).padding.top,
                      // color: Color(0xff00ff03),
                      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                    ),
                    Container(
                      child: Text(
                        "Sign in",
                        style: TextStyle(
                          color: Color(0xff00ff03),
                          fontSize: 26,
                          letterSpacing: 0.5,
                          // fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w600,
                          // height: 1
                        ),
                      )
                    ),
                    SizedBox(
                      height: 30
                    ),
                    // Spacer(),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: 45,
                      // color: Colors.blue,
                      child: TextField(
                        expands: true,
                        maxLines: null,
                        // textInputAction: TextInputAction.go,
                        controller: _usernameOrEmailController,
                        textInputAction: TextInputAction.done,
                        cursorColor: Color(0xff00ff03),
                        textAlignVertical: TextAlignVertical.center,
                        keyboardAppearance: Brightness.dark,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          height: 1.25
                        ),
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[900]!, width: 2.0),
                            // borderRadius: BorderRadius.circular(12.5),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff00ff03), width: 2.0),
                            // borderRadius: BorderRadius.circular(12.5),
                          ),
                          contentPadding: EdgeInsets.zero,
                          hintText: 'Username or Email',
                          hintStyle: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            height: 1.25
                          ),
                        ),
                        onChanged: (val) {
                          if (mounted) {
                            setState(() {});
                          }
                        },
                      ),
                    ),
                    if (usernameOrEmailError != null)
                    SizedBox(height: 6),
                    if (usernameOrEmailError != null)
                    Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: Text(
                        usernameOrEmailError!,
                        style: TextStyle(
                          color: Colors.red[700],
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: 1.2
                        ),
                      )
                    ),
                    SizedBox(height: 12),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: 45,
                      // color: Colors.red,
                      child: TextField(
                        // expands: true,
                        // maxLines: null,
                        obscureText: !isPasswordVisible,
                        controller: _passwordController,
                        textInputAction: TextInputAction.done,
                        cursorColor: Color(0xff00ff03),
                        textAlignVertical: TextAlignVertical.center,
                        keyboardAppearance: Brightness.dark,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          height: 1.25
                        ),
                        decoration: InputDecoration(
                          isCollapsed: true,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[900]!, width: 2),
                            // borderRadius: BorderRadius.circular(12.5),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff00ff03), width: 2),
                            // borderRadius: BorderRadius.circular(12.5),
                          ),
                          contentPadding: EdgeInsets.zero,
                          hintText: 'Password',
                          hintStyle: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            height: 1.25
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              if (isPasswordVisible == false) {
                                setState(() {
                                  isPasswordVisible = true;
                                });
                              } else {
                                setState(() {
                                  isPasswordVisible = false;
                                });
                              }
                            },
                            child: Container(
                              child: Icon(
                                EvaIcons.eyeOffOutline,
                                color: Colors.grey[800]
                              )
                            )
                          )
                        ),
                        onChanged: (val) {
                          if (mounted) {
                            setState(() {});
                          }
                        },
                      ),
                    ),
                    if (passwordError != null)
                    SizedBox(height: 6),
                    if (passwordError != null)
                    Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: Text(
                        passwordError!,
                        style: TextStyle(
                          color: Colors.red[700],
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: 1.2
                        ),
                      )
                    ),
                    SizedBox(height: 8),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            Get.to(ForgotPassword(key: Key(Uuid().v4())));
                          },
                          child: Text(
                            "Forgot password?",
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              // height: 1.25
                            ),
                          ),
                        )
                      )
                    ),
                    SizedBox(height: 30),
                    // Spacer(),
                    BlocBuilder<SignInCubit, SignInState>(
                      // bloc: _signInCubit,
                      builder: (context, state) {
                        return GestureDetector(
                          onTap: () {
                            _signInCubit?.signIn(
                              usernameOrEmail: _usernameOrEmailController.text,
                              password: _passwordController.text
                            );
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            height: 45,
                            // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(
                                color: 
                                  _usernameOrEmailController.text.isNotEmpty && 
                                  _passwordController.text.isNotEmpty
                                  ? Color(0xff00ff03)
                                  : Colors.grey[900]!, 
                                  width: 2.0
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Sign in',
                                style: TextStyle(
                                  // fontFamily: "MPlus1",
                                  color: 
                                    _usernameOrEmailController.text.isNotEmpty && 
                                    _passwordController.text.isNotEmpty
                                    ? Color(0xff00ff03)
                                    :  Colors.grey[800]!,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  height: 1
                                )
                              ),
                            )
                          )
                        );
                      }
                    ),
                    SizedBox(
                      height: 35,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 45 + MediaQuery.of(context).padding.top,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  height: 45 + MediaQuery.of(context).padding.top,
                  width: 45,
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
                        size: 36,
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
}