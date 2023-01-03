import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:untitled_client/src/api/graphql/graphql_api.dart';
import 'package:untitled_client/src/bloc/follow/followCubit.dart';
import 'package:untitled_client/src/bloc/follow/followState.dart';
import 'package:untitled_client/src/models/currentUser.dart';
import 'package:untitled_client/src/ui/screens/user/widgets/followButton.dart';
import 'package:untitled_client/src/ui/screens/user/widgets/profileFollowTile.dart';
import 'package:untitled_client/src/ui/screens/user/widgets/userFollowers.dart';
import 'package:untitled_client/src/ui/screens/user/widgets/userFollowing.dart';

class ProfileFollowWidget extends StatefulWidget {
  final User$Query$User user;
  final bool isMyprofile;
  const ProfileFollowWidget({
    required this.user,
    required this.isMyprofile,
    required Key key
  }) : super(key: key);

  @override
  _ProfileFollowWidgetState createState() => _ProfileFollowWidgetState();
}

class _ProfileFollowWidgetState extends State<ProfileFollowWidget> {

  int? followersCount;
  int? followingCount;
  bool? isFollowing;

  String? clientId;

  @override
  void initState() {
    followersCount = widget.user.followersCount;
    followingCount = widget.user.followingCount;
    isFollowing = widget.user.followState;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.blue,
      child: Center(
        child: BlocConsumer<FollowCubit, FollowState>(
          listener: (context, state) {
            if (state is FollowUserState) {
              if (
                state.userId == widget.user.id.toInt() || 
                CurrentUser.userId == widget.user.id.toInt()
              ) {
                if (state.isPre) {
                  clientId = state.clientId;
                  if (state.clientId == clientId) {
                    isFollowing = true;
                    if (CurrentUser.userId == widget.user.id.toInt()) {
                      followingCount = followingCount! + 1;
                    } else {
                      followersCount = followersCount! + 1;
                    }
                  }
                }
              }
            } else if (state is UnfollowUserState) {
              if (
                state.userId == widget.user.id.toInt() || 
                CurrentUser.userId == widget.user.id.toInt()
              ) {
                if (state.isPre) {
                  clientId = state.clientId;
                  if (state.clientId == clientId) {
                    isFollowing = false;
                    if (CurrentUser.userId == widget.user.id.toInt()) {
                      followingCount = followingCount! - 1;
                    } else {
                      followersCount = followersCount! - 1;
                    }
                  }
                }
              }
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                Container(
                  // color: Colors.red,
                  width: MediaQuery.of(context).size.width * 0.7,
                  // height: 60,
                  // margin: EdgeInsets.only(top: 12),
                  // color: Colors.red,
                  child: StaggeredGridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 3,
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      Center(
                        child: ProfileFollowTile(
                          value: widget.user.postCount.toString(), 
                          name: "Clips", 
                          key: Key("profileFollowData_${widget.user.id}_clips")
                        )
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Get.to(UserFollowers(
                              id: widget.user.id.toInt(),
                              key: Key("userFollowers_${widget.user.id.toString()}")
                            ));
                          },
                          child: ProfileFollowTile(
                            value: "${followersCount ?? widget.user.followersCount}", 
                            name: "Followers",
                            key: Key("profileFollowData_${widget.user.id}_followers")
                          ),
                        )
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Get.to(UserFollowing(
                              id: widget.user.id.toInt(),
                              key: Key("userFollowing_${widget.user.id.toString()}")
                            ));
                          },
                          child: ProfileFollowTile(
                            value: "${followingCount ?? widget.user.followingCount}", 
                            name: "Following", 
                            key: Key("profileFollowData_${widget.user.id}_following")
                          ),
                        )
                      )
                    ],
                    staggeredTiles: List.generate(3, (index) {
                      return StaggeredTile.fit(1);
                    }),
                  )
                ),
                if (isFollowing != null) 
                SizedBox(
                  height: 18
                ),
                if (isFollowing != null) Container(
                  child: FollowButton(
                    isFollowing: isFollowing!,
                    isMyProfile: widget.isMyprofile,
                    user: widget.user,
                    key: Key("profileFollowButton_${widget.user.id}"),
                  ),
                )
                // widget.user.followButton
              ],
            );
          }
        )
      )
    );
  }
}