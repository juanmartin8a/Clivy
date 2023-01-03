import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled_client/src/api/graphql/graphql_api.dart';
import 'package:untitled_client/src/bloc/commentsOrUsers/commentsOrUsersCubit.dart';
import 'package:untitled_client/src/bloc/commentsOrUsers/commentsOrUsersState.dart';
import 'package:untitled_client/src/bloc/search/searchBloc.dart';
import 'package:untitled_client/src/bloc/search/searchState.dart';
import 'package:untitled_client/src/bloc/userTagAutocomplete/userTagAutocompleteCubit.dart';
import 'package:untitled_client/src/ui/screens/createPost/widgets/selectVideogames.dart';
import 'package:untitled_client/src/ui/screens/discover/widgets/searchUserTile.dart';

class UploadScreenSettings extends StatefulWidget {
  final String id;
  const UploadScreenSettings({ 
    required this.id,
    Key? key 
  }) : super(key: key);

  @override
  _UploadScreenSettingsState createState() => _UploadScreenSettingsState();
}

class _UploadScreenSettingsState extends State<UploadScreenSettings> {

  bool isUserTags = false;

  SearchUsers$Query? searchUsers;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CommentsOrUsersCubit, CommentsOrUsersState>(
      listener: (context, state) {
        if (state is SetCommentsState) {
          if (state.id == widget.id) {
            isUserTags = false;
          }
        } else if (state is SetUsersState) {
          if (state.id == widget.id) {
            isUserTags = true;
          }
        }
      },
      builder: (context, state) {
        if (isUserTags) {
          return BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              if (state is SearchLoadedState) {
                if (state.id == widget.id) {
                  if (
                    state.search != null
                  ) {
                    searchUsers = state.search;
                  }
                }
              }
              return NotificationListener(
                onNotification: (ScrollNotification scrollInfo) {
                  return true;
                },
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      if (
                        state is SearchLoadedState && 
                        state.id == widget.id &&
                        state.search != null
                      )
                      ...searchUsers!.searchUsers.map((searchElement) {
                        return GestureDetector(
                          onTap: () {
                            BlocProvider.of<UserTagAutocompleteCubit>(context)
                              .autocompleteUserTag(widget.id, searchElement.id.toInt(), searchElement.username);
                          },
                          child: SearchUserTile(
                            name: searchElement.name,
                            username: searchElement.username,
                            file: searchElement.smallFile.file!,
                            id: searchElement.id.toInt(),
                            // forTags: true,
                            // idString: widget.id,
                            key: Key("captionSearchUserTagsTile_${searchElement.id}")
                          ),
                        );
                      })
                    ],
                  )
                )
              );
            }
          );
        }
        return SelectVideogames();
      }
    );
  }
}

// fix on keyboard scroll list problem
// twitter like