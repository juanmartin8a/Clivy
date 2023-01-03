import { getConnection } from "typeorm";
import { User } from "../../entities/User";
import argon2 from 'argon2';

export const changePassword = async (user: User, newPassword: string) => {
  const spacesRegex = /\s/g;
  const passwordRegex = /(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}/;

  const errorsArray = [];

  const passwordHasSpace = spacesRegex.test(newPassword);

  if (newPassword.length < 8 || !passwordRegex.test(newPassword)
    || passwordHasSpace) {
    if (newPassword.length < 8) {
      errorsArray.push({
        field: 'newPassword',
        message: 'password must have at least 8 characters'
      });
    } else if (passwordHasSpace) {
      errorsArray.push({
        field: 'newPassword',
        message: 'password must not have any spaces'
      });
    } else if (!passwordRegex.test(newPassword)) {
      errorsArray.push({
        field: 'newPassword',
        message: 'password must have at least one lower case and one number'
      });
    }
  }
  const hashPassword = await argon2.hash(newPassword);
  await getConnection().query(`
    update "user"
    set password = $1
    where id = $2
  `, [hashPassword, user.id]);

  return errorsArray;
}