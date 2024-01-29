// import { Localization } from "./utils.model";

import { LocalizedModel } from "./localized.model";

export interface RoleModel {
  id?: string;
  name: LocalizedModel;
  permissions?: PermissionModel[];
  system_users?: any[];
}

export interface PermissionModel {
  id?: string;
  key: string;
  name: LocalizedModel;
}
