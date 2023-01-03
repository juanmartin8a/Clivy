import 'package:another_flushbar/flushbar.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:untitled_client/src/bloc/flushBars/flushBarsCubit.dart';
import 'package:untitled_client/src/bloc/flushBars/flushBarsState.dart';
import 'package:untitled_client/src/bloc/homeAppBar/homeAppBarCubit.dart';
import 'package:untitled_client/src/models/currentUser.dart';
import 'package:untitled_client/src/ui/screens/activity/activity.dart';
import 'package:untitled_client/src/ui/screens/createPost/createPost.dart';
import 'package:untitled_client/src/ui/screens/home/homeAppBar.dart';
import 'package:untitled_client/src/ui/screens/home/homeBottomBar.dart';
import 'package:untitled_client/src/ui/screens/posts/widgets/postsFeedWrapper.dart';
import 'package:untitled_client/src/ui/screens/user/profile.dart';
import 'package:untitled_client/src/ui/wrapper.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController _pageController = PageController();
  HomeAppBarCubit? homeAppBarCubit;
  FlushBarsCubit? flushBarsCubit;

  // bool _stoppedMovingPage = true;

  @override
  void initState() {
    homeAppBarCubit = BlocProvider.of<HomeAppBarCubit>(context);
    flushBarsCubit = BlocProvider.of<FlushBarsCubit>(context);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      homeAppBarCubit!.changeTitleOpacity(0, _pageController.page!);
    });
    _pageController.addListener(() {
      double titleOpacity = (_pageController.page!) - _pageController.page!.floor();

      titleOpacity = (((titleOpacity - 0.1)*1) / (0.9 -  0.1));

      if (titleOpacity >= 1.0) {
        titleOpacity = 1.0;
      } else if (titleOpacity <= 0.0) {
        titleOpacity = 0.0;
      }
      
      homeAppBarCubit!.changeTitleOpacity(titleOpacity, _pageController.page!);
    });
    // print("aaaaahhh");
    // var first 
    // print(await flushBarsCubit!.stream.first);\
    // move this to run app parent
    flushBarsCubit!.stream.listen((state) {
      // print("saposaposaposopa");
      if (state is FlushBarsUploadedPostState) {
        Future.delayed(Duration(milliseconds: 500), () {
          if (mounted) {
            Flushbar(
              backgroundColor: Color(0xFF303030).withOpacity(0.98),
              margin: EdgeInsets.symmetric(horizontal: 8),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              borderRadius: BorderRadius.circular(12),
              flushbarPosition: FlushbarPosition.TOP,
              messageText: Container(
                child: Row(
                  children: [
                    Container(
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xff00ff03),
                        border: Border.all(
                          width: 2, 
                          color: Color(0xff00ff03) 
                        )
                      ),
                      child: Center(
                        child: Icon(
                          EvaIcons.checkmarkOutline,
                          color: Colors.black,
                          size: 20
                        )
                      )
                    ),
                    SizedBox(
                      width: 12
                    ),
                    Container(
                      child: Text(
                        "Clip has been posted",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        )
                      )
                    )
                  ]
                )
              ),
              duration: Duration(seconds: 7),
            )..show(context);
          }
        });
      } else if (state is FlushBarsUploadingPostState) {
        Future.delayed(Duration(milliseconds: 500), () {
          if (mounted) {
            Flushbar(
              backgroundColor: Color(0xFF303030).withOpacity(0.98),
              margin: EdgeInsets.symmetric(horizontal: 8),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              borderRadius: BorderRadius.circular(12),
              flushbarPosition: FlushbarPosition.TOP,
              messageText: Container(
                child: Row( 
                  children: [
                    Container(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Color(0xff00ff03),
                        strokeWidth: 3,
                      ),
                    ),
                    SizedBox(
                      width: 12
                    ),
                    Container(
                      child: Text(
                        "Posting Clip",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        )
                      )
                    )
                  ]
                )
              ),
              duration: Duration(seconds: 7),
            )..show(context);
          }
        });
      } else if (state is FlushBarsUploadPostFailedState) {
        Future.delayed(Duration(milliseconds: 500), () {
          if (mounted) {
            Flushbar(
              backgroundColor: Color(0xFF303030).withOpacity(0.98),
              margin: EdgeInsets.symmetric(horizontal: 8),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              borderRadius: BorderRadius.circular(12),
              flushbarPosition: FlushbarPosition.TOP,
              messageText: Container(
                child: Row( 
                  children: [
                    Center(
                      // height: 25,
                      // width: 25,
                      child: Icon(
                        EvaIcons.alertTriangleOutline,
                        color: Colors.red,
                      )
                    ),
                    SizedBox(
                      width: 12
                    ),
                    Container(
                      child: Text(
                        "Failed to post clip",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        )
                      )
                    )
                  ]
                )
              ),
              duration: Duration(seconds: 7),
            )..show(context);
          }
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double statusBar = MediaQuery.of(context).padding.top;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          color: Colors.black,
          child: Stack(
            children: [
              PageView(
                // key: Key
                controller: _pageController,
                onPageChanged: (val) {
                  print(val);
                },
                children: [
                  Column(
                    children: [ 
                      Flexible(child: PostFeedWrapper())
                    ]
                  ),
                  Profile(
                    userId: CurrentUser.userId!,
                    key: Key('userMe_${CurrentUser.userId!}'),
                  ),
                  Activity(),
                  CreatePost()
                ] 
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: statusBar + 50,
                  // color: Colors.red,
                  child: HomeAppBar(
                    statusBar: statusBar,
                    key: Key("Home App Bar"),
                  )
                )
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: HomeBottomBar(
                  animateToPage: animateToPage,
                )
              )
            ],
          )
        )
      ),
    );
  }

  void animateToPage(int pageNumber) {
    if (_pageController.hasClients) {
      // if (_stoppedMovingPage == true) {
        // _stoppedMovingPage = false;
      _pageController.jumpToPage(pageNumber);//r, duration: Duration(milliseconds: 350), curve: Curves.decelerate)
        // .then((_) {
        //   _stoppedMovingPage = true;
        // });
      // }
    }
  }
}