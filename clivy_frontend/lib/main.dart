import 'dart:io';
import 'dart:math';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_apns/flutter_apns.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/route_manager.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:untitled_client/src/bloc/TextFocUnfoc/textFocUnfocCubit.dart';
import 'package:untitled_client/src/bloc/commentLike/commentLikeCubit.dart';
import 'package:untitled_client/src/bloc/comments/commentBloc.dart';
import 'package:untitled_client/src/bloc/comments/commentCounter/commentCounterCubit.dart';
import 'package:untitled_client/src/bloc/comments/commentEvent.dart';
import 'package:untitled_client/src/bloc/comments/commentOrReply/commentOrReplyEvent.dart';
import 'package:untitled_client/src/bloc/comments/commentOrReply/commentOrReplyBloc.dart';
import 'package:untitled_client/src/bloc/comments/replies/repliesBloc.dart';
import 'package:untitled_client/src/bloc/comments/replies/repliesEvent.dart';
import 'package:untitled_client/src/bloc/commentsOrUsers/commentsOrUsersCubit.dart';
import 'package:untitled_client/src/bloc/deletePost/deletePostCubit.dart';
import 'package:untitled_client/src/bloc/deleteUserBloc/deleteUserCubit.dart';
import 'package:untitled_client/src/bloc/flushBars/flushBarsCubit.dart';
import 'package:untitled_client/src/bloc/follow/followCubit.dart';
import 'package:untitled_client/src/bloc/forYouFollowing/forYouFollowingCubit.dart';
import 'package:untitled_client/src/bloc/forgotPassword/forgotPasswordCubit.dart';
import 'package:untitled_client/src/bloc/gallery/galleryBloc.dart';
import 'package:untitled_client/src/bloc/gallery/galleryEvent.dart';
import 'package:untitled_client/src/bloc/gallery/loading/galleryLoadingCubit.dart';
import 'package:untitled_client/src/bloc/homeAppBar/homeAppBarCubit.dart';
import 'package:untitled_client/src/bloc/imgSize/imgSizeCubit.dart';
import 'package:untitled_client/src/bloc/like/likeBloc.dart';
import 'package:untitled_client/src/bloc/loading/loadinComments/loadingCommentsCubit.dart';
import 'package:untitled_client/src/bloc/loading/loadingBloc.dart';
import 'package:untitled_client/src/bloc/loading/loadingNotifications/loadingNotificationsCubit.dart';
import 'package:untitled_client/src/bloc/loading/loadingReplies/loadingRepliesCubit.dart';
import 'package:untitled_client/src/bloc/loading/loadingSinglePost/loadingSinglePostCubit.dart';
import 'package:untitled_client/src/bloc/loading/loadingUserFollow/loadingUserFollowCubit.dart';
import 'package:untitled_client/src/bloc/loading/loadingUserPosts/loadingUserPostsCubit.dart';
import 'package:untitled_client/src/bloc/me/meBloc.dart';
import 'package:untitled_client/src/bloc/me/meEvent.dart';
import 'package:untitled_client/src/bloc/notifications/notificationsCubit.dart';
import 'package:untitled_client/src/bloc/posts/postsBloc.dart';
import 'package:untitled_client/src/bloc/posts/postsEvent.dart';
import 'package:untitled_client/src/bloc/postsHelperBloc/postsHelperBloc.dart';
import 'package:untitled_client/src/bloc/profilePostsHelperBloc/profilePostsHelperBloc.dart';
import 'package:untitled_client/src/bloc/queryVideogameCubit/queryVideogameCubit.dart';
import 'package:untitled_client/src/bloc/search/searchBloc.dart';
import 'package:untitled_client/src/bloc/search/searchEvent.dart';
import 'package:untitled_client/src/bloc/selectVideogames/selectVideogamesCubit.dart';
import 'package:untitled_client/src/bloc/signIn/signInCubit.dart';
import 'package:untitled_client/src/bloc/signOut/signOutCubit.dart';
import 'package:untitled_client/src/bloc/signUp/signUpCubit.dart';
import 'package:untitled_client/src/bloc/singlePost/singlePostCubit.dart';
import 'package:untitled_client/src/bloc/uploadPost/uploadPostBloc.dart';
import 'package:untitled_client/src/bloc/uploadPost/uploadPostEvent.dart';
import 'package:untitled_client/src/bloc/user/edit/editUserBloc.dart';
import 'package:untitled_client/src/bloc/user/edit/editUserEvent.dart';
import 'package:untitled_client/src/bloc/user/userBloc.dart';
import 'package:untitled_client/src/bloc/user/userEvent.dart';
import 'package:untitled_client/src/bloc/userFollow/userFollowCubit.dart';
import 'package:untitled_client/src/bloc/userPosts/userPostsBloc.dart';
import 'package:untitled_client/src/bloc/userPosts/userPostsEvent.dart';
import 'package:untitled_client/src/bloc/userTagAutocomplete/userTagAutocompleteCubit.dart';
import 'package:untitled_client/src/bloc/videogames/videogamesCubit.dart';
import 'package:untitled_client/src/client/client.dart';
import 'package:untitled_client/src/client/customLink.dart';
import 'package:untitled_client/src/repos/galleryRepository.dart';
import 'package:untitled_client/src/repos/notificationRepository.dart';
import 'package:untitled_client/src/repos/postRepository.dart';
import 'package:untitled_client/src/repos/searchRepository.dart';
import 'package:untitled_client/src/repos/userRepository.dart';
import 'package:untitled_client/src/repos/videogamesRepository.dart';
import 'package:untitled_client/src/ui/wrapper.dart';
import 'package:provider/provider.dart';
void main() async {
  await initHiveForFlutter();
  final HttpLink _httpLink = HttpLink(
    ""
  );
  WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
    await Firebase.initializeApp();
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    Box deviceTokenBox = Hive.box("deviceTokenBox");
    var savedDeviceToken = await deviceTokenBox.get("deviceToken");

    _firebaseMessaging.onTokenRefresh.listen((apnsToken) async {
      if (apnsToken != savedDeviceToken) {
        try {
          await UserRepository(client: Client.client!).addNewDeviceTokenMutation(
            apnsToken, Platform.isIOS
          );
        } catch(e) {}
      }
      print("onTokenRefresh");
    });
  });

  await Hive.initFlutter();
  await Hive.openBox('deviceTokenBox');

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

  final IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings(
    requestAlertPermission: false,
    requestBadgePermission: false,
    requestSoundPermission: false,
  );

  InitializationSettings initializationSettings = InitializationSettings(
    iOS: initializationSettingsIOS,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings, onSelectNotification: (String? payload) async {
      print("on select notification");
      if (payload != null) {
        print('notification payload: $payload');
      }
    }
  );

  await Hive.initFlutter();
  await Hive.openBox('deviceTokenBox');

  final connector = createPushConnector();

  // connector.
  connector.configure(
    onLaunch: (message) async {
      print("onLaunch");
    },
    onResume: (message) async {
      print("onResume");
    },
    onMessage: (message) async {
      print("onMessage");
      print(message.notification);
      print(message.notification!.title);
      print(message.notification!.title);
      IOSNotificationDetails iosDetails = IOSNotificationDetails();
      NotificationDetails notiDetails = NotificationDetails(
        iOS: iosDetails
      );
      await flutterLocalNotificationsPlugin.show(
        Random().nextInt(1000),
        message.notification?.title,
        message.notification?.body,
        notiDetails,
      );
    },
    onBackgroundMessage: (message) async {
      print("onBackground");
    }
  );

  final Link _link;

  final CustomLink _customLink = CustomLink();

  _link = _customLink.concat(_httpLink);

  print(_customLink);

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: _link,
      cache: GraphQLCache(store: HiveStore())
    )
  );

  print(client.value);

  Client.client = client.value;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print('client is ${Client.client}');
    return MultiBlocProvider(
      providers: [
        BlocProvider<PostsHelperCubit>(
          create: (context) => PostsHelperCubit()
        ),
        BlocProvider<ProfilePostsHelperCubit>(
          create: (context) => ProfilePostsHelperCubit()
        ),
        BlocProvider<MeBloc>(
          create: (context) => MeBloc(
            userRepo: UserRepository(client: Client.client!)
          )..add(MeInitEvent()),
        ),
        BlocProvider<SignInCubit>(
          create: (context) => SignInCubit(
            userRepo: UserRepository(client: Client.client!),
            meBloc: BlocProvider.of<MeBloc>(context)
          )
        ),
        BlocProvider<SignOutCubit>(
          create: (context) => SignOutCubit(
            userRepo: UserRepository(client: Client.client!),
            meBloc: BlocProvider.of<MeBloc>(context)
          )
        ),
        BlocProvider<ForgotPasswordCubit>(
          create: (context) => ForgotPasswordCubit(
            userRepo: UserRepository(client: Client.client!),
            meBloc: BlocProvider.of<MeBloc>(context)
          )
        ),
        BlocProvider<SignUpCubit>(
          create: (context) => SignUpCubit(
            userRepo: UserRepository(client: Client.client!),
            meBloc: BlocProvider.of<MeBloc>(context)
          )
        ),
        BlocProvider<HomeAppBarCubit>(
          create: (context) => HomeAppBarCubit()
        ),
        BlocProvider<GalleryLoadingCubit>(
          create: (context) => GalleryLoadingCubit()
        ),
        BlocProvider<LoadingNotificationsCubit>(
          create: (context) => LoadingNotificationsCubit()
        ),
        BlocProvider<LoadingSinglePostCubit>(
          create: (context) => LoadingSinglePostCubit()
        ),
        BlocProvider<GalleryBloc>(
          create: (context) => GalleryBloc(
            galleryLoadingCubit: BlocProvider.of<GalleryLoadingCubit>(context),
            galleryRepo: GalleryRepository()
          )..add(GalleryInitEvent()),
        ),
        BlocProvider<FetchPostsLoadingCubit>(
          create: (context) => FetchPostsLoadingCubit(),
        ),
        BlocProvider<CommentsOrUsersCubit>(
          create: (context) => CommentsOrUsersCubit(),
        ),
        BlocProvider<UserTagAutocompleteCubit>(
          create: (context) => UserTagAutocompleteCubit(),
        ),
        BlocProvider<ForYouFollowingCubit>(
          create: (context) => ForYouFollowingCubit(),
        ),
        BlocProvider<QueryVideogameCubit>(
          create: (context) => QueryVideogameCubit(),
        ),
        BlocProvider<PostsBloc>(
          create: (context) => PostsBloc(
            postRepo: PostRepository(
              client: Client.client!
            ),
            loadingBloc: BlocProvider.of<FetchPostsLoadingCubit>(context),
            queryVideogameCubit: BlocProvider.of<QueryVideogameCubit>(context),
          )..add(FetchMoreInitEvent()),
        ),
        BlocProvider<DeleteCubit>(
          create: (context) => DeleteCubit(
            postRepo: PostRepository(
              client: Client.client!
            ),
            // loadingBloc: BlocProvider.of<FetchPostsLoadingCubit>(context),
            // queryVideogameCubit: BlocProvider.of<QueryVideogameCubit>(context),
          ),
        ),
        BlocProvider<DeleteUserCubit>(
          create: (context) => DeleteUserCubit(
            userRepo: UserRepository(
              client: Client.client!,
            ),
            meBloc: BlocProvider.of<MeBloc>(context)
          ),
        ),
        BlocProvider<LikeCubit>(
          create: (context) => LikeCubit(
            postRepo: PostRepository(
              client: Client.client!
            ),
          ),
        ),
        BlocProvider<SinglePostCubit>(
          create: (context) => SinglePostCubit(
            postRepo: PostRepository(
              client: Client.client!
            ),
            loadingCubit: BlocProvider.of<LoadingSinglePostCubit>(context)
          ),
        ),
        BlocProvider<CommentLikeCubit>(
          create: (context) => CommentLikeCubit(
            postRepo: PostRepository(
              client: Client.client!
            ),
          ),
        ),
        BlocProvider<TextFocusUnfocusCubit>(
          create: (context) => TextFocusUnfocusCubit(),
        ),
        BlocProvider<SearchBloc>(
          create: (context) => SearchBloc(
            searchRepo: SearchRepository(
              client: Client.client!
            ),
          )..add(SearchInitEvent()),
        ),
        BlocProvider<VideogamesCubit>(
          create: (context) => VideogamesCubit(
            videogameRepo: VideogamesRepository(
              client: Client.client!,
            ),
            meBloc: BlocProvider.of<MeBloc>(context)
          ),
        ),
        BlocProvider<SelectVideogamesCubit>(
          create: (context) => SelectVideogamesCubit(),
        ),
        BlocProvider<FlushBarsCubit>(
          create: (context) => FlushBarsCubit(),
        ),
        BlocProvider<UploadPostBloc>(
          create: (context) => UploadPostBloc(
            flushBarsCubit: BlocProvider.of<FlushBarsCubit>(context),
            postRepo: PostRepository(
              client: Client.client!
            ),
          )..add(UploadPostInitEvent()),
        ),
        BlocProvider<LoadingCommentsCubit>(
          create: (context) => LoadingCommentsCubit(),
        ),
        BlocProvider<LoadingRepliesCubit>(
          create: (context) => LoadingRepliesCubit(),
        ),
        BlocProvider<LoadingUserFollowCubit>(
          create: (context) => LoadingUserFollowCubit(),
        ),
        BlocProvider<FollowCubit>(
          create: (context) => FollowCubit(
            userRepo: UserRepository(
              client: Client.client!
            ),
          ),
        ),
        BlocProvider<UserFollowCubit>(
          create: (context) => UserFollowCubit(
            loadingCubit: BlocProvider.of<LoadingUserFollowCubit>(context),
            userRepo: UserRepository(
              client: Client.client!
            ),
          ),
        ),
        BlocProvider<CommentCounterCubit>(
          create: (context) => CommentCounterCubit(),
        ),
        BlocProvider<CommentBloc>(
          create: (context) => CommentBloc(
            postRepo: PostRepository(
              client: Client.client!
            ),
            loadingBloc: BlocProvider.of<LoadingCommentsCubit>(context),
            commentCounterBloc: BlocProvider.of<CommentCounterCubit>(context)
          )..add(CommentInitEvent()),
        ),
        BlocProvider<CommentOrReplyBloc>(
          create: (context) => CommentOrReplyBloc()..add(CommentOrReplyInitEvent()),
        ),
        BlocProvider<RepliesBloc>(
          create: (context) => RepliesBloc(
            loadingCubit: BlocProvider.of<LoadingRepliesCubit>(context),
            postRepo: PostRepository(
              client: Client.client!
            ),
            commentBloc: BlocProvider.of<CommentBloc>(context),
            commentOrReplyBloc: BlocProvider.of<CommentOrReplyBloc>(context),
            commentCounterBloc: BlocProvider.of<CommentCounterCubit>(context)
          )..add(RepliesInitEvent()),
        ),
        BlocProvider<ImgSizeCubit>(
          create: (context) => ImgSizeCubit()
        ),
        BlocProvider<UserBloc>(
          create: (context) => UserBloc(
            userRepo: UserRepository(
              client: Client.client!
            ),
          )..add(UserInitEvent()),
        ),
        BlocProvider<NotificationsCubit>(
          create: (context) => NotificationsCubit(
            notificationRepo: NotificationRepository(
              client: Client.client!
            ),
            loadingCubit: BlocProvider.of<LoadingNotificationsCubit>(context)
          )
        ),
        BlocProvider<LoadingUserPostsCubit>(
          create: (context) => LoadingUserPostsCubit(),
        ),
        BlocProvider<UserPostsBloc>(
          create: (context) => UserPostsBloc(
            postRepo: PostRepository(
              client: Client.client!
            ),
            loadingBloc: BlocProvider.of<LoadingUserPostsCubit>(context),
          )..add(UserPostsInitEvent()),
        ),
        BlocProvider<EditUserBloc>(
          create: (context) => EditUserBloc(
            userRepo: UserRepository(
              client: Client.client!
            ),
            userBloc: BlocProvider.of<UserBloc>(context),
          )..add(EditUserInitEvent()),
        ),
      ],
      child: 
      // MultiProvider(
      //   providers: [
      //     ChangeNotifierProvider<PostsChangeNotifier>.value(
      //       value: PostsChangeNotifier()
      //     ),
      //     ChangeNotifierProvider<ProfilePostsChangeNotifier>.value(
      //       value: ProfilePostsChangeNotifier()
      //     ),
      //     ChangeNotifierProvider<ProfileRefreshChangeNotifier>.value(
      //       value: ProfileRefreshChangeNotifier()
      //     ),
      //     ChangeNotifierProvider<PostsRefreshChangeNotifier>.value(
      //       value: PostsRefreshChangeNotifier()
      //     ),
      //     // ChangeNotifierProvider<PostsChangeNotifier>(
      //     //   create: (context) => PostsChangeNotifier()
      //     // ),
      //     // ChangeNotifierProvider<ProfilePostsChangeNotifier>(
      //     //   create: (context) => ProfilePostsChangeNotifier()
      //     // ),
      //     // ChangeNotifierProvider<ProfileRefreshChangeNotifier>(
      //     //   create: (context) => ProfileRefreshChangeNotifier()
      //     // ),
      //     // ChangeNotifierProvider<PostsRefreshChangeNotifier>(
      //     //   create: (context) => PostsRefreshChangeNotifier()
      //     // ),
      //   ],
      //   child: 
        GetMaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.blue,
            fontFamily: "Inter"//"Montserrat"//"Rubik", //"Kumbh_Sans" //"Metropolis" // "Kumbh_Sans" // "Hind"//"MPlus1",
            // textTheme: GoogleFonts.mPlus1pTextTheme(
            //   Theme.of(context).textTheme,
            // ),
          ),
          initialRoute: "/",
          // routes: {
          //   '/': (context) => Wrapper(),
          // },
          home: 
          // MaterialApp(
          //   title: 'Clivy',
          //   theme: ThemeData(
          //     primarySwatch: Colors.blue,
          //     fontFamily: "MPlus1",
          //     // textTheme: GoogleFonts.mPlus1pTextTheme(
          //     //   Theme.of(context).textTheme,
          //     // ),
          //   ),
          //   home: 
            Navigator(
              onGenerateRoute: (routeSettigns) => MaterialPageRoute(
                builder: (_) => Wrapper(),
                settings: RouteSettings(name: "/"),
              ),
            )
            // Wrapper()
          // )
        )
      // )
    );
  }
}
