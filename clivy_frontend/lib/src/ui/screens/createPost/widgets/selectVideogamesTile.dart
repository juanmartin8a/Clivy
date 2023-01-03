import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled_client/src/api/graphql/graphql_api.dart';
import 'package:untitled_client/src/bloc/selectVideogames/selectVideogamesCubit.dart';
import 'package:untitled_client/src/bloc/selectVideogames/selectVideogamesState.dart';

class SelectVideogamesTile extends StatelessWidget {
  final AllVideogames$Query$Videogame videogame;
  const SelectVideogamesTile({
    required this.videogame,
    required Key key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isSelected = false;
    return GestureDetector(
      onTap: () {
        if (!isSelected) {
          BlocProvider.of<SelectVideogamesCubit>(context)
            .selectVideogame(
              videogame.id, videogame.file.file!, videogame.name, videogame.videogameGenre, true
            );
        } else {
          BlocProvider.of<SelectVideogamesCubit>(context)
            .selectVideogame(
              videogame.id, videogame.file.file!, videogame.name, videogame.videogameGenre, false
            );
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        color: Colors.transparent,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Container(
                height: 80,
                child: AspectRatio(
                  aspectRatio: 9 / 12,
                  child: CachedNetworkImage(
                    imageUrl: videogame.file.file!,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    fit: BoxFit.cover,
                    fadeInDuration: Duration(milliseconds: 150),
                    fadeOutDuration: Duration(milliseconds: 150),
                  )
                )
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      child: Text(
                        videogame.name,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          height: 1
                        )
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 4),
                      child: Wrap(
                        runSpacing: 3.0,
                        spacing: 3.0,
                        children: [
                          ...videogame.videogameGenre.map((genre) {
                            return Container(
                              // height: 25,
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.grey[800],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                genre.videogameGenre.videogameGenre,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.grey[200],
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  height: 1
                                )
                              )
                            );
                          }).toList()
                        ],
                      ),
                    ),
                  ],
                )
              ),
            ),
            BlocBuilder<SelectVideogamesCubit, SelectVideogameState>(
              builder: (context, state) {
                isSelected = false;
                if (state is VideogameSelectedState) {
                  if (state.id == videogame.id) {
                    isSelected = true;
                  }
                } else if (state is RemoveSelectedVideogameState) {
                  if (state.id == videogame.id) {
                    isSelected = false;
                  }
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
                      color: Colors.black,
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
}