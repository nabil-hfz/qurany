// import { collection } from 'src/app/shared/consts/firestore-collections';
// import { Injectable } from "@angular/core";
// import { PERMISSIONS } from "../consts/permissions";
// import { ROUTES } from "../consts/routes";

import { Injectable } from "@angular/core";
import { PERMISSIONS } from "../consts/permissions";
import { ROUTES } from "../consts/routes";

export interface Menu {
  state: string;
  name: string;
  type: string;
  icon: string;
}

const MENUITEMS = [
  { state: "dashboard", name: "Dashboard", type: "link", icon: "av_timer" },
  {
    state: ROUTES.POSTS,
    name: "Club posts",
    type: "link",
    icon: "av_timer",
    permission: PERMISSIONS.VIEW_CLUB_POSTS,
  },
  {
    state: ROUTES.PODCASTS,
    name: "Club podcasts",
    type: "link",
    icon: "av_timer",
    permission: PERMISSIONS.VIEW_CLUB_PODCASTS,
  },
  {
    state: ROUTES.ADMIN_POSTS,
    name: "Admin posts",
    type: "link",
    icon: "av_timer",
    permission: PERMISSIONS.VIEW_ADMIN_POSTS,
  },
  // {
  //   state: collection.CLUBS,
  //   name: "Clubs",
  //   type: "link",
  //   icon: "av_timer",
  //   permission: PERMISSIONS.VIEW_CLUBS,
  // },
  {
    state: ROUTES.LIST_CLUB_CODE,
    name: "Club codes",
    type: "link",
    icon: "av_timer",
    permission: PERMISSIONS.VIEW_CLUB_CODES,
  },
  {
    state: ROUTES.FEATURED_PODCAST,
    name: "Featured podcasts",
    type: "link",
    icon: "av_timer",
    permission: PERMISSIONS.VIEW_FEATURED_PODCASTS,
  },
  {
    state: ROUTES.SYSTEM_USERS,
    name: "System users",
    type: "link",
    icon: "group",
    permission: PERMISSIONS.VIEW_SYSTEM_USERS,
  },
  {
    state: ROUTES.USERS,
    name: "Users",
    type: "link",
    icon: "group",
    permission: PERMISSIONS.VIEW_USERS,
  },
  {
    state: ROUTES.USERS_REPORTS,
    name: "Users reports",
    type: "link",
    icon: "group",
    permission: PERMISSIONS.VIEW_USER_REPORTS,
  },
  {
    state: ROUTES.FEEDBACKS,
    name: "Feedback",
    type: "link",
    icon: "group",
    permission: PERMISSIONS.VIEW_FEEDBACKS,
  },
  {
    state: ROUTES.ORGANIZERS,
    name: "Organizers",
    type: "link",
    icon: "assignment_turned_in",
    permission: PERMISSIONS.VIEW_ORGANIZERS,
  },
  {
    state: ROUTES.EXPERTS,
    name: "Experts",
    type: "link",
    icon: "assignment_turned_in",
    permission: PERMISSIONS.VIEW_EXPERTS,
  },
  {
    state: ROUTES.EVENTS,
    name: "Events",
    type: "link",
    icon: "event",
    permission: PERMISSIONS.VIEW_EVENTS,
  },
  {
    state: ROUTES.BADGES,
    name: "Badges",
    type: "link",
    icon: "group",
    permission: PERMISSIONS.VIEW_BADGES,
  },
  {
    state: ROUTES.TASKS,
    name: "Tasks",
    type: "link",
    icon: "group",
    permission: PERMISSIONS.VIEW_TASKS,
  },
  {
    state: ROUTES.PROGRAMS,
    name: "Programs",
    type: "link",
    icon: "group",
    permission: PERMISSIONS.VIEW_PROGRAMS,
  },
  {
    state: ROUTES.PODCAST_CATEGORIES,
    name: "Podcast categories",
    type: "link",
    icon: "group",
    permission: PERMISSIONS.VIEW_PODCAST_CATEGORIES,
  },
  {
    state: ROUTES.ROLES,
    name: "Roles management",
    type: "link",
    icon: "tabs",
    permission: PERMISSIONS.VIEW_ROLES,
  },
  {
    state: ROUTES.MODEL_GENERATOR,
    name: "Model generator",
    type: "link",
    icon: "tabs",
  },
];

@Injectable()
export class MenuItems {
  getMenuitem(): Menu[] {
    return MENUITEMS;
  }
}
