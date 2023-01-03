import 'dart:io';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled_client/src/api/graphql/graphql_api.dart';
import 'package:untitled_client/src/bloc/user/edit/editUserBloc.dart';
import 'package:untitled_client/src/bloc/user/edit/editUserEvent.dart';
import 'package:untitled_client/src/bloc/user/edit/editUserState.dart';
import 'package:untitled_client/src/models/currentUser.dart';
import 'package:untitled_client/src/models/customMultipartFile.dart';
import 'package:untitled_client/src/ui/helpers/profileImg.dart';
import 'package:untitled_client/src/ui/screens/home/widgets/floatingActions.dart';
import 'package:untitled_client/src/ui/screens/user/widgets/editProfileField.dart';
import 'package:untitled_client/src/utils/globalUtils.dart';

class EditProfile extends StatefulWidget {
  final User$Query$User user;
  EditProfile({
    required this.user,
    required Key key
  }) : super(key: key);
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late EditUserBloc editUserBloc;

  final ImagePicker _imagePicker = ImagePicker();
  XFile? pfp;

  late TextEditingController _nameController;
  late TextEditingController  _usernameController;
  late TextEditingController _bioController;
  
  String? nameError;
  String? usernameError;
  String? bioError;
  
  @override
  void initState() {
    editUserBloc = BlocProvider.of<EditUserBloc>(context);
    _nameController = TextEditingController(text: widget.user.name);
    _usernameController = TextEditingController(text: widget.user.username);
    _bioController = TextEditingController(text: widget.user.bio);
    super.initState();
  }

