import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled_client/src/bloc/posts/postsBloc.dart';
import 'package:untitled_client/src/bloc/posts/postsEvent.dart';
import 'package:untitled_client/src/ui/screens/posts/postsFeed.dart';
import 'package:untitled_client/src/ui/screens/posts/widgets/forYouFollowing.dart';
import 'package:uuid/uuid.dart';
import 'package:provider/provider.dart';

class PostFeedWrapper extends StatefulWidget {
  const PostFeedWrapper({ Key? key }) : super(key: key);

  @override
  _PostFeedWrapperState createState() => _PostFeedWrapperState();
}

class _PostFeedWrapperState extends State<PostFeedWrapper> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController? _tabController;

  String forYouId = Uuid().v4();
  String followingId = Uuid().v4();

  @override 
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    if (_tabController != null) {
      _tabController!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      // color: Colors.transparent,
      // margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 50),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 50),
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: [
                PostFeed(isFollowing: false, id: forYouId, key: Key("forYouPostFeed")),
                PostFeed(isFollowing: true, id: followingId, key: Key("followingPostFeed"))
              ]
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 43,
              // margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 50),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.red,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black38, Colors.black.withOpacity(0)]
                )
              )
            )
          ),
          ForYouFollowing(
            tabBar: TabBar(
              controller: _tabController,
              indicatorPadding: EdgeInsets.zero,
              labelPadding: EdgeInsets.zero,
              indicatorWeight: 0,
              indicatorSize: TabBarIndicatorSize.label,
              indicator: BubbleTabIndicator(
                indicatorHeight: 35,
                // indicatorRadius: 18.0,
                indicatorColor: Colors.white,
                tabBarIndicatorSize: TabBarIndicatorSize.label,
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              ),
              onTap: (index) {
                if (index == 0 && !_tabController!.indexIsChanging) {
                  BlocProvider.of<PostsBloc>(context).add(FetchMoreEvent(
                    limit: 1,
                    id: forYouId,
                    isFetchMore: false,
                    isFollowing: false,
                    queryResult: null
                  ));
                }
              },
              tabs: [
                AnimatedBuilder(
                  animation: _tabController!.animation!,
                  builder: (context, widget) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        
                        "For You",
                        style: TextStyle(
                          color: ColorTween(begin: Colors.black, end: Colors.white).animate(_tabController!.animation!).value,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          height: 1
                        )
                      )
                    );
                  }
                ),
                AnimatedBuilder(
                  animation: _tabController!.animation!,
                  builder: (context, widget) {
                    return Container(
                      // color: Colors.yellow,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      // padding: EdgeInsets.only(bottom: 10, top: 10, left: 10, right: 10),
                      // height: 35,
                      // padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "Following",
                        style: TextStyle(
                          // fontFamily: "Roboto",
                          // fontStyle: FontStyle.,
                          color: ColorTween(begin: Colors.white, end: Colors.black).animate(_tabController!.animation!).value,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          height: 1
                        )
                      )
                    );
                  }
                )
              ]
            )
          ),
        ],
      )
    );
  }

  @override
  bool get wantKeepAlive => true;
}