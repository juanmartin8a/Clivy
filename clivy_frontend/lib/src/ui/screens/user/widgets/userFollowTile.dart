import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:untitled_client/src/bloc/follow/followCubit.dart';
import 'package:untitled_client/src/bloc/follow/followState.dart';
import 'package:untitled_client/src/models/currentUser.dart';
import 'package:untitled_client/src/ui/helpers/profileImg.dart';
import 'package:untitled_client/src/ui/helpers/usernameUI.dart';
import 'package:untitled_client/src/ui/screens/user/profile.dart';

class UserFollowTile extends StatefulWidget {
  final dynamic user;
  const UserFollowTile({ 
    required this.user,
    required Key key 
  }) : super(key: key);

  @override
  _UserFollowTileState createState() => _UserFollowTileState();
}

class _UserFollowTileState extends State<UserFollowTile> {
  bool? isFollowing;

  String? clientId;

  @override
  void initState() {
    isFollowing = widget.user.followState;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          Profile(
            userId: widget.user.id.toInt(),
            key: Key('userProfile_${widget.user.id.toInt()}')
          ),
          preventDuplicates: false
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        color: Colors.transparent, 
        child: Row(
          children: [
            Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Container(
                  width: 50,
                  height: 50,
                  child: ProfileImgLoader(
                    file: widget.user.smallFile.file!,
                    isMe: widget.user.id.toInt() == CurrentUser.userId,
                    key: Key('searchUser_${widget.user.id}')
                  )
                )
              )
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UsernameUI(
                      username: widget.user.username,
                      isMe: widget.user.id == CurrentUser.userId,
                      key: Key('userFollowing_username_${widget.user.id}')
                    ),
                    SizedBox(height: 4),
                    UsernameUI(
                      username: widget.user.name,
                      isMe: widget.user.id == CurrentUser.userId,
                      forName: true,
                      key: Key('userFollowing_name_${widget.user.id}'),
                      textStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 14.5,
                        fontWeight: FontWeight.w400,
                        height: 1
                      ),
                    )
                  ],
                )
              ),
            ),
            if (widget.user.id.toInt() != CurrentUser.userId)
            BlocBuilder<FollowCubit, FollowState>(
              builder: (context, state) {
                if (state is FollowUserState) {
                  if (state.userId == widget.user.id.toInt()) {
                    if (state.isPre) {
                      clientId = state.clientId;
                      if (state.clientId == clientId) {
                        isFollowing = true;
                      }
                    }
                  }
                } else if (state is UnfollowUserState) {
                  if (state.userId == widget.user.id.toInt()) {
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
                          userId: widget.user.id.toInt(), isFollow: isFollowing!
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
            )
          ],
        ),
      ),
    );
  }
}