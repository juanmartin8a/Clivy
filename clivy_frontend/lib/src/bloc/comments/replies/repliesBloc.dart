import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:untitled_client/src/api/graphql/graphql_api.dart';
import 'package:untitled_client/src/bloc/comments/commentBloc.dart';
import 'package:untitled_client/src/bloc/comments/commentCounter/commentCounterCubit.dart';
import 'package:untitled_client/src/bloc/comments/commentOrReply/commentOrReplyBloc.dart';
import 'package:untitled_client/src/bloc/comments/commentOrReply/commentOrReplyEvent.dart';
import 'package:untitled_client/src/bloc/comments/replies/repliesEvent.dart';
import 'package:untitled_client/src/bloc/comments/replies/repliesState.dart';
import 'package:untitled_client/src/bloc/loading/loadingReplies/loadingRepliesCubit.dart';
import 'package:untitled_client/src/repos/postRepository.dart';
import 'package:untitled_client/src/utils/comments/commentUtils.dart';
import 'package:untitled_client/src/utils/globalUtils.dart';

class RepliesBloc extends Bloc<RepliesEvent, RepliesState> {
  final LoadingRepliesCubit loadingCubit;
  final PostRepository postRepo;
  final CommentBloc commentBloc;
  final CommentOrReplyBloc commentOrReplyBloc;
  final CommentCounterCubit commentCounterBloc;

  RepliesBloc({
    required this.loadingCubit,
    required this.postRepo,
    required this.commentBloc,
    required this.commentOrReplyBloc,
    required this.commentCounterBloc
  }) : super(RepliesInitState());

  @override
  Stream<RepliesState> mapEventToState(RepliesEvent event) async* {
    if (event is FetchMoreRepliesEvent) {
      loadingCubit.loader(true, event.commentId, event.uuid);
      try {
        final replies = await postRepo.commentReplies(
          event.commentId, 
          event.postId,
          event.limit,
          event.cursor,
          event.isFetchMore,
          event.queryResult,
          event.idsList
        );
        // print(replies);
        loadingCubit.loader(false, event.commentId, event.uuid);
        yield RepliesShownState(
          replyResponse: replies.replies,
          queryResult: replies.queryResult,
          uuid: event.uuid
        );
      } catch (err) {
        loadingCubit.loader(false, event.commentId, event.uuid);
        print(err);
      }
    } 
    else if (event is CreateReplyEvent) {
      yield* _mapCreateReplyEventToState(event);
    } else if (event is DeleteReplyEvent) {
      yield* _mapDeleteReplyEventToState(event);
    } else if (event is ChangeReplyEvent) {
      yield* _mapChangeReplyEventToState(event);
    }
  }

  Stream<RepliesState> _mapCreateReplyEventToState(CreateReplyEvent event) async* {
    // try {
      final taggedUsersList = await CommentUtils().getUserTagInputList(event.userTagInput);
      final reply = await CommentUtils().makeRepliesResponseFromReply(
        event.commentId,
        event.postId,
        event.reply,
        event.userTagInput
      );
      final replies = await CommentUtils().getUpdatedCommentReplies(
        event.repliesResponse,
        event.postId,
        event.commentId,
        reply.toJson(),
        event.replyCount,
      );
      final repliesQueryResult = GlobalUtils().generateQueryResult(
        QueryResultSource.network, replies.toJson(), 'commentReplies'
      );
      commentOrReplyBloc.add(SetCommentEvent(
        id: event.id,
      ));
      yield RepliesShownState(
        replyResponse: replies,
        queryResult: repliesQueryResult,
        uuid: event.id,
        changed: true,
        newReply: true,
        isPre: true
      );
      commentCounterBloc.commentDeleteComment(
        event.postId, 
        reply.id.toInt(),
        true,
        false,
        null
      );
      final newReply = await postRepo.createReply(
      event.commentId, event.postId, event.reply, event.replyCount, taggedUsersList
      );
      final newReplies = await CommentUtils().getUpdatedCommentReplies(
        event.repliesResponse,
        event.commentId,
        event.postId,
        newReply.reply!.toJson(),
        event.replyCount,
      );
      final newRepliesQueryResult = GlobalUtils().generateQueryResult(
        QueryResultSource.network, newReplies.toJson(), 'commentReplies'
      );
      yield RepliesShownState(
        replyResponse: newReplies,
        queryResult: newRepliesQueryResult,
        uuid: event.id,
        changed: replies.replies.length == newReplies.replies.length ? true : false,
        newReply: true,
      );
      commentCounterBloc.commentDeleteComment(
        event.postId,
        reply.id.toInt(),
        false,
        false,
        null
      );
    // } catch(err) {
    //   print('error creating replies $err');
    // }
  }

  Stream<RepliesState> _mapDeleteReplyEventToState(DeleteReplyEvent event) async* {
    final deleteResponse = await CommentUtils().getUpdatedPaginatedRepliesDeleteAction(
      event.replies,
      event.deletedReplyId,
    );
    final newQueryResult = GlobalUtils().generateQueryResult(
      QueryResultSource.network, deleteResponse.toJson(), event.missingKey
    );
    // commentCounterBloc.commentDeleteComment(
    //   event.postId,
    //   reply.id.toInt(),
    //   false,
    //   false,
    //   null
    // );
    yield RepliesShownState(
      replyResponse: deleteResponse,
      queryResult: newQueryResult,
      uuid: event.uuid,
      changed: true,
      newReply: false,
    ); 
  }

  Stream<RepliesState> _mapChangeReplyEventToState(ChangeReplyEvent event) async* {

    Map<String, dynamic> comments = event.replies.toJson();

    int index = (comments["replies"] as List).indexWhere((post) => post["id"].toInt() == event.changeReplyId);

    for (int i = 0; i < event.changeMap.length; i++) {
      comments['replies'][index][event.changeMap.keys.toList()[i]] = event.changeMap.values.toList()[i];
    }

    final changedReplies = Replies$Query$ReplyResponse.fromJson(comments);
    
    final newQueryResult = GlobalUtils().generateQueryResult(
      QueryResultSource.network, changedReplies.toJson(), event.missingKey // changeResponse.toJson()
    );

    yield RepliesShownState(
      replyResponse: changedReplies,
      queryResult: newQueryResult,
      uuid: event.uuid,
    ); 
  }



}