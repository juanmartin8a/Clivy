import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:untitled_client/src/bloc/forgotPassword/forgotPasswordCubit.dart';
import 'package:untitled_client/src/bloc/forgotPassword/forgotPasswordState.dart';
import 'package:untitled_client/src/ui/screens/auth/forgotPassword/changePassword.dart';
import 'package:untitled_client/src/ui/screens/auth/forgotPassword/resendCode.dart';
import 'package:untitled_client/src/ui/screens/home/widgets/floatingActions.dart';
import 'package:uuid/uuid.dart';

class ForgotPasswordCode extends StatefulWidget {
  final String email;
  const ForgotPasswordCode({ 
    required this.email,
    Key? key 
  }) : super(key: key);

  @override
  _ForgotPasswordCodeState createState() => _ForgotPasswordCodeState();
}

class _ForgotPasswordCodeState extends State<ForgotPasswordCode> {
  ForgotPasswordCubit? _forgotPasswordCubit;
  TextEditingController _codeController = TextEditingController();

  bool? isValid;

  @override
  void initState() {
    super.initState();
    _forgotPasswordCubit = BlocProvider.of<ForgotPasswordCubit>(context);
    _forgotPasswordCubit!.stream.listen((state) {
      if (state is ForgotPasswordVerifyCode) {
        if (state.isValid == true) {
          Get.to(ChangePassword(
            code: state.code, 
            email: widget.email,
            key: Key(Uuid().v4())
          ));
        }
      }
    });
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
                        "Verification Code",
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
                        "Enter the 6 digit code sent to ${widget.email}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey[800],//Color(0xff00ff03),
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          height: 1.2
                        ),
                      )
                    ),
                    SizedBox(
                      height: 20
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: Form(
                        child: PinCodeTextField(
                          appContext: context, 
                          length: 6, 
                          controller: _codeController,
                          useHapticFeedback: true,
                          keyboardType: TextInputType.number,
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w700
                          ),
                          cursorColor: Color(0xff00ff03),
                          pinTheme: PinTheme(
                            inactiveFillColor: Colors.white,
                            activeFillColor: Colors.white,
                            selectedFillColor: Colors.white,
                            shape: PinCodeFieldShape.underline,
                            borderRadius: BorderRadius.circular(5),
                            fieldHeight: 50,
                            fieldWidth: 40,
                            activeColor: Color(0xff00ff03),
                            inactiveColor: Color(0xff00ff03),
                            disabledColor: Color(0xff00ff03),
                            selectedColor: Color(0xff00ff03), 
                            // activeFillColor: Color(0xff00ff03),
                          ),
                          blinkDuration: Duration(milliseconds: 1000),
                          animationDuration: Duration(milliseconds: 100),
                          animationType: AnimationType.fade,
                          onCompleted: (val) {
                            _forgotPasswordCubit?.verifyResetCode(widget.email, val);
                          },
                          onChanged: (val) {},
                        ),
                      )
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () {
                            _forgotPasswordCubit?.sendResetPasswordEmail(widget.email);
                          },
                          child: ResendCode(
                            timeExtent: 60,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20
                    ),
                    BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
                      builder: (context, state) {
                        if (state is ForgotPasswordVerifyCode) {
                          if (state.isValid == true) {
                            isValid = false;
                          } else {
                            return Container(
                              // color: Colors.blue,
                              child: Text(
                                "invalid code",
                                style: TextStyle(
                                  color: Colors.red[700],
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  height: 1
                                )
                              )
                            );
                          }
                        }
                        return Container();
                      }
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