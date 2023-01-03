import 'package:flutter/material.dart';
import 'package:untitled_client/src/api/graphql/graphql_api.dart';
import 'package:untitled_client/src/ui/screens/user/widgets/profileFollow.dart';

class ProfileData extends StatelessWidget {
  final int userId;
  final bool? isMyProfile;
  final User$Query$User? user;
  const ProfileData({ 
    this.isMyProfile,
    this.user,
    required this.userId,
    required Key key 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                // margin: EdgeInsets.only(top: 20),
                // color: Colors.red,
                child: Text(
                  user?.name ?? "",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: user != null 
                      ? user!.username.length <= 20 ? 22 : 20
                      : 22,
                    fontWeight: FontWeight.w800,
                    height: 1
                  )
                )
              ),
              SizedBox(
                height: 12
              ),
              Container(
                child: Center(
                  child: user?.bio != "" && user != null 
                    ? Text(
                      user!.bio,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14.5,
                        fontWeight: FontWeight.w500,
                        // height: 1.2
                      )
                    )
                    : Container(
                      // child: Text(
                      //   "akewbchj kadnca akjqedchnqkj c adsuhcqec ecb dhcefacwevcx",
                      //   textAlign: TextAlign.center,
                      //   style: TextStyle(
                      //     color: Colors.grey,
                      //     fontSize: 14.5,
                      //     fontWeight: FontWeight.w500,
                      //     // height: 1.2
                      //   )
                      // ),
                    ),
                ),
              )
            ],
          ),
        ),
        if (user != null)
        SizedBox(
          height: 12
        ),
        if (user != null) ProfileFollowWidget(
          user: user!,
          isMyprofile: isMyProfile!,
          key: Key("profileFollowWidget_${user!.id}")
        ),
        SizedBox(
          height: 18
        ),
      ],
    );
  }
}