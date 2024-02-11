export interface SystemUserAuthCredentail {
  email: string;
  password: string;
}

export interface SystemUserInfo {
  image?: any;
  firstName?: string;
  lastName?: string;
  displayName?: string;
  uid?: string;
  id?: string;
  status?: SystemUserStatus.Pending;
  createdDate?: any; // timestamp
}

export interface SystemUserMiniModel {
  id: any;
  firstName?: string;
  lastName?: string;
  email?: string;
  name?:string
}
export interface SystemUsersFilter {
  email: string;
  status: number[];
  limit: number;
}

export type SystemUser = Omit<SystemUserAuthCredentail, "password"> &
  SystemUserInfo;

export enum SystemUserStatus {
  Deactivated = -1,
  Pending = 0,
  Activated = 1,
}

export const SYSTEM_USER_STATUS = [
  {
    value: -1,
    label: "Deactivated",
    cssClasses: "deactivated-status",
  },
  {
    value: 0,
    label: "Pending",
    cssClasses: "pending-status",
  },
  {
    value: 1,
    label: "Activated",
    cssClasses: "activated-status",
  },
];
