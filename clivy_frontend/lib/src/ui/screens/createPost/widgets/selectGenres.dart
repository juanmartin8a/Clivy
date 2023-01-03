import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled_client/src/api/graphql/graphql_api.dart';
import 'package:untitled_client/src/bloc/videogames/videogamesCubit.dart';
import 'package:untitled_client/src/bloc/videogames/videogamesState.dart';
import 'package:untitled_client/src/ui/screens/createPost/widgets/selectGenresTile.dart';

class SelectGenres extends StatefulWidget {
  const SelectGenres({ Key? key }) : super(key: key);

  @override
  _SelectGenresState createState() => _SelectGenresState();
}

class _SelectGenresState extends State<SelectGenres> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  AnimationController? _animationController;
  Animation<double>? turns;
  Animation<double>? genresFraction;

  AllVideogameGenres$Query? videogameGenres;
  VideogamesCubit? videogamesCubit;

  @override
  void initState() {
    videogamesCubit = BlocProvider.of<VideogamesCubit>(context);
    _animationController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this
    )..addListener(() {
      setState(() {});
    });
    turns = Tween<double>(begin: 0.0, end: -0.5).animate(_animationController!);
    genresFraction = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController!);
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
    super.build(context);
    return BlocConsumer<VideogamesCubit, VideogameState>(
      listener: (context, state) {
        if (state is FetchVideogameGenresState) {
          videogameGenres = state.videogameGenres;
          // print(videogameGenres);
        }
      },
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
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
                    if (videogameGenres == null) {
                      videogamesCubit!.fetchVideogameGenres();
                    }
                    _animationController!.forward();
                  }
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                color: Colors.transparent,
                child: Row(
                  children: [
                    Container(
                      height: 80,
                      // color: Colors.red,
                      child: AspectRatio(
                        aspectRatio: 9/12,
                        child: Center(
                          child: Text(
                            "?",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.w800
                            )
                          )
                        ),
                      )
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              child: Text(
                                "Other",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700
                                )
                              ),
                            ),
                            Container(
                              child: Text(
                                "Videogame is not on list",
                                style: TextStyle(
                                  color: Colors.grey[200],
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500
                                )
                              )
                            ),
                          ],
                        )
                      ),
                    ),
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
                ),
              ),
            ),
            if (videogameGenres != null)
            Container(
              child: Opacity(
                opacity: genresFraction!.value,
                child: Align(
                  alignment: Alignment.topCenter,
                  heightFactor: genresFraction!.value,
                  child: ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      ...videogameGenres!.allVideogameGenres.map((genre) {
                        return SelectGenreTile(
                          videogameGenre: genre, 
                          key: Key("${genre.id}")
                        );
                      }).toList(),
                    ],
                  ),
                ),
              ),
            )
          ],
        );
      }
    );
  }

  @override
  bool get wantKeepAlive => true;
}