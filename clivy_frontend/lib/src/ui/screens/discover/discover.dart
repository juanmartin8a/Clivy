import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:untitled_client/src/api/graphql/graphql_api.dart';
import 'package:untitled_client/src/bloc/commentsOrUsers/commentsOrUsersCubit.dart';
import 'package:untitled_client/src/bloc/commentsOrUsers/commentsOrUsersState.dart';
import 'package:untitled_client/src/bloc/search/searchBloc.dart';
import 'package:untitled_client/src/bloc/search/searchEvent.dart';
import 'package:untitled_client/src/bloc/search/searchState.dart';
import 'package:untitled_client/src/ui/screens/discover/widgets/searchBar.dart';
import 'package:untitled_client/src/ui/screens/discover/widgets/searchUserTile.dart';
import 'package:untitled_client/src/ui/screens/user/profile.dart';
import 'package:uuid/uuid.dart';

class Search extends StatefulWidget {
  final double statusBarHeight;
  Search({
    required this.statusBarHeight
  });
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  SearchUsers$Query? searchUsers;
  SearchedUsers$Query? searchedUsers;
  String id = Uuid().v4();
  SearchBloc? searchBloc;

  bool isSearchedUsers = true;

  @override 
  void initState() {
    searchBloc = BlocProvider.of<SearchBloc>(context);
    searchBloc!.add(SearchedUsersEvent(id: id));
    // searchBloc!.stream.listen((state) {
    //   if (state is SearchedLoadedState) {
    //     if (state.id == id) {
    //       print(state.searchedUsers);
    //       searchedUsers = state.searchedUsers;
    //     }
    //   }
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(top: widget.statusBarHeight),
        child: 
        // BlocBuilder<TextFocusUnfocusCubit, TextFocusUnfocusState>(
        //   builder: (context, focusState) {
        //     return 
            Column(
              children: [
                SearchBar(
                  // focusState: focusState, 
                  id: id
                ),
                //focusState is TextFocusState
                //? 
                Expanded(
                  child: Container(
                    child: BlocConsumer<CommentsOrUsersCubit, CommentsOrUsersState>(
                      listener: (context, state) {
                        if (state is SetCommentsState) {
                          if (state.id == id) {
                            isSearchedUsers = false;
                          }
                        } else if (state is SetUsersState) {
                          if (state.id == id) {
                            isSearchedUsers = true;
                          }
                        }
                      },
                      builder: (context, state) {
                        // if (!isSearchedUsers) {
                          return SingleChildScrollView(
                            physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                            child: BlocConsumer<SearchBloc, SearchState>(
                              listener: (context, state) {
                                if (state is SearchedLoadedState) {
                                  if (state.id == id) {
                                    searchedUsers = state.searchedUsers;
                                  }
                                }
                                if (state is SearchLoadedState) {
                                  if (state.id == id) {
                                    if (
                                      state.search != null
                                    ) {
                                      searchUsers = state.search;
                                    }
                                  }
                                }
                              },
                              builder: (context, state) {
                                return Column(
                                  children: [
                                    if (isSearchedUsers && searchedUsers != null)
                                    ...searchedUsers!.searchedUsers.asMap().entries.map((searchElement) {
                                      // print(i);
                                      int index = searchElement.key;
                                      SearchedUsers$Query$UserSearch searchedUser = searchElement.value;
                                      return Column(
                                        children: [
                                          if (index == 0)
                                          Container(
                                            width: MediaQuery.of(context).size.width,
                                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                            // color: Colors.red,
                                            child: Text(
                                              "Recent searches",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600
                                              )
                                            )
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              BlocProvider.of<SearchBloc>(context).add(
                                                SearchedUserAddedEvent(
                                                  id: id,
                                                  userId: searchedUser.searchedUserId, 
                                                  file: searchedUser.searchedUser.file.file!, 
                                                  name: searchedUser.searchedUser.name,
                                                  username: searchedUser.searchedUser.username, 
                                                  searchedUsers: searchedUsers!
                                                )
                                              );
                                              Get.to(
                                                Profile(
                                                  userId: searchedUser.searchedUserId,
                                                  key: Key('userProfile_${searchedUser.searchedUserId}')
                                                ),
                                                preventDuplicates: false
                                              );
                                            },
                                            child: SearchUserTile(
                                              name: searchedUser.searchedUser.name,
                                              username: searchedUser.searchedUser.username,
                                              file: searchedUser.searchedUser.file.file!,
                                              id: searchedUser.searchedUserId,
                                              isSearchedUsers: true,
                                              removeSearchedUser: () {
                                                BlocProvider.of<SearchBloc>(context).add(
                                                  SearchedUserRemoveEvent(
                                                    id: id,
                                                    userId: searchedUser.searchedUserId, 
                                                    searchedUsers: searchedUsers!
                                                  )
                                                );
                                              },
                                              key: Key("searchedUserTile_${searchedUser.searchedUserId}")
                                            ),
                                          ),
                                        ]
                                      );
                                    }).toList(),
                                    if (!isSearchedUsers && searchUsers != null)  
                                    ...searchUsers!.searchUsers.map((searchElement) {
                                      return GestureDetector(
                                        onTap: () {
                                          BlocProvider.of<SearchBloc>(context).add(
                                            SearchedUserAddedEvent(
                                              id: id, 
                                              userId: searchElement.id.toInt(), 
                                              file: searchElement.smallFile.file!, 
                                              name: searchElement.name, 
                                              username: searchElement.username, 
                                              searchedUsers: searchedUsers!
                                            )
                                          );
                                          Get.to(
                                            Profile(
                                              userId: searchElement.id.toInt(),
                                              key: Key('userProfile_${searchElement.id}')
                                            ),
                                            preventDuplicates: false
                                          );
                                        },
                                        child: SearchUserTile(
                                          name: searchElement.name,
                                          username: searchElement.username,
                                          file: searchElement.smallFile.file!,
                                          id: searchElement.id.toInt(),
                                          key: Key("searchUserTile_${searchElement.id}")
                                        ),
                                      );
                                    })
                                  ],
                                );
                              }, 
                            )
                          );
                      }
                    )
                    // BlocBuilder<SearchBloc, SearchState>(
                    //   builder: (context, state) {
                    //     if (state is SearchLoadedState) {
                    //       if (state.id == id) {
                    //         if (
                    //           state.isSearchResults == true &&
                    //           state.search != null
                    //         ) {
                    //           searchUsers = state.search;
                    //         } else if (
                    //           state.isSearchResults == false &&
                    //           state.searchedUsers != null
                    //         ) {
                    //           searchedUsers = state.searchedUsers;
                    //         }
                    //       }
                    //     }
                    //     return SingleChildScrollView(
                    //       physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                    //       child: Column(
                    //         children: [
                    //           if (
                    //             state is SearchLoadedState &&
                    //             state.id == id &&
                    //             state.isSearchResults == false && 
                    //             state.searchedUsers != null
                    //           )
                    //           ...searchedUsers!.searchedUsers.map((searchElement) {
                    //             return SearchUserTile(
                    //               name: searchElement.searchedUser.name,
                    //               username: searchElement.searchedUser.username,
                    //               file: searchElement.searchedUser.file.file!,
                    //               id: searchElement.searchedUserId,
                    //               key: Key("searchedUserTile_${searchElement.searchedUserId}")
                    //             );
                    //           }),

                    //           if (
                    //             state is SearchLoadedState && 
                    //             state.id == id &&
                    //             state.isSearchResults == true &&
                    //             state.search != null
                    //           ) 
                    //           ...searchUsers!.searchUsers.map((searchElement) {
                    //             return SearchUserTile(
                    //               name: searchElement.name,
                    //               username: searchElement.username,
                    //               file: searchElement.file.file!,
                    //               id: searchElement.id.toInt(),
                    //               key: Key("searchUserTile_${searchElement.id}")
                    //             );
                    //           })
                    //         ],
                    //       )
                    //     );
                    //   }
                    // )
                  ),
                ) //: Container()
              ],
          //   );
          // }
        ),
      )
    );
  }
}