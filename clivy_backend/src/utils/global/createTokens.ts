import jwt from 'jsonwebtoken';
import fs from 'fs';

export const createTokens = async (payload: Object) => {
  const ACCESS_PRIVATE_KEY = fs.readFileSync('jwt_keys/access_jwt_keys/rsa_priv_a_key.pem', 'utf8');
	const REFRESH_PRIVATE_KEY = fs.readFileSync('jwt_keys/refresh_jwt_keys/rsa_r_priv_key.pem', 'utf8');
	const accessToken = await createAccessToken(payload, ACCESS_PRIVATE_KEY);
	const refreshToken = await createRefreshToken(payload, REFRESH_PRIVATE_KEY);

	return {
		accessToken: accessToken,
		refreshToken: refreshToken
	};
}

export const createAccessToken = async (payload: Object, privateKey: string) => {
  return jwt.sign(payload, privateKey, {algorithm: 'RS256', expiresIn: 60}); //* 60 * 12
}

export const createRefreshToken = async (payload: Object, privateKey: string) => {
  return jwt.sign(payload, privateKey, {algorithm: 'RS256', expiresIn: 60 * 60 * 24 * 7});
}