  @override
  void dispose() {
    editUserBloc.add(EditUserBackEvent());
    _nameController.dispose();
    _usernameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditUserBloc, EditUserState>(
      builder: (context, state) {
        if (state is EditUserErrorState) {
          if (state.globalError != true && state.errors != null) {
            usernameError = null;
            nameError = null;
            bioError = null;
            for (var error in state.errors!) {
              if (error.field == "username") {
                usernameError = error.message;
              } 
              if (error.field == "name") {
                nameError = error.message;
              } 
              if (error.field == "bio") {
                bioError = error.message;
              }
            }
          }
        } else if (state is EditUserUpdatedState) {
          // print("hey");
          // if (mounted) {
          WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
            Get.back();
          });
          // editUserBloc.add(EditUserBackEvent());
          // }
        }
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.black,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: AppBar(
              backgroundColor: Colors.black,
              leading: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  child: FloatingActions(
                    icon: EvaIcons.arrowBackOutline,
                    color: Colors.grey[700]!,
                    size: 36,
                    key: Key("goBack")
                  ),
                ),
              ),
              title: Container(
                child: Text(
                  'Edit Profile',
                  style: TextStyle(
                    color: Color(0xff00ff03),
                    fontSize: 18,
                    fontWeight: FontWeight.w700
                  )
                )
              ),
              actions: [
                GestureDetector(
                  onTap: () {
                    if (state is EditUserEditableState) {
                      updateUser();
                    }
                  },
                  child: Container(
                    // color: Colors.red,
                    padding: EdgeInsets.all(8),
                    child: Center(
                      child: Text(
                        "Save",
                        style: TextStyle(
                          color: (state is EditUserEditableState)
                            ? Color(0xff00ff03)
                            : Colors.grey[700],
                          fontSize: 14.5,
                          fontWeight: FontWeight.w500,
                          height: 1 
                        )
                      ),
                    )
                  )
                )
              ],
            ),
          ),
          body: Container(
            margin: EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisSize: MainAxisSize.max,
              children: [
                Container( 
                  margin: EdgeInsets.only(top: 15),
                  child: Container(
                    height: 112,
                    width: 112,
                    child: GestureDetector(
                      onTap: () async {
                        pfp = await _imagePicker.pickImage(
                          source: ImageSource.gallery,
                          // imageQuality: 80,
                          // maxHeight: 80
                        );
                        print(File(pfp!.path).lengthSync());
                        if (pfp != null) {
                          checkOnChange();
                        }
                        setState(() {});
                      },
                      child: pfp == null ? ProfileImgLoader(
                        file: widget.user.file.file!,
                        isMe:  widget.user.id == CurrentUser.userId,
                        key: Key('profile_edit_${widget.user.id}')
                      ) : Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: FileImage(File(pfp!.path)),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                  ),
                ),
                SizedBox(height: 12),
                EditProfileField(
                  controller: _usernameController,
                  fieldName: 'Username',
                  checkOnChange: checkOnChange,
                  fieldError: usernameError,
                  key: Key('editProfileField_name')
                ),
                SizedBox(height: 12),
                EditProfileField(
                  controller: _bioController,
                  fieldName: 'Bio',
                  checkOnChange: checkOnChange,
                  fieldError: bioError,
                  key: Key('editProfileField_username')
                ),
                SizedBox(height: 12),
                EditProfileField(
                  controller: _nameController, 
                  fieldName: 'Name',
                  checkOnChange: checkOnChange,
                  fieldError: nameError,
                  key: Key('editProfileField_bio')
                ),
                // Spacer()
              ],
            )
          )
        );
      }, 
    );
  }

  void updateUser() async {
    EditUserBloc editUserBloc = BlocProvider.of<EditUserBloc>(context);
    CustomMultipartFile? multipartPFP;
    if (pfp != null) {
      multipartPFP = await GlobalUtils().getCustomMultipartFileFromFile(
        File(pfp!.path)
      );
    }
    print(_bioController.text.trim());
    print(widget.user.bio.trim());
    print(_nameController.text.trim() != widget.user.name.trim());
    print(_usernameController.text.trim() != widget.user.username.trim());
    print(_bioController.text.trim() != widget.user.bio.trim());
    editUserBloc.add(
      EditUserButtonPressedEvent(
        name: _nameController.text.trim() != widget.user.name.trim() ? _nameController.text.trim() : null,
        username: _usernameController.text.trim() != widget.user.username.trim() ? _usernameController.text.trim() : null,
        bio: _bioController.text.trim() != widget.user.bio.trim() ? _bioController.text.trim() : null,
        file: multipartPFP
      )
    );
  }

  void checkOnChange() {
    EditUserBloc editUserBloc = BlocProvider.of<EditUserBloc>(context);
    editUserBloc.add(
      EditUserCheckEvent(
        name: widget.user.name, 
        username: widget.user.username, 
        bio: widget.user.bio, 
        editName: _nameController.text.trim(), 
        editUsername: _usernameController.text.trim(), 
        editBio: _bioController.text.trim(),
        editFile: pfp != null ? pfp!.path : null,
      )
    );
  }

  clientValidation() async {
    String username = _usernameController.text;
    String name = _nameController.text;
    String bio = _bioController.text;

    RegExp spaceRegex = new RegExp(
      r"\s\b|\b\s"
    );

    if (username.length < 2 || username.length > 30) {
      if (username.length == 0) {
        usernameError = "username must not be empty";
      } else if (username.length < 2) {
        usernameError = "username must have at least 2 characters";
      } else if (spaceRegex.hasMatch(username)) {
        usernameError = "username must not have any spaces";
      } else if (username.length > 30) {
        usernameError = "username must have no more than 30 characters";
      }
    } else {
      usernameError = null;
    }

    if (name.length < 2 || name.length > 30) {
      if (name.length == 0) {
        nameError = 'name must not be empty';
      } else if (name.length < 2) {
        nameError = 'name must have at least 2 characters';
      } else if (name.length > 30) {
        nameError = 'name must have no more than 30 characters';
      }
    } else {
      nameError = null;
    }

    if (bio.length > 150) {
      bioError = 'bio must have no more than 150 characters';
    } else {
      bioError = null;
    }

    setState(() {});
  }
}

// add errors ui
// fix error messages name less than 30 characters should be no more than 30 characters