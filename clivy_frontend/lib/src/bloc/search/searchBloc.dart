import 'package:bloc/bloc.dart';
import 'package:untitled_client/src/api/graphql/graphql_api.dart';
import 'package:untitled_client/src/bloc/search/searchEvent.dart';
import 'package:untitled_client/src/bloc/search/searchState.dart';
import 'package:untitled_client/src/repos/searchRepository.dart';
import 'package:untitled_client/src/utils/search/searchUtils.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRepository searchRepo;
  SearchBloc({
    required this.searchRepo
  }) : super(SearchInitState());

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is SearchedUsersEvent) {
      try {
        SearchedUsers$Query? searchedUsers = await searchRepo.searchedUsers();
        yield SearchedLoadedState(
          searchedUsers: searchedUsers,
          id: event.id
        );
      } catch(err) {
        print("error getting init searched users");
        print(err);
      }
    }
    if (event is SearchSubmitEvent) {
      if (event.search.length > 0) {
        try {
          final searchResults = await searchRepo.searchUsers(event.search);
          yield SearchLoadedState(
            search: searchResults,
            id: event.id
          );
        } catch(err) {
          print('error searching for results');
          print(err);
        }
      } else {
        Map<String, dynamic> searchResultsMap = {};
        searchResultsMap["searchUsers"] = [];
        SearchUsers$Query searchResults = SearchUsers$Query.fromJson(searchResultsMap);
        
        yield SearchLoadedState(
          search: searchResults,
          id: event.id
        );
      }
    }
    if (event is SearchedUserAddedEvent) {
      try {
        SearchedUsers$Query$UserSearch? searchedUser;
        SearchedUsers$Query? newSearchedUsers;
        await Future.delayed(Duration(milliseconds: 400), () async {
          searchedUser = await SearchUtils().makeSearchedUser(
            event.userId, event.username, event.name, event.file
          );
          newSearchedUsers = await SearchUtils().makeSearchedUsers(
            searchedUser!.toJson(), event.searchedUsers
          );
        });
        yield SearchedLoadedState(
          searchedUsers: newSearchedUsers!,
          id: event.id
        );
        await searchRepo.userTapped(event.userId);
      } catch(e) {
        print("Error: $e");
      }
    }
    if (event is SearchedUserRemoveEvent) {
      try {
        final newSearchedUsers = await SearchUtils().removeSearchedUser(
          event.userId, event.searchedUsers
        );
        yield SearchedLoadedState(
          searchedUsers: newSearchedUsers,
          id: event.id
        );
        await searchRepo.deleteUserSearch(event.userId);
      } catch(e) {
        print("Error: $e");
      }
    }
  }
  
}