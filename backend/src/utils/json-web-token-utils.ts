import * as jwt from 'jsonwebtoken';
import { JwtPayload } from 'jsonwebtoken';

const JWT_SECRET_KEY = process.env.JWT_SECRET_KEY;
if (!JWT_SECRET_KEY) throw new Error();

export abstract class AppJsonWebTokenUtils {

  static async generateToken(userId: number, username: string, role: any): Promise<string> {

    const token = jwt.sign(
      { userId: userId, username: username, role: role }, // Payload data
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
