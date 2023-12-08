export type CreateAccountReqBody = {
  name: string;
  email: string;
  password: string;
  role: "superAdmin" | "user";
};
