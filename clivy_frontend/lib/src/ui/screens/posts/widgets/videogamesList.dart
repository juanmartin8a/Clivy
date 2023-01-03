import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled_client/src/api/graphql/graphql_api.dart';
import 'package:untitled_client/src/bloc/posts/postsBloc.dart';
import 'package:untitled_client/src/bloc/queryVideogameCubit/queryVideogameCubit.dart';
import 'package:untitled_client/src/bloc/queryVideogameCubit/queryVideogameState.dart';
import 'package:untitled_client/src/bloc/videogames/videogamesCubit.dart';
import 'package:untitled_client/src/bloc/videogames/videogamesState.dart';
import 'package:untitled_client/src/ui/screens/posts/videogameTile.dart';

class VideogamesList extends StatefulWidget {
  final String id;
  const VideogamesList({
    required this.id,
    required Key key
  }) : super(key: key);

  @override
  _VideogamesListState createState() => _VideogamesListState();
}

class _VideogamesListState extends State<VideogamesList> with AutomaticKeepAliveClientMixin {

  AllTapsVideogames$Query? videogames;

  PostsBloc? postsBloc;

  void initState() {
    postsBloc = BlocProvider.of<PostsBloc>(context);
    // print("eeee");x
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<VideogamesCubit, VideogameState>(
      builder: (context, state) {
        if (state is FetchByTapCountVideogamesState) {
          videogames = state.videogames;
        }
        return BlocBuilder<QueryVideogameCubit, QueryVideogameState>(
          builder: (context, state) {
            int? videogameId;
            String? videogameName;
            if (state is QueryVideogameSelectState) {
              videogameId = state.videogameId;
              videogameName = state.videogameName;
            }
            return Container(
              height: videogameName != null ? 153 : 128,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: ListView.builder(
                      primary: true,
                      cacheExtent: 750,
                      key: PageStorageKey<String>('videogamesList'),
                      scrollDirection: Axis.horizontal,
                      physics: AlwaysScrollableScrollPhysics(),
                      itemCount: videogames != null ? videogames!.allTapsVideogames.length : 0,
                      itemBuilder: (context, index) {
                        return VideogameTile(
                          id: widget.id,
                          videogame: videogames!.allTapsVideogames[index],
                          videogameId: videogameId ?? -1,
                          key: Key("videogameTile${widget.id}-${videogames!.allTapsVideogames[index].id}")
                        );
                      },
                    ),
                  ),

                  if (videogameName != null) 
                  Container(
                    height: 25,
                    padding: EdgeInsets.only(bottom: 8, left: 8),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        videogameName,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          height: 1,
                        )
                      ),
                    )
                  ),
                ]
              ),
            );
          }
        );
      }
    );
  }

  @override
  bool get wantKeepAlive => true;
}