import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled_client/src/api/graphql/graphql_api.dart';
import 'package:untitled_client/src/bloc/selectVideogames/selectVideogamesCubit.dart';
import 'package:untitled_client/src/bloc/selectVideogames/selectVideogamesState.dart';
import 'package:untitled_client/src/bloc/videogames/videogamesCubit.dart';
import 'package:untitled_client/src/bloc/videogames/videogamesState.dart';
import 'package:untitled_client/src/ui/screens/createPost/widgets/selectGenres.dart';
import 'package:untitled_client/src/ui/screens/createPost/widgets/selectVideogamesTile.dart';

class SelectVideogames extends StatefulWidget {
  const SelectVideogames({ Key? key }) : super(key: key);

  @override
  _SelectVideogamesState createState() => _SelectVideogamesState();
}

class _SelectVideogamesState extends State<SelectVideogames> with SingleTickerProviderStateMixin {

  bool isPointerUp = false;

  AllVideogames$Query? videogames;
  VideogamesCubit? videogamesCubit;

  AnimationController? _animationController;
  Animation<double>? turns;
  Animation<double>? videogamesFraction;

  String? videogameFile;
  String? videogameName;

  List<int> genreList = [];

  @override
  void initState() {
    videogamesCubit = BlocProvider.of<VideogamesCubit>(context);
    videogamesCubit!.fetchVideogames();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this
    )..addListener(() {
      setState(() {});
    });
    turns = Tween<double>(begin: 0.0, end: -0.5).animate(_animationController!);
    videogamesFraction = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController!);
    super.initState();
  }

  @override
  void dispose() {
    if (_animationController != null) {
      _animationController!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Function cachedNetworkImageWidget = () => CachedNetworkImage(
      imageUrl: videogameFile!,
      fit: BoxFit.cover,
      fadeInDuration: Duration(seconds: 0),
      fadeOutDuration: Duration(seconds: 0),
    );
    Function noVideogameWidget = () => Center(
      child: Icon(
        EvaIcons.alertTriangleOutline,
        color: Colors.yellowAccent,
      )
    );
    Function otherVideogameWidget = () => Center(
      child: Text(
        "?",
        style: TextStyle(
          color: Colors.white,
          fontSize: 21,
          fontWeight: FontWeight.w600
        )
      )
    );
    return Container(
      child: BlocConsumer<VideogamesCubit, VideogameState>(
        listener: (context, state) {
          if (state is FetchByPostCountVideogamesState) {
            videogames = state.videogames;
          }
        },
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  if (
                    _animationController != null &&
                    !_animationController!.isAnimating 
                  ) {
                    if (_animationController!.isCompleted) {
                      _animationController!.reverse();
                    } else {
                      if (videogames == null) {
                        videogamesCubit!.fetchVideogames();
                      }
                      _animationController!.forward();
                    }
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  height: 76,
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: BlocBuilder<SelectVideogamesCubit, SelectVideogameState>(
                          builder: (context, state) {
                            if (state is VideogameSelectedState) {
                              videogameFile = state.file;
                              videogameName = state.name;
                            } else if (state is RemoveSelectedVideogameState) {
                              videogameFile = null;
                              videogameName = null;
                            } else if (state is GenreSelectedState) {
                              genreList = state.genreList;
                              videogameName = state.name;
                              videogameFile = null;
                            } else if (state is RemoveSelectedGenreState) {
                              genreList = state.genreList;
                              if (state.genreList.length > 0) {
                                videogameName = state.name;
                              } else {
                                videogameName = null;
                              }
                              videogameFile = null;
                            }
                            return Container(
                              height: 60,
                              child: AspectRatio(
                                aspectRatio: 9/12,
                                child: videogameFile != null 
                                ? cachedNetworkImageWidget()
                                : genreList.length > 0
                                  ? otherVideogameWidget()
                                  : noVideogameWidget()
                              )
                            );
                          }
                        )
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                "Videogame",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  // height: 1
                                )
                              ),
                            ),
                            Container(
                              child: BlocBuilder<SelectVideogamesCubit, SelectVideogameState>(
                                builder: (context, state) {
                                  if (state is VideogameSelectedState) {
                                    videogameFile = state.file;
                                    videogameName = state.name;
                                  } else if (state is RemoveSelectedVideogameState) {
                                    videogameFile = null;
                                    videogameName = null;
                                  }
                                  // if (mounted) {
                                  //   BlocProvider.of<SelectVideogamesCubit>(context).setInit();
                                  // }
                                  return Text(
                                    videogameName != null ? videogameName! : "No videogame selected",
                                    style: TextStyle(
                                      color: Colors.grey[200],
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    )
                                  );
                                }
                              )
                            )
                          ],
                        )
                      ),
                      Spacer(),
                      Container(
                        child: Center(
                          child: turns != null ? RotationTransition(
                            turns: turns!,
                            child: Icon(
                              EvaIcons.chevronDownOutline,
                              color: Colors.white,
                              size: 30
                            ),
                          ) : Container()
                        )
                      ),
                    ],
                  )
                ),
              ),
              if (videogames != null)
              Expanded(
                child: Opacity(
                  opacity: videogamesFraction!.value,
                  child: Listener(
                    onPointerUp: (_) {
                      FocusScope.of(context).unfocus();
                    },
                    child: FractionallySizedBox(
                      alignment: Alignment.topCenter,
                      heightFactor: videogamesFraction!.value,
                      child: ListView(
                        cacheExtent: 1500,
                        children: [
                          ...videogames!.allVideogames.map((videogame) {
                            return SelectVideogamesTile(
                              videogame: videogame, 
                              key: Key("${videogame.id}")
                            );
                          }).toList(),
                          SelectGenres(),
                          SizedBox(
                            height: 12 + MediaQuery.of(context).padding.bottom + 50
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        }
      )
    );
  }
}