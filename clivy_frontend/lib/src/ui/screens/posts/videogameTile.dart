import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled_client/src/api/graphql/graphql_api.dart';
import 'package:untitled_client/src/bloc/posts/postsBloc.dart';
import 'package:untitled_client/src/bloc/posts/postsEvent.dart';

class VideogameTile extends StatefulWidget {
  final String id;
  final AllTapsVideogames$Query$Videogame videogame;
  final int videogameId;
  const VideogameTile({ 
    required this.id,
    required this.videogame,
    required this.videogameId,
    required Key key 
  }) : super(key: key);

  @override
  _VideogameTileState createState() => _VideogameTileState();
}

class _VideogameTileState extends State<VideogameTile> with AutomaticKeepAliveClientMixin {

  PostsBloc? postsBloc;

  void initState() {
    postsBloc = BlocProvider.of<PostsBloc>(context);
    // print("nooo");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GestureDetector(
      onTap: () {
        postsBloc!.add(FetchMoreVideogamePostsEvent(
          limit: 1,
          id: widget.id,
          isFetchMore: false,
          videogameId: widget.videogame.id,
          videogameName: widget.videogame.name,
        ));
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 150),
        curve: Curves.easeInOut,
        margin: EdgeInsets.only(
          left: 8,
          top: widget.videogame.id == widget.videogameId ? 4 : 8,
          bottom: widget.videogame.id == widget.videogameId ? 4 : 8
        ),
        key: ValueKey("${widget.videogame.id}"),
        height: 128,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.4),
          child: AspectRatio(
            aspectRatio: 9/12,
            child: CachedNetworkImage(
              imageUrl: widget.videogame.file.file!,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              placeholder: (context, imageProvider) => Container(
                color: Colors.transparent
              ),
              fit: BoxFit.cover,
              fadeInDuration: Duration(milliseconds: 150),
              fadeOutDuration: Duration(milliseconds: 150),
            )
          ),
        )
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}