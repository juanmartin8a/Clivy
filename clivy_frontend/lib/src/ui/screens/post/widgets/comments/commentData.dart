import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled_client/src/models/currentUser.dart';
import 'package:untitled_client/src/ui/helpers/GeneralRichText.dart';
import 'package:untitled_client/src/ui/helpers/profileImg.dart';
import 'package:untitled_client/src/ui/screens/post/widgets/comments/commentLike.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:untitled_client/src/ui/screens/user/profile.dart';

class CommentData extends StatelessWidget {
  final dynamic data; // Comments$Query$CommentResponse$Comment?
  final bool isReply;
  final bool isPre;
  final String id;
  const CommentData({ 
    required this.data,
    required this.isReply,
    this.isPre = false,
    required this.id,
    required Key key 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String text = isReply ? data!.reply : data!.comment;
    Map<String, dynamic> userTags = Map.fromIterable(data!.userTags, key: (v) => v.userId.toString(), value: (v) => v.userString);
    // print(userTags);
    final Widget imgWidget = GestureDetector(
      onTap: () {
        Get.to(
          Profile(
            userId: data!.user.id.toInt(),
            key: Key('userProfile_${data!.user.id.toInt()}')
          ),
          preventDuplicates: false
        );
      },
      child: Container(
        height: isReply ? 25 : 40,
        width: isReply ? 25 : 40,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: ProfileImgLoader(
            file: data!.user.smallFile.file!,
            isMe: data.user.id == CurrentUser.userId,
            key: Key("commentImgLoader_$id")
          ),
        )
      )
    );
    final Widget commentData = Expanded(
      child: Container(
        margin: EdgeInsets.only(
          left:  8,//isReply ? 0 : 8,
          // right: isReply ? 8 : 0,
          top: 3.5
        ),
        // color: Colors.green,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            GeneralRichText(
              userTags: userTags,
              firstText: data!.user.username,
              isFirstTextName: true,
              nameFirstTextId: data!.user.id.toInt(),
              text: text,
              // text: "sober me says no but ik high me would do thi",
              key: Key("commentRichText_$id")
            ),
            Container(
              margin: EdgeInsets.only(top: 4),
              child: Row(
                children: [
                  Text(
                    isPre ? "..." : timeago.format(DateTime.fromMillisecondsSinceEpoch(int.parse(data.createdAt)), locale: 'en_short').replaceAll("~", ""),
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w400,
                      height: 1
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 8),
                    child: Text(
                      isPre ? "" : "Reply",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w500,
                        height: 1
                      ),
                    )
                  )
                ],
              )
            )
          ],
        )
      )
    );
    return Container(
      margin: EdgeInsets.only(
        top: 16,
        left: isReply ? 48 : 0
      ),
      // padding: EdgeInsets.symmetric(vertical: 8),
      // color: Colors.red,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start, //isReply ? MainAxisAlignment.end : MainAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          imgWidget,
          commentData,
          // Expanded(child: Container()),
          // if (!isReply)
          // Spacer(),
          if (!isPre) 
          CommentLikeWidget(
            id: data.id.toInt(),
            uuid: id,
            likeState: data.likeState,
            likeCount: data.likeCount,
            isReply: isReply,
            key: Key("commentLike_${data.id}")
          )
        ],
      ),
    );
  }
}