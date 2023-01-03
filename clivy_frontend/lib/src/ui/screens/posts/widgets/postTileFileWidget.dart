// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:untitled_client/src/bloc/video/videoBloc.dart';
// import 'package:untitled_client/src/ui/screens/posts/widgets/postTileFile.dart';

// class PostTileFileWidget extends StatelessWidget {
//   final String file;
//   final int fileWidth;
//   final int fileHeight;
//   final String id;
//   final bool isVisible;
//   const PostTileFileWidget({
//     required this.file,
//     required this.fileWidth,
//     required this.fileHeight,
//     required this.id,
//     required this.isVisible,
//     required Key key
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return AspectRatio(
//       aspectRatio: fileWidth / fileHeight,
//       child: Stack(
//         children: [
//           PostTileFile(
//             file: file,
//             fileHeight: fileHeight,
//             fileWidth: fileWidth,
//             id: id,
//             isVisible: isVisible,
//             key: Key('postTileFile_$id')
//           ),
//           GestureDetector(
//             onTap: () {
//               BlocProvider.of<VideoCubit>(context).playPauseVideo(id);
//             },
//             child: Container(
//               color: Colors.transparent,
//               child: Center(
//                 child: Text(
//                   'play/pause'
//                 ),
//               )
//             ),
//           )
//         ],
//       )
//     );
//   }
// }