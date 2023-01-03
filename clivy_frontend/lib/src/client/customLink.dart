import "package:gql_transform_link/gql_transform_link.dart";
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:untitled_client/src/bloc/me/meBloc.dart';
import 'package:untitled_client/src/bloc/me/meEvent.dart';
import 'package:untitled_client/src/client/client.dart';
import 'package:untitled_client/src/models/jwt.dart';
import 'package:untitled_client/src/repos/userRepository.dart';

class CustomLink extends Link {
  late Link _link;
  String _token = "";
  UserRepository? _userRepo;

  CustomLink() {
    _link = Link.concat(
      // AuthLink(
      //   getToken: () async  {
      //     return "Bearer $_token";
      //   },
      // ),
      ErrorLink(onGraphQLError: handleException),
      TransformLink(requestTransformer: transformRequest),
    );
  }

  Future<void> updateToken() async {
    if (_userRepo == null) {
      if (Client.client == null) {
        return ;
      }
      _userRepo = UserRepository(client: Client.client!);
    }
    try {
      var refreshToken = await JWT().getRefreshJWT();
      var refreshedTokens = await _userRepo!.refreshToken('Bearer $refreshToken');

      print(refreshToken);
      print(refreshedTokens);
      if (refreshedTokens.accessToken == "") {
        MeBloc(userRepo: _userRepo!)..add(MeSignOutEvent());
        _token = "";
        print("exception");
        throw Exception();
      }
      _token = refreshedTokens.accessToken;
    } catch(err) {
      print("exception");
      throw Exception();
    }
  }

  Stream<Response> handleException(
    Request request,
    NextLink forward,
    Response response,
  ) async* {

    print('exeption is: ${response.errors?[0].message}');

    if (response.errors != null && response.errors!.length > 0 &&
    response.errors![0].message == 'Not Authenticated') {

      print("aaaa");

      try {
        await updateToken();
      } catch(err) {
        print("cached error $err");
        throw response.errors!;
      }

      yield* forward(request);

      return;
    }

    throw response.errors!;
  }

  Request transformRequest(Request request) {
    var updatedRequest = request.updateContextEntry<HttpLinkHeaders>(
      (headers) => HttpLinkHeaders(
        headers: <String, String>{
          "Authorization": 'Bearer $_token',
        },
      ), 
    );

    return updatedRequest;
  }

  @override
  Stream<Response> request(Request request, [forward]) async* {
    _token = await JWT().getJWT();

    yield* _link.request(request, forward);
  }
}