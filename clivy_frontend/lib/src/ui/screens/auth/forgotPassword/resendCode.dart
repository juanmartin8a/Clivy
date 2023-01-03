import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled_client/src/bloc/forgotPassword/forgotPasswordCubit.dart';
import 'package:untitled_client/src/bloc/forgotPassword/forgotPasswordState.dart';

class ResendCode extends StatefulWidget {
  final int timeExtent;
  const ResendCode({ 
    required this.timeExtent,
    Key? key 
  }) : super(key: key);

  @override
  _ResendCodeState createState() => _ResendCodeState();
}

class _ResendCodeState extends State<ResendCode> {
  ForgotPasswordCubit? _forgotPasswordCubit;

  final interval = Duration(seconds: 1);
  int countdownValue = 60;
  bool canResend = false;

  startTimeout() {
    var duration = interval;
    Timer.periodic(duration, (timer) {
      if (mounted) {
        setState(() {
          countdownValue = 60 - timer.tick;
          // print(countdownValue);
          if (timer.tick >= widget.timeExtent) {
            canResend = true;
            timer.cancel();
          }
        });
      }
    });
  }

  @override
  void initState() {
    startTimeout();
    _forgotPasswordCubit = BlocProvider.of<ForgotPasswordCubit>(context);
    _forgotPasswordCubit!.stream.listen((state) {
      if (state is ForgotPasswordSendEmail) {
        if (state.isPre == true) {
          if (mounted) {
            setState(() {
              countdownValue = 60;
              canResend = false;
              startTimeout();
            });
          }
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            // width: MediaQuery.of(context).size.width * 0.85,
            // padding: EdgeInsets.only
            child: Text(
              "Resend code",
              style: TextStyle(
                color: canResend ? Color(0xff00ff03) : Colors.grey[800], 
                fontSize: 15,
                fontWeight: FontWeight.w500,
                height: 1.2
              ),
            )
          ),
          if (!canResend)
          Container(width: 6),
          if (!canResend)
          Container(
            child: Text(
              "${countdownValue}s",
              style: TextStyle(
                color: canResend ? Color(0xff00ff03) : Colors.grey[800], 
                fontSize: 15,
                fontWeight: FontWeight.w500,
                height: 1.2
              ),
            )
          )
        ],
      ),
    );
  }
}