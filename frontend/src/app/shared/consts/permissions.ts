// import { PermissionModel } from "src/app/models/role.model";

export enum PERMISSIONS {
  VIEW_USERS = "VIEW_USERS",
  VIEW_USER_DETAILS = "VIEW_USER_DETAILS",
  BLOCK_USER = "BLOCK_USER",
  DEACTIVATE_USER = "DEACTIVATE_USER",
  ADD_EVENT = "ADD_EVENT",
  EDIT_EVENT = "EDIT_EVENT",
  DELETE_EVENT = "DELETE_EVENT",
  VIEW_EVENTS = "VIEW_EVENTS",
  EDIT_USER_REPORT = "EDIT_USER_REPORT",
  DELETE_USER_REPORT = "DELETE_USER_REPORT",
  VIEW_USER_REPORTS = "VIEW_USER_REPORTS",
  ADD_ORGANIZER = "ADD_ORGANIZER",
  EDIT_ORGANIZER = "EDIT_ORGANIZER",
  DELETE_ORGANIZER = "DELETE_ORGANIZER",
  VIEW_ORGANIZERS = "VIEW_ORGANIZERS",
  ADD_EXPERT = "ADD_EXPERT",
  EDIT_EXPERT = "EDIT_EXPERT",
  DELETE_EXPERT = "DELETE_EXPERT",
  VIEW_EXPERTS = "VIEW_EXPERTS",
  ADD_ADMIN_POST = "ADD_ADMIN_POST",
  EDIT_ADMIN_POST = "EDIT_ADMIN_POST",
  DELETE_ADMIN_POST = "DELETE_ADMIN_POST",
  VIEW_ADMIN_POSTS = "VIEW_ADMIN_POSTS",
  EDIT_CLUB_POST = "EDIT_CLUB_POST",
  DELETE_CLUB_POST = "DELETE_CLUB_POST",
  VIEW_CLUB_POSTS = "VIEW_CLUB_POSTS",
  EDIT_CLUB_PODCAST = "EDIT_CLUB_PODCAST",
  DELETE_CLUB_PODCAST = "DELETE_CLUB_PODCAST",
  VIEW_CLUB_PODCASTS = "VIEW_CLUB_PODCASTS",
  ADD_FEATURED_PODCAST = "ADD_FEATURED_PODCAST",
  EDIT_FEATURED_PODCAST = "EDIT_FEATURED_PODCAST",
  DELETE_FEATURED_PODCAST = "DELETE_FEATURED_PODCAST",
  VIEW_FEATURED_PODCASTS = "VIEW_FEATURED_PODCASTS",
  ADD_SYSTEM_USER = "ADD_SYSTEM_USER",
  EDIT_SYSTEM_USER = "EDIT_SYSTEM_USER",
  DELETE_SYSTEM_USER = "DELETE_SYSTEM_USER",
  VIEW_SYSTEM_USERS = "VIEW_SYSTEM_USER",
  EDIT_FEEDBACK = "EDIT_FEEDBACK",
  RESOLVE_FEEDBACK = "RESOLVE_FEEDBACK",
  DELETE_FEEDBACK = "DELETE_FEEDBACK",
  VIEW_FEEDBACKS = "VIEW_FEEDBACKS",
  ADD_ROLE = "ADD_ROLE",
  EDIT_ROLE = "EDIT_ROLE",
  DELETE_ROLE = "DELETE_ROLE",
  VIEW_ROLES = "VIEW_ROLES",
  ADD_TASK = "ADD_TASK",
  EDIT_TASK = "EDIT_TASK",
  DELETE_TASK = "DELETE_TASK",
  VIEW_TASKS = "VIEW_TASKS",
  ADD_BADGE = "ADD_BADGE",
  EDIT_BADGE = "EDIT_BADGE",
  DELETE_BADGE = "DELETE_BADGE",
  VIEW_BADGES = "VIEW_BADGES",
  // podcast categories 
  ADD_PODCAST_CATEGORY = 'ADD_PODCAST_CATEGORY',
  EDIT_PODCAST_CATEGORY = 'EDIT_PODCAST_CATEGORY',
  DELETE_PODCAST_CATEGORY = 'DELETE_PODCAST_CATEGORY',
  VIEW_PODCAST_CATEGORIES = 'VIEW_PODCAST_CATEGORIES',
  // Programs 
  ADD_PROGRAM = 'ADD_PROGRAM',
  EDIT_PROGRAM = 'EDIT_PROGRAM',
  DELETE_PROGRAM = 'DELETE_PROGRAM',
  VIEW_PROGRAMS = 'VIEW_PROGRAMS',

