import fs from 'fs';
import jwt from 'jsonwebtoken';

export const verifyJWT = async (token: string, forRefresh: boolean) => {

  let PUBLIC_KEY: string;
  if (forRefresh) {
    PUBLIC_KEY = fs.readFileSync('jwt_keys/refresh_jwt_keys/rsa_r_pub_key.pem', 'utf8');
  } else {
    PUBLIC_KEY = fs.readFileSync('jwt_keys/access_jwt_keys/rsa_pub_a_key.pem', 'utf8');
  }

	let error: boolean = false;
	let payload: Object | undefined = {};

	await jwt.verify(token, PUBLIC_KEY, {algorithms: ['RS256']}, (err, result) => {
		if (err || (typeof result) === undefined) {
			error = true;
		} else {
			payload = result;
		}
	});

	return {
		error: error,
		payload: payload
	}
}