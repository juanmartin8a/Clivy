import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:untitled_client/src/bloc/forgotPassword/forgotPasswordCubit.dart';
import 'package:untitled_client/src/ui/screens/home/widgets/floatingActions.dart';

class ChangePassword extends StatefulWidget {
  final String code;
  final String email;
  const ChangePassword({ 
    required this.code,
    required this.email,
    Key? key 
  }) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController _passwordController = TextEditingController();
  String? passwordError;
  bool isPasswordVisible = false;

  @override
  initState() {
    super.initState();
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
                      height: 45,
                      // color: Color(0xff00ff03),
                      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                    ),
                    Container(
                      // width: MediaQuery.of(context).size.width * 0.85,
                      child: Text(
                        "Change Password",
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
                    SizedBox(
                      height: 20
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: 45,
                      // color: Colors.red,
                      child: IntrinsicWidth(
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
                              borderSide: BorderSide(color: Colors.grey[900]!, width: 2),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff00ff03), width: 2),
                            ),
                            contentPadding: EdgeInsets.zero,
                            hintText: 'New password',
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
                        ),
                      )
                    ),
                    SizedBox(
                      height: 20
                    ),
                    GestureDetector(
                      onTap: () async {
                        await clientValidation();
                        // print("aaa");
                        if (passwordError == null) {
                          BlocProvider.of<ForgotPasswordCubit>(context).changePasswordAndSignIn(
                            _passwordController.text, widget.email, widget.code
                          );
                        }
                        // _signInCubit?.signIn(
                        //   usernameOrEmail: _usernameOrEmailController.text,
                        //   password: _passwordController.text
                        // );
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
                    )
                  ],
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 45,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  height: 45,
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

  clientValidation() async {
    String password = _passwordController.text;

    RegExp spaceRegex = new RegExp(
      r"\s\b|\b\s"
    );

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
}