  // Programs 
  ADD_CLUB = 'ADD_CLUB',
  EDIT_CLUB = 'EDIT_CLUB',
  DELETE_CLUB = 'DELETE_CLUB',
  VIEW_CLUBS = 'VIEW_CLUBS',

  // Club Codes 
  ADD_CLUB_CODE = 'ADD_CLUB_CODE',
  EDIT_CLUB_CODE = 'EDIT_CLUB_CODE',
  VIEW_CLUB_CODES = 'VIEW_CLUB_CODES',
}

// export const PERMISSIONS_ARRAY: PermissionModel[] = [
//   {
//     key: PERMISSIONS.VIEW_USERS,
//     name: { en: "View Users", ar: "إضافة حدث" },
//   },
//   {
//     key: PERMISSIONS.VIEW_USER_DETAILS,
//     name: { en: "View User Details", ar: "إضافة حدث" },
//   },
//   {
//     key: PERMISSIONS.BLOCK_USER,
//     name: { en: "Block User", ar: "إضافة حدث" },
//   },
//   {
//     key: PERMISSIONS.DEACTIVATE_USER,
//     name: { en: "Deactivate User", ar: "إضافة حدث" },
//   },
//   {
//     key: PERMISSIONS.ADD_EVENT,
//     name: { en: "Add Event", ar: "إضافة حدث" },
//   },
//   {
//     key: PERMISSIONS.EDIT_EVENT,
//     name: { en: "Edit Event", ar: "تعديل حدث" },
//   },
//   {
//     key: PERMISSIONS.DELETE_EVENT,
//     name: { en: "Delete Event", ar: "إضافة حدث" },
//   },
//   {
//     key: PERMISSIONS.VIEW_EVENTS,
//     name: { en: "View Events", ar: "إضافة حدث" },
//   },
//   {
//     key: PERMISSIONS.EDIT_USER_REPORT,
//     name: { en: "Edit User Report", ar: "تعديل حدث" },
//   },
//   {
//     key: PERMISSIONS.DELETE_USER_REPORT,
//     name: { en: "Delete User Report", ar: "إضافة حدث" },
//   },
//   {
//     key: PERMISSIONS.VIEW_USER_REPORTS,
//     name: { en: "View User Reports", ar: "إضافة حدث" },
//   },
//   {
//     key: PERMISSIONS.ADD_ORGANIZER,
//     name: { en: "Add Organizer", ar: "إضافة حدث" },
//   },
//   {
//     key: PERMISSIONS.EDIT_ORGANIZER,
//     name: { en: "Edit Organizer", ar: "تعديل حدث" },
//   },
//   {
//     key: PERMISSIONS.DELETE_ORGANIZER,
//     name: { en: "Delete Organizer", ar: "إضافة حدث" },
//   },
//   {
//     key: PERMISSIONS.VIEW_ORGANIZERS,
//     name: { en: "View Organizers", ar: "إضافة حدث" },
//   },
//   {
//     key: PERMISSIONS.ADD_EXPERT,
//     name: { en: "Add Expert", ar: "إضافة حدث" },
//   },
//   {
//     key: PERMISSIONS.EDIT_EXPERT,
//     name: { en: "Edit Expert", ar: "تعديل حدث" },
//   },
//   {
//     key: PERMISSIONS.DELETE_EXPERT,
//     name: { en: "Delete Expert", ar: "إضافة حدث" },
//   },
//   {
//     key: PERMISSIONS.VIEW_EXPERTS,
//     name: { en: "View Experts", ar: "إضافة حدث" },
//   },
//   {
//     key: PERMISSIONS.EDIT_FEEDBACK,
//     name: { en: "Edit Feedback", ar: "تعديل حدث" },
//   },
//   {
//     key: PERMISSIONS.RESOLVE_FEEDBACK,
//     name: { en: "Resolve Feedback", ar: "تعديل حدث" },
//   },
//   {
//     key: PERMISSIONS.DELETE_FEEDBACK,
//     name: { en: "Delete Feedback", ar: "إضافة حدث" },
//   },
//   {
//     key: PERMISSIONS.VIEW_FEEDBACKS,
//     name: { en: "View Feedbacks", ar: "إضافة حدث" },
//   },
//   {
//     key: PERMISSIONS.EDIT_CLUB_POST,
//     name: { en: "Edit Club Post", ar: "تعديل حدث" },
//   },
//   {
//     key: PERMISSIONS.DELETE_CLUB_POST,
//     name: { en: "Delete Club Post", ar: "إضافة حدث" },
//   },
//   {
//     key: PERMISSIONS.VIEW_CLUB_POSTS,
//     name: { en: "View Club Posts", ar: "روئية حدث" },
//   },
//   {
//     key: PERMISSIONS.EDIT_CLUB_PODCAST,
//     name: { en: "Edit Club Podcast", ar: "تعديل مدونة صوتية" },
//   },
//   {
//     key: PERMISSIONS.DELETE_CLUB_PODCAST,
//     name: { en: "Delete Club Podcast", ar: "إضافة مدونة صوتية" },
//   },
//   {
//     key: PERMISSIONS.VIEW_CLUB_PODCASTS,
//     name: { en: "View Club Podcasts", ar: "روئية مدونة صوتية" },
//   },
//   {
//     key: PERMISSIONS.ADD_ADMIN_POST,
//     name: { en: "Add Admin Post", ar: "إضافة حدث" },
//   },
//   {
//     key: PERMISSIONS.EDIT_ADMIN_POST,
//     name: { en: "Edit Admin Post", ar: "تعديل حدث" },
//   },
//   {
//     key: PERMISSIONS.DELETE_ADMIN_POST,
//     name: { en: "Delete Admin Post", ar: "إضافة حدث" },
//   },
//   {
//     key: PERMISSIONS.VIEW_ADMIN_POSTS,
//     name: { en: "View Admin Posts", ar: "إضافة حدث" },
//   },
//   {
//     key: PERMISSIONS.ADD_SYSTEM_USER,
//     name: { en: "Add System Users", ar: "إضافة حدث" },
//   },
//   {
//     key: PERMISSIONS.EDIT_SYSTEM_USER,
//     name: { en: "Edit System Users", ar: "تعديل حدث" },
//   },
//   {
//     key: PERMISSIONS.DELETE_SYSTEM_USER,
//     name: { en: "Delete System Users", ar: "إضافة حدث" },
//   },
//   {
//     key: PERMISSIONS.VIEW_SYSTEM_USERS,
//     name: { en: "View System Users", ar: "إضافة حدث" },
//   },
//   {
//     key: PERMISSIONS.ADD_FEATURED_PODCAST,
//     name: { en: "Add Featured Podacst", ar: "إضافة حدث" },
//   },
//   {
//     key: PERMISSIONS.EDIT_FEATURED_PODCAST,
//     name: { en: "Edit Featured Podacst", ar: "تعديل حدث" },
//   },
//   {
//     key: PERMISSIONS.DELETE_FEATURED_PODCAST,
//     name: { en: "Delete Featured Podacst", ar: "إضافة حدث" },
//   },
//   {
//     key: PERMISSIONS.VIEW_FEATURED_PODCASTS,
//     name: { en: "View Featured Podacsts", ar: "إضافة حدث" },
//   },
//   {
//     key: PERMISSIONS.ADD_ROLE,
//     name: { en: "Add Role", ar: "إضافة حدث" },
//   },
//   {
//     key: PERMISSIONS.EDIT_ROLE,
//     name: { en: "Edit Role", ar: "تعديل حدث" },
//   },
//   {
//     key: PERMISSIONS.DELETE_ROLE,
//     name: { en: "Delete Role", ar: "إضافة حدث" },
//   },
//   {
//     key: PERMISSIONS.VIEW_ROLES,
//     name: { en: "View Roles", ar: "إضافة حدث" },
//   },
//   {
//     key: PERMISSIONS.ADD_TASK,
//     name: { en: "Add Task", ar: "إضافة حدث" },
//   },
//   {
//     key: PERMISSIONS.EDIT_TASK,
//     name: { en: "Edit Task", ar: "تعديل حدث" },
//   },
//   {
//     key: PERMISSIONS.DELETE_TASK,
//     name: { en: "Delete Task", ar: "إضافة حدث" },
//   },
//   {
//     key: PERMISSIONS.VIEW_TASKS,
//     name: { en: "View Tasks", ar: "إضافة حدث" },
//   },
//   {
//     key: PERMISSIONS.ADD_BADGE,
//     name: { en: "Add Badge", ar: "إضافة حدث" },
//   },
//   {
//     key: PERMISSIONS.EDIT_BADGE,
//     name: { en: "Edit Badge", ar: "تعديل حدث" },
//   },
//   {
//     key: PERMISSIONS.DELETE_BADGE,
//     name: { en: "Delete Badge", ar: "إضافة حدث" },
//   },
//   {
//     key: PERMISSIONS.VIEW_BADGES,
//     name: { en: "View Badges", ar: "إضافة حدث" },
//   },
//   // podcast categories 
//   {
//     key: PERMISSIONS.ADD_PODCAST_CATEGORY,
//     name: { en: "Add Podcast Category", ar: "إضافة حدث" },
//   },
//   {
//     key: PERMISSIONS.EDIT_PODCAST_CATEGORY,
//     name: { en: "Edit Podcast Category", ar: "تعديل حدث" },
//   },
//   {
//     key: PERMISSIONS.DELETE_PODCAST_CATEGORY,
//     name: { en: "Delete Podcast Category", ar: "إضافة حدث" },
//   },
//   {
//     key: PERMISSIONS.VIEW_PODCAST_CATEGORIES,
//     name: { en: "View Podcast Categories", ar: "إضافة حدث" },
//   },
//   // podcast categories 
//   {
//     key: PERMISSIONS.ADD_PROGRAM,
//     name: { en: "Add Program", ar: "إضافة حدث" },
//   },
//   {
//     key: PERMISSIONS.EDIT_PROGRAM,
//     name: { en: "Edit Program", ar: "تعديل حدث" },
//   },
//   {
//     key: PERMISSIONS.DELETE_PROGRAM,
//     name: { en: "Delete Program", ar: "إضافة حدث" },
//   },
//   {
//     key: PERMISSIONS.VIEW_PROGRAMS,
//     name: { en: "View Programs", ar: "إضافة حدث" },
//   },
//   // clubs
//   {
//     key: PERMISSIONS.ADD_CLUB,
//     name: { en: "Add CLUB", ar: "إضافة حدث" },
//   },
//   {
//     key: PERMISSIONS.EDIT_CLUB,
//     name: { en: "Edit Club", ar: "تعديل حدث" },
//   },
//   {
//     key: PERMISSIONS.DELETE_CLUB,
//     name: { en: "Delete Club", ar: "إضافة حدث" },
//   },
//   {
//     key: PERMISSIONS.VIEW_CLUBS,
//     name: { en: "View Clubs", ar: "إضافة حدث" },
//   },
//   // clubs
//   {
//     key: PERMISSIONS.ADD_CLUB_CODE,
//     name: { en: "Add CLUB Codes", ar: "إضافة حدث" },
//   },
//   {
//     key: PERMISSIONS.EDIT_CLUB_CODE,
//     name: { en: "Edit Club Codes", ar: "تعديل حدث" },
//   },
//   {
//     key: PERMISSIONS.VIEW_CLUB_CODES,
//     name: { en: "View Club Codes", ar: "إضافة حدث" },
//   },
// ];
