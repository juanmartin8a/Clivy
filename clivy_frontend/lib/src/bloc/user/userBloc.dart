import 'package:bloc/bloc.dart';
import 'package:untitled_client/src/api/graphql/graphql_api.dart';
import 'package:untitled_client/src/bloc/user/userEvent.dart';
import 'package:untitled_client/src/bloc/user/userState.dart';
import 'package:untitled_client/src/models/currentUser.dart';
import 'package:untitled_client/src/repos/userRepository.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepo;

  UserBloc({
    required this.userRepo
  }) : super(UserInitState());

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is FetchUserEvent) {
      try {
        final user = await userRepo.user(event.userId);
        // print(user);
        final myId = CurrentUser.userId;
        yield UserLoadedState(
          user: user,
          isMyProfile: event.userId == myId,
          isNotEdit: true,
          id: event.id
        );
      } catch (err) {
        print('error fetching user $err');
      }
    } else if (event is UpdateUserEvent) {
      final myId = CurrentUser.userId;
      yield UserLoadedState( 
        user: event.user,
        isMyProfile: event.user.id == myId,
      );
    } 
    else if (event is ChangeUserEvent) {
      yield* mapChangeUserEventToState(event);
    }
  }

  Stream<UserState> mapChangeUserEventToState(ChangeUserEvent event) async* {
    Map<String, dynamic> user = event.user.toJson();

    for (int i = 0; i < event.changeMap.length; i++) {
      user[event.changeMap.keys.toList()[i]] = event.changeMap.values.toList()[i];
    }

    final changedUser = User$Query$User.fromJson(user);

    final myId = CurrentUser.userId;

    yield UserLoadedState(
      user: changedUser,
      isMyProfile: event.userId == myId,
      isNotEdit: true,
      id: event.uuid
    );
    
  }
  
}