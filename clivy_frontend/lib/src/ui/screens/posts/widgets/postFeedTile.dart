import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled_client/src/models/currentUser.dart';
import 'package:untitled_client/src/ui/helpers/GeneralRichText.dart';
import 'package:untitled_client/src/ui/helpers/profileImg.dart';
import 'package:untitled_client/src/ui/helpers/usernameUI.dart';
import 'package:untitled_client/src/ui/screens/post/deletePostDialog.dart';
import 'package:untitled_client/src/ui/screens/post/post.dart';
import 'package:untitled_client/src/ui/screens/posts/widgets/like/likeCommentWidget.dart';
import 'package:untitled_client/src/ui/screens/posts/widgets/postTileFile.dart';
import 'package:untitled_client/src/ui/screens/user/profile.dart';

class PostFeedTile extends StatefulWidget {
  final dynamic post;//Posts$Query$PaginatedPosts$Post post;
  final String id;
  final bool isVisible;
  final int index;
  final int startFromIndex;
  final bool isFetchMore;
  final bool isListVisible;
  PostFeedTile({
    required this.post,
    required this.id,
    required this.isVisible,
    required this.index,
    required this.startFromIndex,
    required this.isFetchMore,
    required this.isListVisible,
    required Key key
  }) : super(key: key);

  @override
  _PostFeedTileState createState() => _PostFeedTileState();
}

class _PostFeedTileState extends State<PostFeedTile> with AutomaticKeepAliveClientMixin {

// class PostFeedTile extends StatelessWidget {
  // final dynamic post;//Posts$Query$PaginatedPosts$Post post;
  // final String id;
  // PostFeedTile({
  //   required this.post,
  //   required this.id,
  //   required Key key
  // }) : super(key: key);

  // @override
  // void initState() {
  //   // print("#####");
  //   // print(widget.id);
  //   // print(widget.index);
  //   // print("-----");
  //   super.initState();
  // }

