// import 'package:graphql_flutter/graphql_flutter.dart';

// class UserCache {
//   final HiveStore hiveStore;

//   UserCache({
//     required this.hiveStore
//   });

//   late int meId;

//   meCache() async {
//     Map<String, dynamic>? queryBox = hiveStore.get('Query');
//     if (queryBox == null) {
//       return null;
//     }
//     String key = queryBox.keys.where((item) => item.startsWith('me')).toList()[0];
//     Map<String, dynamic> user = Map<String, dynamic>.from(await queryBox['$key']);

//     return user;
//   }
// }