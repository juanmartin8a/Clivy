import { MyContext } from "../myContext";
import { MiddlewareFn } from "type-graphql/dist/interfaces/Middleware";
import { getUserIdFromToken } from "../utils/main/getUser";
import { User } from "src/entities/User";


export const isAuth: MiddlewareFn<MyContext> = async ({context}, next) => {

    const userIdFromToken = await getUserIdFromToken(context.redis, context.req.headers.authorization);

    if (userIdFromToken === undefined) {
        throw new Error('Not Authenticated');
    }

    const user = await User.findOne({where: {
        id: userIdFromToken
    }});

    if (!user) {
        throw new Error('Not Authenticated');
    }
    
    return next();
}