  @override
  void dispose() {
    super.dispose();
    // print("disposed ${widget.key}");
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Map<String, dynamic> userTags = Map.fromIterable(widget.post.userTags, key: (v) => v.userId.toString(), value: (v) => v.userString);
    return GestureDetector(
      onLongPress: () {
        // print("aaaa");
        Get.generalDialog(
          barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
          barrierColor: Colors.black.withOpacity(0.3),
          transitionDuration: Duration(milliseconds: 300),
          pageBuilder: (context, anim1, anim2) {
            return DeleteClipDialog(
              postId: widget.post.id.toInt(), 
              key: widget.key!
            );
          },
          transitionBuilder: (context, anim1, anim2, child) {
            return SlideTransition(
              position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(new CurvedAnimation(
                parent: anim1,
                curve: Curves.decelerate
              )),
              child: child,
            );
          },
        );
        // BlocProvider.of<DeleteCubit>(context).deletePost(widget.post.id.toInt());
      },
      child: Container(
        padding: EdgeInsets.only(bottom: 16),
        color: Colors.transparent,
        // margin: EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              // width: MediaQuery.of(context).size.width,
              // height: MediaQuery.of(context).size.width,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: PostTileFile(
                  likeState: widget.post.likeState,
                  isListVisible: widget.isListVisible,
                  startFromIndex: widget.startFromIndex,
                  file: widget.post.file.file!,
                  fileHeight: widget.post.fileHeight,
                  fileWidth: widget.post.fileWidth,
                  id: widget.id,
                  postId: widget.post.id.toInt(),
                  index: widget.index,
                  isVisible: widget.isVisible,
                  isFetchMore: widget.isFetchMore,
                  key: Key('postTileFile_${widget.id}')
                ),
              )
            ),
            // const Spacer(), 
            // Align(
            //   alignment: Alignment.centerLeft,
            //   child: Container(
            //     // color: Colors.blue,
            //     padding: EdgeInsets.only(top: 4, bottom: 2),
            //     margin: EdgeInsets.symmetric(horizontal: 8),
            //     child: Text(
            //       "${widget.post.viewsCount} views",
            //       style: TextStyle(
            //         color: Colors.grey[600],
            //         fontSize: 14,
            //         fontWeight: FontWeight.w500,
            //         height: 1
            //       )
            //     )
            //   ),
            // ),
            SizedBox(height: 4),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                // color: Colors.red,
                // padding: EdgeInsets.only(top: 2),
                margin: EdgeInsets.symmetric(horizontal: 8),
                child: widget.post.caption != "" ? 
                GeneralRichText(
                  userTags: userTags,
                  firstText: "",
                  // isFirstTextName: true,
                  // nameFirstTextId: data!.user.id.toInt(),
                  text: widget.post.caption,
                  textStyle1: TextStyle(
                    color: Colors.white,
                    fontSize: 14.5,
                    fontWeight: FontWeight.w400,
                    // height: 1.2
                  ),
                  textStyle2: TextStyle(
                    color: Color(0xff00ff03),
                    fontSize: 14.5,
                    fontWeight: FontWeight.w400,
                    // height: 1.2
                  ),
                  textStyle3: TextStyle(
                    color: Colors.white,
                    fontSize: 14.5,
                    fontWeight: FontWeight.w600,
                    // height: 1.2
                  ),
                  // text: "sober me says no but ik high me would do thi",
                  key: Key("postRichText_${widget.id}")
                )
                // Container(
                //   //margin: EdgeInsets.symmetric(vertical: 2),
                //   margin: EdgeInsets.only(bottom: 2),
                //   child: Text(
                //     "sapo sapo sapo sapo sapo sapo",//widget.post.caption,
                //     textAlign: TextAlign.center,
                //     style: TextStyle(
                //       color: Colors.white,
                //       fontSize: 14,
                //       fontWeight: FontWeight.w400,
                //     )
                //   )
                // ) 
                : Container(
                  // margin: EdgeInsets.only(bottom: 2),
                  // child: Text(
                  //   "Cientos de ecuatorianos en ucrania. acompanamos a los familiares",//widget.post.caption,
                  //   textAlign: TextAlign.left,
                  //   style: TextStyle(
                  //     // fontFamily: "roboto",
                  //     color: Colors.grey[200],
                  //     fontSize: 14.5,
                  //     fontWeight: FontWeight.w400,
                  //     // height: 1
                  //   )
                  // )
                ),
              ),
            ),
            SizedBox(height: 4),
            Container(
              // color: Colors.yellow,
              padding: EdgeInsets.only(
                top: 2,
                bottom: 8
              ),
              margin: EdgeInsets.symmetric(horizontal: 8),
              // color: Colors.blue,
              child: Row(
                children: [
                  Container(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.to(
                              Profile(
                                userId: widget.post.user.id.toInt(),
                                key: Key('userProfile_${widget.post.user.id.toInt()}')
                              ),
                              preventDuplicates: false
                            );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Container(
                              height: 42,
                              width: 42,
                              child: ProfileImgLoader(
                                file: widget.post.user.smallFile.file!,
                                isMe: widget.post.user.id == CurrentUser.userId,
                                key: Key('postFeed_profileImg_${widget.id}')
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(
                              Profile(
                                userId: widget.post.user.id.toInt(),
                                key: Key('userProfile_${widget.post.user.id.toInt()}')
                              ),
                              preventDuplicates: false
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.only(left: 8),
                            child: UsernameUI(
                              username: widget.post.user.username,
                              isMe: widget.post.user.id == CurrentUser.userId,
                              textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 14.5,
                                fontWeight: FontWeight.w500,
                                height: 1
                              ),
                              key: Key('postFeed_username_${widget.id}')
                            )
                          ),
                        )
                      ],
                    )
                  ),
                  const Spacer(),
                  LikeCommentWidget(
                    uuid: widget.id,
                    post: widget.post,
                    postId: widget.post.id.toInt(),
                    likeState: widget.post.likeState!,
                    likeCount: widget.post.likeCount,
                    commentCount: widget.post.commentCount,
                    key: Key('PostCommentLike_${widget.id}')
                  )
                  // LikeWidget(
                  //   postId: widget.post.id.toInt(),
                  //   likeState: widget.post.likeState!,
                  //   likeCount: widget.post.likeCount,
                  //   key: Key('PostLike_${widget.id}')
                  // )
                ],
              )
            ),
          ],
        )
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}