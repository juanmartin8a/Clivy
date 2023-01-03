import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:untitled_client/src/api/graphql/graphql_api.dart';
import 'package:untitled_client/src/bloc/follow/followCubit.dart';
import 'package:untitled_client/src/bloc/follow/followState.dart';
import 'package:untitled_client/src/models/currentUser.dart';
import 'package:untitled_client/src/ui/helpers/GeneralRichText.dart';
import 'package:untitled_client/src/ui/helpers/profileImg.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:untitled_client/src/ui/screens/post/postScreen.dart';

class NotificationWidget extends StatefulWidget {
  final Notifications$Query$PaginatedNotifications$Notification notification;
  final String id;
  final String type;
  const NotificationWidget({ 
    required this.notification,
    required this.id,
    required this.type,
    required Key key 
  }) : super(key: key);

  @override
  _NotificationWidgetState createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  List<dynamic> users = [];
  Map<String, dynamic> usersHighlighs = {};
  late String message;
  Map<String, dynamic> userTags = {};
  bool? isFollowing;
  String? clipImgFile;
  int? postId;

  String? clientId;

  @override
  void initState() {
    print("hey");
    loadNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Widget? senderWidget;
    Widget? messageWidget;
    Widget? rightWidget;

    if (users.isNotEmpty) {

      senderWidget = Container(
        height: 45 + 16,
        width: 45,
        child: Center(
          child: users.length > 1
          ? Container(
            height: 45,
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    height: 32,
                    width: 32,
                    child: ProfileImgLoader(
                      file: users[1].smallFile.file!,
                      isMe: users[1].id == CurrentUser.userId,
                      key: Key("notiSenderProfileImg_${widget.id}")
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Container(
                    height: 39,
                    width: 39,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle
                    ),
                    child: Center(
                      child: Container(
                        height: 34,
                        width: 34,
                        child: ProfileImgLoader(
                          file: users[0].smallFile.file!, 
                          isMe: users[0].id == CurrentUser.userId,
                          key: Key("notiSenderProfileImg_${widget.id}")
                        ),
                      ),
                    ),
                  )
                )
              ]
            ),
          )
          : Center(
            child: Container(
              height: 45,
              width: 45,
              child: ProfileImgLoader(
                file: users[0].smallFile.file!,
                isMe: users[0].id == CurrentUser.userId,
                key: Key("notiSenderProfileImg_${widget.id}")
              ),
            ),
          ),
        )
      );
      messageWidget = Expanded(
        child: Container(
          // color: Colors.green,
          margin: EdgeInsets.only(left: 8, top: 8.85),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: GeneralRichText(
                  highlights: usersHighlighs,//.map((value) => value.username as String).toList(),
                  userTags: userTags,
                  firstText: "",
                  text: message,
                  key: Key("likeNotification_${widget.id}")
                )
              ),
              Container(
                margin: EdgeInsets.only(top: 4),
                child: Text(
                  // fontFam
                  timeago.format(DateTime.fromMillisecondsSinceEpoch(int.parse(widget.notification.updatedAt)), locale: 'en_short').replaceAll("~", ""),
                  style: TextStyle(
                    // fontFamily: "MPlus1",
                    color: Colors.grey[500],
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    height: 1
                  )
                ),
              )
            ],
          )
        ),
      );
    } else {
      messageWidget = Container();
      senderWidget = Container();
    }

    if (isFollowing != null || clipImgFile != null) {
      if (clipImgFile != null && isFollowing == null) {
        rightWidget = Container(
          // width: 50,
          height: 45 + 16,
          // color: Colors.red,
          margin: EdgeInsets.only(left: 8),
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: GestureDetector(
                onTap: () {
                  Get.to(
                    PostScreen(
                      id: postId!,
                      key: Key("singlePost_${postId!}")
                    )
                  );
                },
                child: Container(
                  width: 43,
                  child: Image.network(
                    clipImgFile!,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),
          ),
        );
      } else {
        rightWidget = BlocBuilder<FollowCubit, FollowState>(
          builder: (context, state) {
            if (state is FollowUserState) {
              if (state.userId == users[0].id.toInt()) {
                if (state.isPre) {
                  clientId = state.clientId;
                  if (state.clientId == clientId) {
                    isFollowing = true;
                  }
                }
              }
            } else if (state is UnfollowUserState) {
              if (state.userId == users[0].id.toInt()) {
                if (state.isPre) {
                  clientId = state.clientId;
                  if (clientId == state.clientId) {
                    isFollowing = false;
                  }
                }
              }
            }
            return Container(
              height: 50,
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    BlocProvider.of<FollowCubit>(context).followUnfollowUser(
                      userId: users[0].id.toInt(), isFollow: isFollowing!
                    );
                  },
                  child: Container(
                    height: 30,
                    width: 95,
                    decoration: BoxDecoration(
                      // color: Colors.blue,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Color(0xff00ff03), width: 2)
                    ),
                    child: Center(
                      child: Text(
                        isFollowing! ? "Following" : "Follow",
                        style: TextStyle(
                          color: Color(0xff00ff03),
                          fontSize: 14.5,
                          fontWeight: FontWeight.w500,
                          height: 1
                        )
                      )
                    )
                  ),
                )
              ),
            );
          }
        );
      }
    } else {
      rightWidget = Container();
    }

    return users.isNotEmpty ? Container(
      // color: Colors.red,
      // height: users.isNotEmpty ? 66 : 0,
      padding: EdgeInsets.symmetric(horizontal: users.isNotEmpty ? 8 : 0, vertical: 2),
      // margin: EdgeInsets.symmetric(vertical:2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          senderWidget,
          messageWidget,
          // const Spacer(),
          rightWidget
        ]
      )
    ) : Container();
  }

  void loadNotification() {
    var entity;
    if (widget.type.contains("like")) {
      String? entityType;
      String afterNotificationMessage = "";
      switch (widget.type) {
        case 'like':
          entity = widget.notification.likeNotification!.post;
          entityType = "clip";
          clipImgFile = entity.fileImg.file!;
          postId =  entity.id.toInt();
          break;
        case 'comment_like':
          entity = widget.notification.likeCommentNotification!.comment;
          entityType = "comment";
          userTags = Map.fromIterable(entity.userTags, key: (v) => v.userId.toString(), value: (v) => v.userString);
          afterNotificationMessage = ": ${entity.comment}";
          clipImgFile = entity.post.fileImg.file!;
          postId =  entity.post.id.toInt();
          break;
        case 'reply_like':
          entity = widget.notification.likeReplyNotification!.reply;
          entityType = "reply";
          userTags = Map.fromIterable(entity.userTags, key: (v) => v.userId.toString(), value: (v) => v.userString);
          afterNotificationMessage = ": ${entity.reply}";
          clipImgFile = entity.comment.post.fileImg.file!;
          postId =  entity.comment.post.id.toInt();
          break;
      }

      for (int i = 0; i < entity.likes.length; i++) {
        usersHighlighs["${entity.likes[i].user.id.toInt()}"] = entity.likes[i].user.username;
        users.add(entity.likes[i].user);
      }

      if (entity.likes.length == 1) {
        message = "${users[0].username} liked your ${entityType!}$afterNotificationMessage";
      } else if (entity.likes.length > 1) {
        if (entity.likeCount == 2) {
          message = "${users[0].username} and ${users[1].username} liked your ${entityType!}$afterNotificationMessage";
        } else {
          message = "${users[0].username}, ${users[1].username} and ${entity.likeCount - 2} others liked your ${entityType!}$afterNotificationMessage";
        }
      }
    } else if (widget.type == "follow") {
      entity = widget.notification.followNotification!.follower;
      isFollowing = entity.followState;
      usersHighlighs["${entity.id.toInt()}"] = entity.username;
      users.add(entity);
      message = "${users[0].username} started following you";
    } else if (widget.type == "comment" || widget.type == "reply") {
      if (widget.type == "comment") {
        entity = widget.notification.commentNotification!.comment;
        clipImgFile = entity.post.fileImg.file!;
        postId =  entity.post.id.toInt();
        usersHighlighs["${entity.user.id.toInt()}"] = entity.user.username;
        users.add(entity.user);
        message = "${users[0].username} commented on your clip: ${entity.comment}";
      } else {
        entity = widget.notification.replyNotification!.reply;
        clipImgFile = entity.comment.post.fileImg.file!;
        postId =  entity.comment.post.id.toInt();
        usersHighlighs["${entity.user.id.toInt()}"] = entity.user.username;
        users.add(entity.user);
        message = "${users[0].username} replied to your comment: ${entity.reply}";
      }
      userTags = Map.fromIterable(entity.userTags, key: (v) => v.userId.toString(), value: (v) => v.userString);
    } else if (widget.type.contains("tag")) {
      String? entityType;
      String? text;
      switch (widget.type) {
        case 'comment_tag':
          entity = widget.notification.commentTagNotification!.comment;
          entityType = "comment";
          text = entity.comment;
          clipImgFile = entity.post.fileImg.file!;
          postId =  entity.post.id.toInt();
          break;
        case 'reply_tag':
          entity = widget.notification.replyTagNotification!.reply;
          entityType = "reply";
          text = entity.reply;
          clipImgFile = entity.comment.post.fileImg.file!;
          postId =  entity.comment.post.id.toInt();
          break;
        case 'caption_tag':
          entity = widget.notification.captionTagNotification!.post;
          entityType = "clip";
          text = entity.caption;
          clipImgFile = entity.fileImg.file!;
          postId =  entity.id.toInt();
          break;
      }

      usersHighlighs["${entity.user.id.toInt()}"] = entity.user.username;
      users.add(entity.user);

      userTags = Map.fromIterable(entity.userTags, key: (v) => v.userId.toString(), value: (v) => v.userString);

      message = "${users[0].username} tagged you in a ${entityType!}: ${text!}";
    }
  }
}