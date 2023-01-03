import 'dart:collection';

import 'package:untitled_client/src/api/graphql/graphql_api.dart';

class SearchUtils {
  Future<SearchedUsers$Query$UserSearch> makeSearchedUser(
    int id,
    String username,
    String name,
    String file
  ) async {
    Map<String, dynamic> searchedUser = {};
    searchedUser["searchedUserId"] = id;
    searchedUser["updatedAt"] = DateTime.now().millisecondsSinceEpoch.toString();

    Map<String, dynamic> user = {};
    user["id"] = id;
    user["username"] = username;
    user["name"] = name;

    Map<String, dynamic> fileMap = {};
    fileMap["file"] = file;
    fileMap["error"] = null;

    user["file"] = fileMap;
    
    searchedUser["searchedUser"] = user;

    return SearchedUsers$Query$UserSearch.fromJson(searchedUser);
  }

  Future<SearchedUsers$Query> makeSearchedUsers( //Future<SearchedUsers$Query>
    Map<String, dynamic> newSearchedUser,
    SearchedUsers$Query searchedUsers
  ) async {
    Map<String, dynamic> newSearchedUsers = {};
    Map<String, dynamic> searchedUsersJson = searchedUsers.toJson();

    Map<String, dynamic> searchedUsersListMap = LinkedHashMap
      .fromIterable(searchedUsersJson["searchedUsers"], key: (e) => e["searchedUserId"].toString(), value: (e) => e);

    searchedUsersListMap[newSearchedUser["searchedUserId"].toString()] = newSearchedUser;
    
    List<dynamic> sortedList = searchedUsersListMap.values.toList()
    ..sort((k1, k2) => int.parse(k2["updatedAt"]).compareTo(int.parse(k1["updatedAt"])));

    if (sortedList.length > 10) {
      searchedUsersJson["searchedUsers"] = sortedList.sublist(0, 10);
    } else {
      searchedUsersJson["searchedUsers"] = sortedList;
    }

    newSearchedUsers = searchedUsersJson;

    return SearchedUsers$Query.fromJson(newSearchedUsers);
  }

  Future<SearchedUsers$Query> removeSearchedUser(
    int id,
    SearchedUsers$Query searchedUsers
  ) async {
    Map<String, dynamic> newSearchedUsers = {};
    Map<String, dynamic> searchedUsersJson = searchedUsers.toJson();

    List<dynamic> newSearchedUsersList = searchedUsersJson["searchedUsers"];

    newSearchedUsersList.removeWhere((element) => element["searchedUserId"] == id);

    List<dynamic> sortedList = newSearchedUsersList
    ..sort((k1, k2) => int.parse(k2["updatedAt"]).compareTo(int.parse(k1["updatedAt"])));

    searchedUsersJson["searchedUsers"] = sortedList;

    newSearchedUsers = searchedUsersJson;

    return SearchedUsers$Query.fromJson(newSearchedUsers);
  }
}