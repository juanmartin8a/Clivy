import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled_client/src/bloc/user/edit/editUserBloc.dart';
import 'package:untitled_client/src/bloc/user/edit/editUserState.dart';

class ProfileImgLoader extends StatefulWidget {
  final String file;
  final bool isMe;
  ProfileImgLoader({
    required this.file,
    required this.isMe,
    required Key key
  }) : super(key: key);
  // const ProfileImgLoader({ Key? key }) : super(key: key);

  @override
  _ProfileImgLoaderState createState() => _ProfileImgLoaderState();
}

class _ProfileImgLoaderState extends State<ProfileImgLoader> {
  late String file;

  @override
  void initState() {
    file = widget.file; 
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    if (widget.isMe == true) {
      return BlocBuilder<EditUserBloc, EditUserState>(
        builder: (context, state) {
          if (state is EditUserUpdatedState) {
            file = state.user.file.file!;
          }
          return getCachedNetworkImage();
        }
      );
    }

    return getCachedNetworkImage();
  }

  Widget getCachedNetworkImage() {
    return CachedNetworkImage(
      imageUrl: file,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      placeholder: (context, url) => Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.transparent
        )
      ),
      errorWidget: (context, url, error) => Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.transparent
        )
      ),
      fadeInDuration: Duration(milliseconds: 100),
      fadeOutDuration: Duration(milliseconds: 100),
    );
  }
}