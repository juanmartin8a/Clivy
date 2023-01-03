import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled_client/src/ui/screens/auth/signIn.dart';
import 'package:untitled_client/src/ui/screens/auth/signUp.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: Container(
        child: Column(
          children: [
            // SizedBox(
            //   height: MediaQuery.of(context).padding.top + 45,
            // ),
            Spacer(),
            Container(
              // margin: EdgeInsets.only(top: )
              child: Center(
                child: Container(
                  // color: Colors.red,
                  height: 70,
                  child: Image.asset("assets/images/clivy_logo.png")
                ),
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                Get.to(SignUp());
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Color(0xff00ff03), width: 2.0),
                ),
                child: Center(
                  child: Text(
                    "Sign up",
                    style: TextStyle(
                      color: Color(0xff00ff03),
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      height: 1
                    )
                  ),
                )
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.to(SignIn());
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                color: Colors.transparent,
                height: 45,
                child: Center(
                  child: Text(
                    "Sign in",
                    style: TextStyle(
                      color: Color(0xff00ff03),
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      height: 1
                    )
                  ),
                )
              ),
            ),
            SizedBox(
              height: 20
            )
          ],
        )
      )
    );
  }
}