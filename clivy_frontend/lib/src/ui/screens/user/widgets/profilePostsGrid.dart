import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:untitled_client/src/api/graphql/graphql_api.dart';
import 'package:untitled_client/src/ui/screens/user/widgets/profilePostsList.dart';
import 'package:provider/provider.dart';

class ProfilePostsGrid extends StatelessWidget {
  final int userId;
  final String id;
  final String name;
  final QueryResult? queryResult;
  final UserPosts$Query$PaginatedPosts? userPosts;
  final Widget loadingWidget;
  const ProfilePostsGrid({ 
    required this.userId,
    required this.id,
    required this.name,
    this.queryResult,
    this.userPosts,
    required this.loadingWidget,
    required Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),// BouncingScrollPhysics(parent: ClampingScrollPhysics()),
        child: Column(
          children: [
            userPosts != null ? StaggeredGridView.count(
              padding: EdgeInsets.only(left: 6, right: 6),
              crossAxisCount: 4,
              mainAxisSpacing: 6,
              primary: true,
              shrinkWrap: true,
              crossAxisSpacing: 6,
              physics: NeverScrollableScrollPhysics(),//BouncingScrollPhysics(parent: ClampingScrollPhysics()),
              children: List.generate(userPosts!.posts.length, (i) {
                UserPosts$Query$PaginatedPosts$Post userPost = userPosts!.posts[i];
                return GestureDetector(
                  onTap: () {
                    
                    Get.to(
                    //   MultiProvider(
                    //     providers: [
                    //       // ChangeNotifierProvider(
                    //       //   create: (context) => PostsChangeNotifier()
                    //       // ),
                    //       ChangeNotifierProvider(
                    //         create: (context) => ProfilePostsChangeNotifier(),
                    //         // child: 
                    //       ),
                    //       // ChangeNotifierProvider(
                    //       //   create: (context) => PostsRefreshChangeNotifier()
                    //       // ),
                    //     ],
                    //     builder: (context, child) {
                    //       return child!;
                    //     },
                    //     child: ProfilePostsList(
                    //       index: i,
                    //       tappedPostId: userPost.id.toInt(),
                    //       userId: userId,
                    //       id: id,
                    //       name: name,
                    //       userPosts: userPosts!,
                    //       queryResult: queryResult!,
                    //       loadingWidget: loadingWidget,
                    //       key: Key('profilePostList_$userId')
                    //     )
                    //   )
                    // );
                      // ChangeNotifierProvider<ProfilePostsChangeNotifier>.value(
                      //   value: ProfilePostsChangeNotifier(),
                      //   child: 
                        ProfilePostsList(
                          index: i,
                          tappedPostId: userPost.id.toInt(),
                          userId: userId,
                          id: id,
                          name: name,
                          userPosts: userPosts!,
                          queryResult: queryResult!,
                          loadingWidget: loadingWidget,
                          key: Key('profilePostList_$userId')
                        )
                      // )
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: i == 0 ? Radius.circular(20) : Radius.circular(3),
                      topRight: i == 1 ? Radius.circular(20) : Radius.circular(3),
                      bottomLeft: i == (userPosts!.posts.length - 2) ? Radius.circular(20) : Radius.circular(3),
                      bottomRight: i == (userPosts!.posts.length - 1) ? Radius.circular(20) : Radius.circular(3),
                    ),
                    child: Container(
                      child: Image.network(
                        userPost.fileGif.file!,
                        fit: BoxFit.cover,
                      )
                    ),
                  )
                );
              }),
              staggeredTiles: List.generate(userPosts!.posts.length, (index) {
                return StaggeredTile.fit(2);
              }),
            )
            : Container(),
            Container(
              child: loadingWidget
            )
          ],
        ),
      )
    );
  }
}