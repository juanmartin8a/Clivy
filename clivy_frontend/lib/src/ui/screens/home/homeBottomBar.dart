import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled_client/src/bloc/homeAppBar/homeAppBarCubit.dart';
import 'package:untitled_client/src/bloc/homeAppBar/homeAppBarState.dart';

class HomeBottomBar extends StatefulWidget {
  final Function animateToPage;
  const HomeBottomBar({ 
    required this.animateToPage,
    Key? key 
  }) : super(key: key);

  @override
  _HomeBottomBarState createState() => _HomeBottomBarState();
}

class _HomeBottomBarState extends State<HomeBottomBar> with AutomaticKeepAliveClientMixin {

  late HomeAppBarCubit _appBarCubit;

  double homeOpacity = 1;
  double profileOpacity = 0;
  double notificationsOpacity = 0;
  double newClipOpacity = 0;

  @override
  void initState() {
    _appBarCubit = BlocProvider.of<HomeAppBarCubit>(context);
    _appBarCubit.stream.listen((state) {
      if (state is HomeAppBarChangePageState) {
        // if (state.cl)
        if (state.clivyOpacity > 0.5) {
          if (mounted) {
            setState(() {
              homeOpacity = 1;
              profileOpacity = 0;
              notificationsOpacity = 0;
              newClipOpacity = 0;
            });
          }
        } else if (state.usernameOpacity > 0.5) {
          if (mounted) {
            setState(() { 
              homeOpacity = 0;
              profileOpacity = 1;
              notificationsOpacity = 0;
              newClipOpacity = 0;
            });
          }
        } else if (state.activityOpacity > 0.5) {
          if (mounted) {
            setState(() {
              homeOpacity = 0;
              profileOpacity = 0;
              notificationsOpacity = 1;
              newClipOpacity = 0;
            });
          }
        } else if (state.createClipOpacity > 0.5) {
          if (mounted) {
            setState(() {
              homeOpacity = 0;
              profileOpacity = 0;
              notificationsOpacity = 0;
              newClipOpacity = 1;
            });
          }
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      width: MediaQuery.of(context).size.width * 0.55,
      decoration: BoxDecoration(
        color: Color(0xFF202020),
        borderRadius: BorderRadius.circular(50)
      ),
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              widget.animateToPage(0);
            },
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 150),
              child: homeOpacity == 1
              ? Container(
                key: ValueKey<String>("homeIcon1"),
                child: Icon(
                  FluentIcons.home_16_regular,
                  size: 30,
                  color: Color(0xff00ff03),
                )
              ) 
              : Container(
                key: ValueKey<String>("homeIcon2"),
                child: Icon(
                  FluentIcons.home_16_regular,
                  size: 30,
                  color: Colors.grey,
                )
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              widget.animateToPage(1);
            },
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 150),
              child: profileOpacity == 1
              ? Container(
                key: ValueKey<String>("profileIcon1"),
                child: Icon(
                  FluentIcons.person_24_regular,
                  size: 30,
                  color: Color(0xff00ff03),
                )
              ) 
              : Container(
                key: ValueKey<String>("profileIcon2"),
                child: Icon(
                  FluentIcons.person_24_regular,
                  size: 30,
                  color: Colors.grey,
                )
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              widget.animateToPage(2);
            },
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 150),
              child: notificationsOpacity == 1
              ? Container(
                key: ValueKey<String>("notificationsIcon1"),
                child: Icon(
                  FluentIcons.mail_24_regular,
                  size: 30,
                  color: Color(0xff00ff03),
                )
              ) 
              : Container(
                key: ValueKey<String>("notificationsIcon2"),
                child: Icon(
                  FluentIcons.mail_24_regular,
                  size: 30,
                  color: Colors.grey,
                )
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              widget.animateToPage(3);
            },
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 150),
              child: newClipOpacity == 1
              ? Container(
                key: ValueKey<String>("newClipIcon1"),
                child: Icon(
                  FluentIcons.add_square_24_regular,
                  size: 30,
                  color: Color(0xff00ff03),
                )
              ) 
              : Container(
                key: ValueKey<String>("newClipIcon2"),
                child: Icon(
                  FluentIcons.add_square_24_regular,
                  size: 30,
                  color: Colors.grey,
                )
              ),
              // Container(
              //   child: Icon(
              //     FluentIcons.add_square_24_regular,
              //     size: 30,
              //     color: Colors.grey,
              //   )
              // ),
            ),
          ),
        ]
      )
    );
  }

  @override
  bool get wantKeepAlive => true;
}