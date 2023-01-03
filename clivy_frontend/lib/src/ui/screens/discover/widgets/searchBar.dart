import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:untitled_client/src/bloc/commentsOrUsers/commentsOrUsersCubit.dart';
import 'package:untitled_client/src/bloc/search/searchBloc.dart';
import 'package:untitled_client/src/bloc/search/searchEvent.dart';
import 'package:untitled_client/src/ui/screens/home/widgets/floatingActions.dart';

class SearchBar extends StatefulWidget {
  // final TextFocusUnfocusState focusState;
  final String id;
  SearchBar({
    // required this.focusState,
    required this.id
  });
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController _textEditingController = TextEditingController();
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        // BlocProvider.of<TextFocusUnfocusCubit>(context).focusUnfocus(true);
      }
    });

  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      // padding: EdgeInsets.symmetric(horizontal: 12),
      height: 50,
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.grey[850],
                borderRadius: BorderRadius.circular(21),
              ),
              height: 38,
              child: Row(
                children: [
                  Container(
                    // color: Colors.red,
                    child: FloatingActions(
                      icon: EvaIcons.searchOutline,
                      size: 26,
                      padding: EdgeInsets.symmetric(
                        horizontal: 8, vertical: 6
                      ),
                      key: Key("searchBarIcon")
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      textInputAction: TextInputAction.done,
                      focusNode: _focusNode,
                      controller: _textEditingController,
                      cursorColor: Color(0xff00ff03),
                      textAlignVertical: TextAlignVertical.center,
                      keyboardAppearance: Brightness.dark,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        height: 1.25
                      ),
                      decoration: InputDecoration(
                        isCollapsed: true,
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        contentPadding: EdgeInsets.only(right: 8, top: 9, bottom: 9),
                        hintText: 'Search',
                        hintStyle: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          // height: 2
                        ),
                      ),
                      onChanged: (values) { 
                        if (values.length <= 0) {
                          BlocProvider.of<CommentsOrUsersCubit>(context).setUsers(widget.id);
                        } else {
                          BlocProvider.of<CommentsOrUsersCubit>(context).setComments(widget.id);
                        }
                        BlocProvider.of<SearchBloc>(context).add(
                          SearchSubmitEvent(
                            search: values,
                            id: widget.id
                          )
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          // if (widget.focusState is TextFocusState)
          GestureDetector(
            onTap: () {
              _textEditingController.clear();
              FocusScope.of(context).unfocus();
              // if ()
              BlocProvider.of<CommentsOrUsersCubit>(context).setUsers(widget.id);
              BlocProvider.of<SearchBloc>(context).add(
                SearchSubmitEvent(
                  search: '',
                  id: widget.id
                )
              );
              // BlocProvider.of<TextFocusUnfocusCubit>(context).focusUnfocus(false);
              Get.back();
            },
            child: Container(
              padding: EdgeInsets.only(right: 8),
              child: Text(
                "Cancel",
                style: TextStyle(
                  color: Color(0xff00ff03),
                  fontSize: 16,
                  fontWeight: FontWeight.w600
                )
              )
            ),
          )
        ],
      )
    );
  }
}