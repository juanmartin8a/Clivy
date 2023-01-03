import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:untitled_client/src/bloc/forgotPassword/forgotPasswordCubit.dart';
import 'package:untitled_client/src/ui/screens/auth/forgotPassword/forgotPaswordCode.dart';
import 'package:untitled_client/src/ui/screens/home/widgets/floatingActions.dart';
import 'package:uuid/uuid.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({
    Key? key
  }) : super(key: key);
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  // GraphQLClient _client = Client.client!;
  ForgotPasswordCubit? _forgotPasswordCubit;

  final _emailController = TextEditingController();

  String? emailError;

  @override
  void initState() {
    super.initState();
    _forgotPasswordCubit = BlocProvider.of<ForgotPasswordCubit>(context);
    // _forgotPasswordCubit
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
                        "Forgot password",
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
                      height: 8
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: Text(
                        "Enter your email and we'll send you a code to change your password.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey[800],//Color(0xff00ff03),
                          fontSize: 15,
                          // letterSpacing: 0.5,
                          // fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w500,
                          height: 1.2
                        ),
                      )
                    ),
                    SizedBox(
                      height: 20
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
                            borderSide: BorderSide(color: Colors.grey[900]!, width: 2.0),
                            // borderRadius: BorderRadius.circular(12.5),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff00ff03), width: 2.0),
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
                        onChanged: (val) {
                          if (mounted) {
                            setState(() {});
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 30
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(
                          ForgotPasswordCode(
                            email: _emailController.text.trim(),
                            key: Key(Uuid().v4())
                          )
                        );
                        if (_emailController.text.isNotEmpty) {
                          _forgotPasswordCubit?.sendResetPasswordEmail(_emailController.text.trim());
                        }
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
                              _emailController.text.isNotEmpty 
                              ? Color(0xff00ff03)
                              : Colors.grey[900]!, 
                              width: 2.0
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Next',
                            style: TextStyle(
                              // fontFamily: "MPlus1",
                              color: 
                                _emailController.text.isNotEmpty
                                ? Color(0xff00ff03)
                                :  Colors.grey[800]!,
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              height: 1
                            )
                          ),
                        )
                      ),
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
}