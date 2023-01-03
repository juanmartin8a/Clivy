import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:untitled_client/src/api/graphql/graphql_api.dart';
import 'package:untitled_client/src/bloc/follow/followCubit.dart';
import 'package:untitled_client/src/ui/screens/user/editProfile.dart';

class FollowButton extends StatelessWidget {
  final User$Query$User user;
  final bool isMyProfile;
  final bool isFollowing;
  const FollowButton({ 
    required this.user,
    required this.isMyProfile,
    required Key key,
    required this.isFollowing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isMyProfile) {
      return GestureDetector(
        onTap: () {
          Get.to(EditProfile(
            user: user, 
            key: Key('EditProfile')
          ));
        },
        child: Container(
          // padding: EdgeInsets.symmetric(vertical: 10),
          width: 170,
          height: 40,
          decoration: BoxDecoration(
            // color: Color(0xff00ff03),
            border: Border.all(color: Color(0xff00ff03), width: 2),
            borderRadius: BorderRadius.circular(20)
          ),
          child: Center(
            child: Container(
              // color: Colors.yellow,
              child: Text(
                'Edit',
                style: TextStyle(
                  color: Color(0xff00ff03),
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  height: 1
                )
              )
            )
          )
        )
      ); 
    }
    return GestureDetector(
      onTap: () {
        BlocProvider.of<FollowCubit>(context).followUnfollowUser(
          userId: user.id.toInt(), isFollow: isFollowing
        );
      },
      child: Container(
        // padding: EdgeInsets.symmetric(vertical: 10),
        width: 170,
        height: 40,
        decoration: BoxDecoration(
          // color: Color(0xff00ff03),
          // color: Color(0xff00ff03),
            border: Border.all(color: Color(0xff00ff03), width: 2),
            borderRadius: BorderRadius.circular(20)
          // borderRadius: BorderRadius.circular(25)
        ),
        child: Center(
          child: Text(
            isFollowing ? 'Following' : 'Follow',
            style: TextStyle(
              color: Color(0xff00ff03),
              fontSize: 15,
              fontWeight: FontWeight.w600,
              height: 1
            )
          ),
        )
      )
    );
  }
}