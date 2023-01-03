import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:untitled_client/src/bloc/signUp/signUpCubit.dart';

class BirthdayScreen extends StatefulWidget {
  const BirthdayScreen({ Key? key }) : super(key: key);

  @override
  _BirthdayScreenState createState() => _BirthdayScreenState();
}

class _BirthdayScreenState extends State<BirthdayScreen> with AutomaticKeepAliveClientMixin {
  String? birthDay;
  String? birthMonth;
  String? birthYear;

  String? birthdayDate;

  bool isOldEnough = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      // color: Colors.blue,
      child: Column(
        children: [
          Container(
            height: 45,
            // color: Color(0xff00ff03),
            margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          ),
          Container(
            child: Text(
              "When's your birthday?",
              style: TextStyle(
                color: Color(0xff00ff03),
                fontSize: 22,
                fontWeight: FontWeight.w600,
                // height: 1
              ),
            )
          ),
          SizedBox(
            height: 30
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.85,
            height: 45,
            decoration: BoxDecoration(
              // color: Colors.red,
              border: Border(
                bottom: BorderSide(color: birthDay != null ? Color(0xff00ff03) : Colors.grey[900]!, width: 2)
              )
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                birthDay != null ? "$birthMonth $birthDay, $birthYear" : "Birthday",
                style: TextStyle(
                  color: birthDay != null ? Colors.white : Colors.grey[800],
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  height: 1.25
                ),
              ),
            )
          ),
          SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () {
              BlocProvider.of<SignUpCubit>(context).next(1, birthdayDate);
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: 45,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: isOldEnough == true ? Color(0xff00ff03) : Colors.grey[900]!, width: 2.0),
              ),
              child: Center(
                child: Text(
                  'Next',
                  style: TextStyle(
                    color: isOldEnough == true ? Color(0xff00ff03) : Colors.grey[800]!,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    height: 1
                  )
                ),
              )
            ),
          ),
          Spacer(),
          Container(
            height: 220,
            // color: Colors.redr,
            child: CupertinoTheme(
              data: CupertinoThemeData(
                brightness: Brightness.dark,
                textTheme: CupertinoTextThemeData(
                  dateTimePickerTextStyle: TextStyle(
                    color: Color(0xff00ff03),
                    fontSize: 21,
                  ),
                ),
              ),
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                // dateOrder: DatePickerDateOrder.dmy,
                initialDateTime: DateTime.now(),
                onDateTimeChanged: (birthDate) {
                  birthdayDate = birthDate.millisecondsSinceEpoch.toString();

                  birthDay = birthDate.day.toString();
                  birthMonth = DateFormat.MMMM().format(birthDate);
                  birthYear = birthDate.year.toString();

                  DateTime today = DateTime.now();
                  DateTime minAgeDate = DateTime(
                    birthDate.year + 12,
                    birthDate.month,
                    birthDate.day,
                  );
                  if (minAgeDate.isBefore(today)) {
                    // print("you can use this");
                    isOldEnough = true;
                    // BlocProvider.of<SignUpCubit>(context).next();
                  } else {
                    isOldEnough = false;
                    print("you are too young");
                  }
                  setState(() {});
                }
              ),
            ),
          ),
          SizedBox(
            height: 20
          )
        ]
      )
    );
  }

  @override
  bool get wantKeepAlive => true;
}