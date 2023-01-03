import 'package:bloc/bloc.dart';
import 'package:untitled_client/src/bloc/user/edit/editUserEvent.dart';
import 'package:untitled_client/src/bloc/user/edit/editUserState.dart';
import 'package:untitled_client/src/bloc/user/userEvent.dart';
import 'package:untitled_client/src/models/customMultipartFile.dart';
import 'package:untitled_client/src/repos/userRepository.dart';
import 'package:untitled_client/src/utils/user/userUtils.dart';
import 'package:uuid/uuid.dart';
import '../userBloc.dart';

class EditUserBloc extends Bloc<EditUserEvent, EditUserState> {
  final UserRepository userRepo;
  final UserBloc userBloc;
  EditUserBloc({
    required this.userRepo,
    required this.userBloc
  }) : super(EditUserInitState());

  @override
  Stream<EditUserState> mapEventToState(EditUserEvent event) async* {
    if (event is EditUserCheckEvent) {
      if (
        event.name != event.editName || 
        event.username != event.editUsername|| 
        event.bio != event.editBio ||
        event.editFile != null
      ) {
        yield EditUserEditableState();
      } else {
        yield EditUserInitState();
      }
    } else if (event is EditUserButtonPressedEvent) {
      yield EditUserLoadingState();
      try {
        CustomMultipartFile? compressedFile;
        CustomMultipartFile? compressedSmallFile;
        if (event.file != null) {
          compressedFile = await UserUtils().getCompressedPFP(event.file!.filePath);
          compressedSmallFile = await UserUtils().getCompressedSmallPFP(event.file!.filePath);
        }
        final newUserData = await userRepo.editProfile(
          event.name, event.username, event.bio, compressedFile, compressedSmallFile
        );
        if (newUserData.errors != null) {
          if (newUserData.errors![0].field == "all") {
            yield EditUserErrorState(
              globalError: true
            );
          } else {
            yield EditUserErrorState(
              errors: newUserData.errors
            );
          }
        } else {
          final newUser = await UserUtils().getUpdatedUser(
            newUserData.user!.toJson()
          );
          // print(newUser);
          userBloc.add(
            UpdateUserEvent(
              user: newUser
            )
          );
          yield EditUserUpdatedState(
            user: newUser,
            uuid: Uuid().v4()
          );
        }
      } catch(err) {
        print(err);
        yield EditUserErrorState(globalError: true);
      }
    } else if (event is EditUserBackEvent) {
      yield EditUserInitState();
    }
  }
  
}