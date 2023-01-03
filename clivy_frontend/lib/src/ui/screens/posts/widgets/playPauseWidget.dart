import 'package:decorated_icon/decorated_icon.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PlayPauseWidget extends StatelessWidget {
  final bool isPaused;
  const PlayPauseWidget({ 
    required this.isPaused,
    required Key key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      child: AnimatedOpacity(
        duration: Duration(milliseconds: 150),
        opacity: isPaused == false ? 0 : 1,
        child: DecoratedIcon(
          FontAwesomeIcons.play,
          size: 40,
          color: Colors.grey[50]!.withOpacity(0.7),
          shadows: [
            BoxShadow(
              color: Colors.grey[700]!.withOpacity(0.6),
              spreadRadius: 2,
              blurRadius: 8,
              offset: Offset(0, 0),
            ),
          ],
        ),
      )
    );
  }
}