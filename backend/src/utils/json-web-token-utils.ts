import * as jwt from 'jsonwebtoken';
import { JwtPayload } from 'jsonwebtoken';
import { JWTSecretKeyError } from './json-web-token-errors';

const JWT_SECRET_KEY = process.env.JWT_SECRET_KEY;
if (!JWT_SECRET_KEY) throw new JWTSecretKeyError();

export abstract class AppJsonWebTokenUtils {

  static async generateToken(userId: number, email: string, role: any): Promise<string> {

    const token = jwt.sign(
      {
        uid: userId,
        email: email,
        customClaims: role
      }, // Payload data
      JWT_SECRET_KEY!,                    // Secret key
      { expiresIn: '7d' }                // Token expiration time
    );

    return token;

  }
  static async decodeToken(token: string): Promise<null | JwtPayload> {
    const payload = jwt.decode(token, { json: true });
    return payload;
  }

}
