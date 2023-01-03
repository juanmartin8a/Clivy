import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled_client/src/bloc/user/edit/editUserBloc.dart';
import 'package:untitled_client/src/bloc/user/edit/editUserState.dart';

class UsernameUI extends StatefulWidget {
  final String username;
  final bool isMe;
  final TextStyle textStyle;
  final bool forName;
  UsernameUI({
    required this.username,
    required this.isMe,
    this.textStyle = const TextStyle(
      color: Colors.white,
      fontSize: 14.5,
      fontWeight: FontWeight.w500,
      height: 1
    ),
    this.forName = false,
    required Key key
  }) : super(key: key);

  @override
  _UsernameUIState createState() => _UsernameUIState();
}

class _UsernameUIState extends State<UsernameUI> {
  late String username;

  @override
  void initState() {
    username = widget.username; 
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    if (widget.isMe == true) {
      return BlocBuilder<EditUserBloc, EditUserState>(
        builder: (context, state) {
          if (state is EditUserUpdatedState) {
            if (widget.forName == true) {
              username = state.user.name;
            } else {
              username = state.user.username;
            }
          }
          return getUsername();
        }
      );
    }

    return getUsername();
  }

  Widget getUsername() {
    return Text(
      username,
      style: widget.textStyle
      // color: Colors.white,
    );
  }
}