import { AppBaseModel } from './base.model';


export interface LoginResponseModel {
  token: string;
  profile: UserProfileModel;
}

interface UserProfileModel extends AppBaseModel {
  uid: number;
  email: string;
  displayName: string;
  phoneNumber: string | null;
  customClaims: UserClaims;
}

interface UserClaims {
  role: string;
}