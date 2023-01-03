import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled_client/src/bloc/signUp/signUpCubit.dart';
import 'package:untitled_client/src/bloc/signUp/signUpState.dart';

class SetUpAccount extends StatefulWidget {
  const SetUpAccount({ 
    Key? key 
  }) : super(key: key);

  @override
  _SetUpAccountState createState() => _SetUpAccountState();
}

class _SetUpAccountState extends State<SetUpAccount> with AutomaticKeepAliveClientMixin {

  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String? usernameError;
  String? emailError;
  String? passwordError;

  SignUpCubit? _signUpCubit;

  bool isPasswordVisible = false;

  @override
  void initState() {
    _signUpCubit = BlocProvider.of<SignUpCubit>(context);
    _signUpCubit?.stream.listen((state) {
      if (state is SignUpFieldErrorState) {
        usernameError = null;
        emailError = null;
        passwordError = null;
        for (var error in state.errors) {
          if (error.field == "username") {
            usernameError = error.message;
          } 
          if (error.field == "email") {
            emailError = error.message;
          } 
          if (error.field == "password") {
            passwordError = error.message;
          }
        }
        if (mounted) {
          setState(() {});
        }
      } else if (state is SignUpCompleteState) {
        _signUpCubit?.next(2, null);
      }
    });
    super.initState();
  }

  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: Column(
        children: [
          Container(
            height: 45,
            // color: Color(0xff00ff03),
            margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          ),
          Container(
            child: Text(
              "Set up your account",
              style: TextStyle(
                color: Color(0xff00ff03),
                fontSize: 22,
                // letterSpacing: 0.5,
                // fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w600,
                // height: 1
              ),
            )
          ),
          SizedBox(height: 12),
          Container(
            width: MediaQuery.of(context).size.width * 0.85,
            height: 45,
            // color: Colors.blue,
            child: TextField(
              expands: true,
              maxLines: null,
              // textInputAction: TextInputAction.go,
              controller: _usernameController,
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
                  borderSide: BorderSide(color: usernameError != null ? Colors.red[700]! : Colors.grey[900]!, width: 2.0),
                  // borderRadius: BorderRadius.circular(12.5),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff00ff03), width: 2.0),
                  // borderRadius: BorderRadius.circular(12.5),
                ),
                contentPadding: EdgeInsets.zero,
                hintText: 'Username',
                hintStyle: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  height: 1.25
                ),
              ),
            ),
          ),
          if (usernameError != null)
          SizedBox(height: 6),
          if (usernameError != null)
          Container(
            width: MediaQuery.of(context).size.width * 0.85,
            child: Text(
              usernameError!,
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
              expands: true,
              maxLines: null,
              controller: _emailController,
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
                  borderSide: BorderSide(color: emailError != null ? Colors.red[700]! : Colors.grey[900]!, width: 2),
                  // borderRadius: BorderRadius.circular(12.5),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff00ff03), width: 2),
                  // borderRadius: BorderRadius.circular(12.5),
                ),
                contentPadding: EdgeInsets.zero,
                hintText: 'Email',
                hintStyle: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  height: 1.25
                ),
              ),
            ),
          ),
          if (emailError != null)
          SizedBox(height: 6),
          if (emailError != null)
          Container(
            width: MediaQuery.of(context).size.width * 0.85,
            child: Text(
              emailError!,
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
                  borderSide: BorderSide(color: passwordError != null ? Colors.red[700]! : Colors.grey[900]!, width: 2),
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
          SizedBox(height: 30),
          GestureDetector(
            onTap: () async {
              await clientValidation();
              if (
                usernameError == null &&
                emailError == null &&
                passwordError == null
              ) {
                BlocProvider.of<SignUpCubit>(context).signUp(
                  name: _usernameController.text.trim(),
                  username: _usernameController.text.trim(),
                  email: _emailController.text.trim(),
                  password: _passwordController.text
                );
                // BlocProvider.of<SignUpCubit>(context).next(2, null);
              }
              // BlocProvider.of<SignUpCubit>(context).next(2);
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: 45,
              // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: Color(0xff00ff03), 
                  width: 2.0
                ),
              ),
              child: Center(
                child: Text(
                  'Next',
                  style: TextStyle(
                    color: Color(0xff00ff03),
                    fontSize: 17,
                    fontWeight: FontWeight.w600
                  )
                ),
              )
            ),
          ),
        ],
      )
    );
  }

  clientValidation() async {
    String username = _usernameController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text;

    RegExp spaceRegex = new RegExp(
      r"\s\b|\b\s"
    );

    if (username.length < 2 || username.length > 30) {
      if (username.length == 0) {
        usernameError = "username must not be empty";
      } else if (username.length < 2) {
        usernameError = "username must have at least 2 characters";
      } else if (spaceRegex.hasMatch(username)) {
        usernameError = "username must not have any spaces";
      } else if (username.length > 30) {
        usernameError = "username must have no more than 30 characters";
      }
    } else {
      usernameError = null;
    }

    RegExp emailRegExp = new RegExp(
      r'''(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])'''
    );
    if (!emailRegExp.hasMatch(email)) {
      emailError = "invalid email";
    } else {
      emailError = null;
    }

    RegExp passwordRegExp = new RegExp(
      r'(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}'
    );
    if (!passwordRegExp.hasMatch(password)) {
      if (password.length < 8) {
        passwordError = 'password must have at least 8 characters';
      } else if (spaceRegex.hasMatch(password)) {
        passwordError = 'password must not have any spaces';
      } else if (!passwordRegExp.hasMatch(password)) {
        passwordError = 'password must have at least one letter and one number';
      }
    } else {
      passwordError = null;
    }

    setState(() {});
  }

  @override
  bool get wantKeepAlive => true;
}