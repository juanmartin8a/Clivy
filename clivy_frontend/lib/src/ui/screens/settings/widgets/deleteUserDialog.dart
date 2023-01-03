import 'package:another_flushbar/flushbar.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:untitled_client/src/bloc/deletePost/deletePostCubit.dart';
import 'package:untitled_client/src/bloc/deleteUserBloc/deleteUserCubit.dart';
import 'package:untitled_client/src/bloc/deleteUserBloc/deleteUserState.dart';

class DeleteUserDialog extends StatefulWidget {
  const DeleteUserDialog({ Key? key }) : super(key: key);

  @override
  _DeleteUserDialogState createState() => _DeleteUserDialogState();
}

// class _DeleteUswrDialogState extends State<DeleteUswrDialog> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
      
//     );
//   }
// }

class _DeleteUserDialogState extends State<DeleteUserDialog> {
  // final int commentId;
  // final bool isReply;
  // const DeleteUserDialog({ 
  //   // required this.commentId,
  //   // required this.isReply,
  //   Key? key
  // }) : super(key: key);
  late DeleteUserCubit deleteUserCubit;

  @override
  void initState() {
    deleteUserCubit = BlocProvider.of<DeleteUserCubit>(context);
    // deleteUserCubit.
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BlocBuilder<DeleteUserCubit, DeleteUserState>(
        builder: (context, state) {
          // if ()
          bool isLoading = false;
          if (state is DeleteUserLoadingState) {
            isLoading = true;
          } 
          else if (state is DeleteUserErrorState) {
            // print("aaatcfa");
            Get.back();
          }
          // else if (state != DeleteUserL)
          return Stack(
            children: [
              GestureDetector(
                onTap: () {
                  if (!isLoading) {
                    Get.back();
                  }
                }
              ),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width - 32,
                      // margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewPadding.top > 0 
                      //   ? MediaQuery.of(context).viewPadding.top
                      //   : 20
                      // ),
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(16) 
                      ),
                      child: Container(
                        color: Colors.transparent,
                        // height: 50,
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                        child: Center(
                          child: Text(
                            "Are you sure you want to permanently delete your Clivy account? please don't :(",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 14.5,
                              fontWeight: FontWeight.w400
                            )
                          ),
                        )
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
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
                          // GestureDetector(
                          //   onTap: () {
                          //     // BlocProvider.of<DeleteCubit>(context).deleteComment(commentId, isReply);
                          //     // Get.back();
                          //   },
                          //   child: Container(
                          //     color: Colors.transparent,
                          //     // height: 50,
                          //     padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                          //     child: Center(
                          //       child: Text(
                          //         "Are you sure you want to delete permanently your clivy account?",
                          //         style: TextStyle(
                          //           color: Colors.white,
                          //           fontSize: 16,
                          //           fontWeight: FontWeight.w500
                          //         )
                          //       ),
                          //     )
                          //   ),
                          // ),
                          // Container(
                          //   color: Colors.black,
                          //   height: 0.5
                          // ),
                          GestureDetector(
                            onTap: () {
                              if (!isLoading) {
                              //   // UserRepository(client: Client.client!).deleteUser(CurrentUser.userId!);
                                // print("aaaa");
                                deleteUserCubit.deleteUser();
                              //   // Get.back();
                              //   // showFlushBar();
                              //   // Get.back();
                              } 
                              // else if (state is DeleteUserErrorState) {
                              //   // 
                              // }
                              // Get.back();
                            },
                            child: Container(
                              color: Colors.transparent,
                              height: 50,
                              child: Center(
                                child: !isLoading ? Text(
                                  "Delete",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500
                                  )
                                ) : SizedBox(
                                  height: 26,
                                  width: 26,
                                  child: CircularProgressIndicator(
                                    color: Color(0xff00ff03),
                                    strokeWidth: 3,
                                  ),
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
                              if (!isLoading) {
                                Get.back();
                              }
                            },
                            child: Container(
                              color: Colors.transparent,
                              height: 50,
                              child: Center(
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(
                                    color: !isLoading ? Colors.grey[200] : Colors.grey[700],
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
                  ],
                ),
              ),
            ],
          );
        },
      )
    );
  }
}