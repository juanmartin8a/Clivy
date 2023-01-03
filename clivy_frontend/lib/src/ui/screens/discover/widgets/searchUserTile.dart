import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:untitled_client/src/models/currentUser.dart';
import 'package:untitled_client/src/ui/helpers/profileImg.dart';
import 'package:untitled_client/src/ui/helpers/usernameUI.dart';
import 'package:untitled_client/src/ui/screens/home/widgets/floatingActions.dart';

class SearchUserTile extends StatelessWidget {
  // final SearchedUsers$Query$UserSearch  searchElement;
  final int id;
  final String username;
  final String file;
  final String name;
  final bool isSearchedUsers;
  final Function? removeSearchedUser;
  const SearchUserTile({
    required this.id,
    required this.username,
    required this.file,
    required this.name,
    this.isSearchedUsers = false,
    this.removeSearchedUser,
    required Key key 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: 8),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      color: Colors.transparent,
      child: Container(
        child: Row(
          children: [
            Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Container(
                  width: 50,
                  height: 50,
                  child: ProfileImgLoader(
                    file: file,
                    isMe: id == CurrentUser.userId,
                    key: Key('searchUser_$id')
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
                      username: username,
                      isMe: id == CurrentUser.userId,
                      key: Key('searchUser_username_$id')
                    ),
                    SizedBox(height: 4),
                    UsernameUI(
                      username: name,
                      isMe: id == CurrentUser.userId,
                      forName: true,
                      key: Key('searchUser_name_$id'),
                      textStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 14.5,
                        fontWeight: FontWeight.w400,
                        height: 1
                      ),
                    )
                    // Text(
                    //   username,
                    //   style: TextStyle(
                    //     color: Colors.white,
                    //     fontSize: 15,
                    //     fontWeight: FontWeight.w600,
                    //   )
                    // ),
                    // Text(
                    //   name,
                    //   style: TextStyle(
                    //     color: Colors.grey,
                    //     fontSize: 14,
                    //     fontWeight: FontWeight.w500,
                    //   )
                    // ),
                  ],
                )
              ),
            ),
            if (isSearchedUsers)
            Center(
              child: GestureDetector(
                onTap: () {
                  removeSearchedUser!();
                },
                child: Container(
                  color: Colors.transparent,
                  child: FloatingActions(
                    icon: EvaIcons.close,
                    padding: EdgeInsets.only(top: 8, bottom: 8, left: 4),
                    size: 18,
                    color: Colors.grey[600]!,
                    key: Key("searchedUsers_$id")
                  )
                ),
              ),
            )
          ],
        )
      ),
    );
  }
}