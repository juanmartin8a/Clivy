import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled_client/src/ui/screens/user/profile.dart';

class GeneralRichText extends StatelessWidget {
  final Map<String, dynamic> userTags;
  //final List<String> highlights;
  final Map<String, dynamic> highlights;
  final String firstText;
  final String text;
  final bool isFirstTextName;
  final int? nameFirstTextId;
  final TextStyle textStyle1;
  final TextStyle textStyle2;
  final TextStyle textStyle3;
  const GeneralRichText({ 
    this.userTags = const {},
    this.highlights = const {},
    required this.firstText,
    required this.text,
    this.isFirstTextName = false,
    this.nameFirstTextId,
    this.textStyle1 = const TextStyle(
      color: Colors.white,
      fontSize: 14.5,
      fontWeight: FontWeight.w400,
      // height: 1.2
    ),
    this.textStyle2 = const TextStyle(
      color: Color(0xff00ff03),
      fontSize: 14.5,
      fontWeight: FontWeight.w400,
      // height: 1.2
    ),
    this.textStyle3 = const TextStyle(
      color: Colors.white,
      fontSize: 14.5,
      fontWeight: FontWeight.w600,
      // height: 1.2
    ),
    required Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RichText(
        text: TextSpan(
          text: firstText != "" ? firstText + " " : "",
          recognizer: TapGestureRecognizer()..onTap = () {
            if (isFirstTextName) {
              Get.to(
                Profile(
                  userId: nameFirstTextId!,
                  key: Key('userProfile_$nameFirstTextId!')
                ),
                preventDuplicates: false
              );
            }
          },
          style: textStyle1,
          children: [
            ...text.split(' ').map((word) {
              String usernameWithoutAt = word.replaceAll('@', '');
              if (userTags.values.contains(usernameWithoutAt) && word.startsWith("@")) {
                String findKey = userTags.keys.firstWhere((element) => userTags[element] == usernameWithoutAt);
                int userId = int.parse(findKey);
                String userTag = "@${userTags['$userId']} ";
                return TextSpan(
                  text: userTag,
                  recognizer: TapGestureRecognizer()..onTap = () {
                    Get.to(
                      Profile(
                        userId: userId,
                        key: Key('userProfile_$userId')
                      ),
                      preventDuplicates: false
                    );
                  },
                  style: textStyle2,
                );
              }
              String replacedWord = word.replaceAll(",", "");
              if (highlights.isNotEmpty && highlights.values.contains(replacedWord)) {
                String findKey = highlights.keys.firstWhere((element) => highlights[element] == replacedWord);
                int userId = int.parse(findKey);
                String highlightedWord = "$word ";
                return TextSpan(
                  text: highlightedWord,
                  recognizer: TapGestureRecognizer()..onTap = () {
                    Get.to(
                      Profile(
                        userId: userId,
                        key: Key('userProfile_$userId')
                      ),
                      preventDuplicates: false
                    );
                  },
                  style: textStyle3,
                );
              }
              return TextSpan(
                text: "$word ",
                style: textStyle1,
              );
            }).toList()
          ]
        )
      ),
    );
  }
}