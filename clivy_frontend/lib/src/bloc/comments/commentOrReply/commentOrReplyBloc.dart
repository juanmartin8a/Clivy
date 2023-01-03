import 'package:bloc/bloc.dart';
import 'package:untitled_client/src/bloc/comments/commentOrReply/commentOrReplyEvent.dart';
import 'package:untitled_client/src/bloc/comments/commentOrReply/commentOrReplyState.dart';

class CommentOrReplyBloc extends Bloc<CommentOrReplyEvent, CommentOrReplyState> {

  CommentOrReplyBloc() : super(CommentOrReplyInitState());

  @override
  Stream<CommentOrReplyState> mapEventToState(CommentOrReplyEvent event) async* {
    if (event is SetCommentEvent) {
      yield IsCommentState(id: event.id);
    } else if (event is SetReplyEvent) {
      yield IsReplyState(
        isReplyReply: event.isReplyReply,
        replyCount: event.replyCount,
        id: event.id,
        userId: event.userId,
        commentId: event.commentId,
        repliesResponse: event.repliesResponse,
        replyUsername: event.replyUsername,
        queryResult: event.queryResult,
      );
    }
  }

}