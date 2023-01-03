import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled_client/src/api/graphql/graphql_api.dart';
import 'package:untitled_client/src/bloc/like/likeBloc.dart';
import 'package:untitled_client/src/bloc/like/likeState.dart';
import 'package:untitled_client/src/bloc/loading/loadingSinglePost/loadingSinglePostCubit.dart';
import 'package:untitled_client/src/bloc/loading/loadingSinglePost/loadingSinglePostState.dart';
import 'package:untitled_client/src/bloc/singlePost/singlePostCubit.dart';
import 'package:untitled_client/src/bloc/singlePost/singlePostState.dart';
import 'package:untitled_client/src/ui/helpers/loader.dart';
import 'package:untitled_client/src/ui/screens/posts/widgets/postFeedTile.dart';
import 'package:untitled_client/src/utils/customAppBar.dart';
import 'package:uuid/uuid.dart';
import 'package:visibility_detector/visibility_detector.dart';

class PostScreen extends StatefulWidget {
  final int id;
  const PostScreen({
    required this.id,
    required Key key,
  }) : super(key: key);

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {

  String uuid = Uuid().v4();

  bool isVisible = true;

  bool singlePostloading = true;

  late SinglePostCubit singlePostCubit;
  SinglePost$Query? singlePost;

  @override
  void initState() {
    singlePostCubit = BlocProvider.of<SinglePostCubit>(context);
    singlePostCubit.getSinglePost(widget.id, uuid);
    BlocProvider.of<LikeCubit>(context).stream.listen((state) {
      if (state is LikePostState || state is UnlikePostState) {
        if (singlePost != null) {

          int? likeCubitPostId;
          var isLike;

          if (state is LikePostState) {
            likeCubitPostId = state.postId;
            isLike = true;
          } else if (state is UnlikePostState) {
            likeCubitPostId = state.postId;
            isLike = false;
          }

          if (singlePost!.singlePost!.id.toInt() == likeCubitPostId!) {
            singlePostCubit.changeSinglePost(
              singlePost!,
              uuid,
              likeCubitPostId,
              {
                "likeState": isLike,
                "likeCount": isLike ? singlePost!.singlePost!.likeCount + 1 : singlePost!.singlePost!.likeCount - 1
              },
            );
          }
        }
      }
    });
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    double statusBar = MediaQuery.of(context).padding.top;
    return Material(
      color: Colors.black,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: MediaQuery.of(context).size.width, 
              height: statusBar + 45,
              color: Colors.black,
              child: CustomAppBar(
                statusBar: statusBar,
                title: "Clip",//"${widget.name} Posts",
                key: Key('clipAppBar_${widget.id}')
              )
            )
          ),
          BlocBuilder<LoadingSinglePostCubit, LoadingSinglePostState>(
            builder: (context, loadingState) {
              if (loadingState is SinglePostLoadingState) {
                if (loadingState.uuid == uuid) {
                  singlePostloading = true;
                  return Container(
                    margin: EdgeInsets.only(top: 45),
                    child: Loader()
                  );
                }
                singlePostloading = false;
                return Container();
              }
              singlePostloading = false;
              return Container(); 
            }
          ),
          VisibilityDetector(
            onVisibilityChanged: (visibilityInfo) {
              double visiblePercentage = visibilityInfo.visibleFraction * 100;
              if (visiblePercentage <= 0) {
                if (isVisible == true) {
                  if (mounted) {
                    setState(() {
                      isVisible = false;
                    });
                  }
                }
              } else {
                if (isVisible == false) {
                  if (mounted) {
                    setState(() {
                      isVisible = true;
                    });
                  }
                }
              }
            },
            key: Key("clipVDID_${widget.id}"),
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: BlocBuilder<SinglePostCubit, SinglePostState>(
                builder: (context, state) {
                  if (state is SinglePostReadyState) {
                    if (state.uuid == uuid) {
                      singlePost = state.singlePost;
                     }
                  }
                  if (singlePost != null) {
                    return PostFeedTile(
                      isListVisible: isVisible,
                      isFetchMore: false,
                      startFromIndex: 0,
                      post: singlePost!.singlePost,
                      id: "clipId_${widget.id}",
                      isVisible: isVisible,
                      index: 0,
                      key: ValueKey("clipId_${widget.id}")
                    );
                  }
                  return Container();
                }
              )
            ),
          )
        ],
      )
    );
  }
}