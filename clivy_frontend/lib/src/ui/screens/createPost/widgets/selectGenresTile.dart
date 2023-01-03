import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled_client/src/api/graphql/graphql_api.dart';
import 'package:untitled_client/src/bloc/selectVideogames/selectVideogamesCubit.dart';
import 'package:untitled_client/src/bloc/selectVideogames/selectVideogamesState.dart';

class SelectGenreTile extends StatefulWidget {
  final AllVideogameGenres$Query$VideogameGenre videogameGenre;
  const SelectGenreTile({
    required this.videogameGenre,
    required Key key
  }) : super(key: key);

  @override
  _SelectGenreTileState createState() => _SelectGenreTileState();
}

class _SelectGenreTileState extends State<SelectGenreTile> with AutomaticKeepAliveClientMixin {
  
  bool isSelected = false;

  List<int> genreList = [];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GestureDetector(
      onTap: () {
        if (!isSelected) {
          BlocProvider.of<SelectVideogamesCubit>(context)
            .selectGenre(widget.videogameGenre.id, "Other", genreList, true);
        } else {
          BlocProvider.of<SelectVideogamesCubit>(context)
            .selectGenre(widget.videogameGenre.id, "Other", genreList, false);
        }
      },
      child: Container(
        // padding: EdgeInsets.symmetric(horizontal: 12),
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        // color: Colors.red,
        child: Row(
          children: [
            Expanded(
              child: Container(
                // margin: EdgeInsets.only(left: 8, right: 8),
                child: Text(
                  widget.videogameGenre.videogameGenre,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700
                  )
                )
              ),
            ),
            BlocBuilder<SelectVideogamesCubit, SelectVideogameState>(
              builder: (context, state) {
                if (state is VideogameSelectedState) {
                  isSelected = false;
                  genreList = [];
                }
                if (state is GenreSelectedState) {
                  if (state.genreList.contains(widget.videogameGenre.id)) {
                    isSelected = true;
                  }
                  genreList = state.genreList;
                } else if (state is RemoveSelectedGenreState) {
                  if (state.id == widget.videogameGenre.id) {
                    isSelected = false;
                  }
                  genreList = state.genreList;
                }
                return Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected ? Color(0xff00ff03) : Colors.transparent,
                    border: Border.all(
                      width: 2, 
                      color: isSelected ? Color(0xff00ff03) : Colors.grey[800]!
                    )
                  ),
                  child: isSelected ? Center(
                    child: Icon(
                      EvaIcons.checkmarkOutline,
                      color: Colors.white,
                      size: 20
                    )
                  ) : Container()
                );
              }
            )
          ],
        )
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}