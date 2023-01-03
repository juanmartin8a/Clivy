import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:untitled_client/src/bloc/deletePost/deletePostCubit.dart';

class DeleteDialog extends StatelessWidget{
  final int commentId;
  final bool isReply;
  const DeleteDialog({ 
    required this.commentId,
    required this.isReply,
    required Key key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Get.back();
            }
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width - 32,
              margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewPadding.top > 0 
                ? MediaQuery.of(context).viewPadding.top
                : 20
              ),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(16)
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      BlocProvider.of<DeleteCubit>(context).deleteComment(commentId, isReply);
                      Get.back();
                    },
                    child: Container(
                      color: Colors.transparent,
                      height: 50,
                      child: Center(
                        child: Text(
                          "Delete",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                            fontWeight: FontWeight.w500
                          )
                        ),
                      )
                    ),
                  ),
                  Container(
                    color: Colors.black,
                    height: 0.5
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      color: Colors.transparent,
                      height: 50,
                      child: Center(
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            color: Colors.grey[200],
                            fontSize: 16,
                            fontWeight: FontWeight.w500
                          )
                        ),
                      )
                    ),
                  )
                ],
              )
            ),
          ),
        ],
      ),
    );
  }
}