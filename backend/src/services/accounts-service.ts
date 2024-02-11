import { UserRecord } from "firebase-admin/lib/auth";
import * as admin from "firebase-admin";
import { HttpResponseError } from "../utils/http-response-error";

class AccountsService {
  async createAccount(
    role: string,
    name: string,
    email: string,
    password: string
  ): Promise<UserRecord> {
    let createUserRes: UserRecord;
    try {
      createUserRes = await admin.auth().createUser({
        displayName: name,
        email: email,
        password: password,
      });
    } catch (e: any) {
      switch (e.code) {
        case "auth/email-already-exists":
          throw new HttpResponseError(
            400,
            "EXISTING_EMAIL",
            "Email is already in use"
          );
      }
      throw e;
    }

    await admin.auth().setCustomUserClaims(createUserRes.uid, {
      storeOwner: role == "superAdmin",  
      buyer: role == "user",  
    });

    return admin.auth().getUser(createUserRes.uid);
  }
}

export const accountsService: AccountsService = new AccountsService();
