import { Like } from "../../entities/Like";
import { getConnection } from "typeorm";
import { CommentLike } from "../../entities/CommentLike";
import { ReplyLike } from "../../entities/ReplyLike";

// export const likeProcess = async (
//   // userHasLike: Boolean, 
//   userId: number, 
//   id: number, 
//   table: "post" | "comment" | "reply", 
//   likeInfo: 
//   likeTable: "like" | "comment_like" | "reply_like"
// ) => {
//   if (!userHasLike) {
//     const like = await getConnection().createQueryBuilder()
//       .insert();
//     if (likeTable == 'like') {
//       await like.into(Like)
//         .values({ user_id: userId, post_id: id });
//     } else if (likeTable == 'comment_like') {
//       await like.into(CommentLike)
//         .values({ user_id: userId, comment_id: id });
//     } else {
//       await like.into(ReplyLike)
//         .values({ user_id: userId, reply_id: id });
//     }
//     // await like.on
//     await like.execute().catch((err) => {
//       console.log(err);
//     });
//   } else {
//   }
  // if (!userHasLike) {
  //   await getConnection().transaction(async (tm) => {	
  //     const tableInfo = await tm.query(`
  //       select * from "${table}"
  //       where id = $1
  //     `, [id]);
  //     const like = await tm.createQueryBuilder()
  //       .insert();
  //     if (likeTable == 'like') {
  //       await like.into(Like)
  //         .values({ user_id: userId, post_id: id });
  //     } else if (likeTable == 'comment_like') {
  //       await like.into(CommentLike)
  //         .values({ user_id: userId, comment_id: id });
  //     } else {
  //       await like.into(ReplyLike)
  //         .values({ user_id: userId, reply_id: id });
  //     }
  //     // await like.on
  //     await like.execute().catch((err) => {
  //       console.log(err);
  //     });

  //     await tm.query(`
  //       update "${table}"
  //       set "likeCount" = $1
  //       where id = $2
  //     `, [tableInfo[0].likeCount + 1, id]); //"likeCount" + $1
  //   })
  // } else if (userHasLike) {
  //   await getConnection().transaction(async (tm) => {
  //     const tableInfo = await tm.query(`
  //       select * from "${table}"
  //       where id = $1
  //     `, [id]);
  //     if (likeTable == 'like') {
  //       await Like.delete({
  //         user_id: userId, post_id: id
  //       });
  //     } else if (likeTable == 'comment_like') {
  //       await CommentLike.delete({
  //         user_id: userId, comment_id: id
  //       });
  //     } else {
  //       await ReplyLike.delete({
  //         user_id: userId, reply_id: id
  //       });
  //     }

  //     // await tm.query(`
  //     //   delete from "${likeTable}"
  //     //   where "user_id" = $1 and "${table}_id" = $2
  //     // `, [userId, id]);
  //     await tm.query(`
  //       update "${table}"
  //       set "likeCount" = $1
  //       where id = $2
  //     `, [tableInfo[0].likeCount - 1, id]); //"likeCount" - $1
  //   });
  // }
// }