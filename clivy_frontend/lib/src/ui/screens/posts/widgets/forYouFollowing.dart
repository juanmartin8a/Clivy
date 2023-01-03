import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled_client/src/bloc/forYouFollowing/forYouFollowingCubit.dart';
import 'package:untitled_client/src/bloc/forYouFollowing/forYouFollowingState.dart';

class ForYouFollowing extends StatefulWidget {
  final Widget tabBar;
  const ForYouFollowing({ 
    required this.tabBar,
    Key? key 
  }) : super(key: key);

  @override
  _ForYouFollowingState createState() => _ForYouFollowingState();
}

class _ForYouFollowingState extends State<ForYouFollowing> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  AnimationController? _animController;
  Animation<Offset>? offset;
  Animation<double>? opacity;

  ForYouFollowingCubit? _forYouFollowingCubit;

  @override
  void initState() {
    _animController = AnimationController(
      duration: Duration(milliseconds: 300), 
      vsync: this
    )..addListener(() {
      setState(() {});
    });
    opacity = Tween<double>(begin: 1, end: 0.0).animate(
      CurvedAnimation(
        parent: _animController!,
        curve: Curves.easeOutCirc
      )
    );
    offset = Tween<Offset>(begin: Offset(0.0, 0.0), end: Offset(0.0, -1.0)).animate(_animController!);
    _forYouFollowingCubit = BlocProvider.of<ForYouFollowingCubit>(context);
    _forYouFollowingCubit!.stream.listen((state) {
      cubitListener(state);
    });
    super.initState();
  }

  @override
  void dispose() {
    _animController?.dispose();
    _animController = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Positioned(
      top: MediaQuery.of(context).padding.top + 50,
      left: (MediaQuery.of(context).size.width / 2) - (190 / 2),
      // right: MediaQuery.of(context).size.width / 2,
      child: SlideTransition(
        position: offset!,
        child: Container(
          // color: Colors.red,
          height: 43,
          width: 190,

          padding: EdgeInsets.only(top: 8),
          child: Opacity(
            opacity: opacity != null ? opacity!.value : 1,
            child: Align(
              alignment: Alignment.center,
              child: widget.tabBar,
            ),
          ),
        ),
      ),
    );
  }

  void cubitListener(state) {
    if (_animController != null) {
      if (state is ShowForYouFollowingState) {
        if (!_animController!.isAnimating) {
          _animController?.reverse();
        } else {
          Future.delayed(Duration(milliseconds: 200), () {
            _animController?.reverse();
          });
        }
      } else if (state is UnshowForYouFollowingState) {
        if (!_animController!.isAnimating) {
          _animController?.forward();
        } else {
          Future.delayed(Duration(milliseconds: 200), () {
            _animController?.forward();
          });
        }
      }
    }
  }

  @override
  bool get wantKeepAlive => true;
}