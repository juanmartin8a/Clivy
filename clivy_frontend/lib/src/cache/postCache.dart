import 'package:graphql_flutter/graphql_flutter.dart';

class PostCache {
  final HiveStore hiveStore;

  PostCache({
    required this.hiveStore
  });

  postsCache() async {
    Map<String, dynamic>? queryBox = hiveStore.get('Query');
    if (queryBox == null) {
      return null;
    }
    print(queryBox);
    // String key = queryBox.keys.where((item) => item == 'me({"token":"$token"})').toList()[0];
    // Map<String, dynamic> user = Map<String, dynamic>.from(await queryBox['$key']);

    // return user;
  }
}