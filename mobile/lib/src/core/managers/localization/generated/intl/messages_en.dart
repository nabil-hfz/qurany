// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(sheikh_name) => "By sheikh: ${sheikh_name}";

  static String m8(name) => "Hi, ${name}!";

  static String m1(num count) =>
      "${Intl.plural(count, zero: '', one: '1 hour', other: '${count} hours')}";

  static String m2(num count) => "${count} h";

  static String m3(num count) =>
      "${Intl.plural(count, zero: '', one: '1 minute', other: '${count} minutes')}";

  static String m4(num count) => "${count} m";

  static String m9(num count) =>
      "${Intl.plural(count, zero: 'no wombats', one: '1 wombat', other: '${count} wombats')}";

  static String m5(num count) =>
      "${Intl.plural(count, zero: '', one: '1 second', other: '${count} seconds')}";

  static String m6(num count) => "${count} s";

  static String m7(minLength) =>
      "This field should minimum length of ${minLength} characters";

  static String m10(min, max) =>
      "This value should should be in range of (${min},${max})";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "activate": MessageLookupByLibrary.simpleMessage("Activate"),
        "activated": MessageLookupByLibrary.simpleMessage("Activated"),
        "add": MessageLookupByLibrary.simpleMessage("Add"),
        "add_another_phone_number":
            MessageLookupByLibrary.simpleMessage("Add another phone number"),
        "add_category": MessageLookupByLibrary.simpleMessage("Add Category"),
        "add_discount": MessageLookupByLibrary.simpleMessage("Add discount"),
        "add_new_service":
            MessageLookupByLibrary.simpleMessage("Add New Service"),
        "add_package": MessageLookupByLibrary.simpleMessage("Add package"),
        "add_short_description":
            MessageLookupByLibrary.simpleMessage("Add short description"),
        "add_staff_member":
            MessageLookupByLibrary.simpleMessage("Add staff member"),
        "add_tag": MessageLookupByLibrary.simpleMessage("Add tag"),
        "added_successfully":
            MessageLookupByLibrary.simpleMessage("Added successfully"),
        "address1": MessageLookupByLibrary.simpleMessage("Address1"),
        "address1_notes": MessageLookupByLibrary.simpleMessage(
            "Area,Block,Building,House no,Company Name,etc"),
        "address2": MessageLookupByLibrary.simpleMessage("Address2"),
        "address2_notes": MessageLookupByLibrary.simpleMessage(
            "Nearby Landmark,Well-known building or Places,etc"),
        "are_you_sure_to_continue": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to continue?"),
        "assign_services_to_your_package": MessageLookupByLibrary.simpleMessage(
            "Assign services to your package"),
        "attach_file": MessageLookupByLibrary.simpleMessage("Attach file(s)"),
        "attach_image_or_video":
            MessageLookupByLibrary.simpleMessage("Attach image(s) or video(s)"),
        "b": MessageLookupByLibrary.simpleMessage("B"),
        "back_button": MessageLookupByLibrary.simpleMessage("Back button"),
        "barber": MessageLookupByLibrary.simpleMessage("Barber"),
        "brief": MessageLookupByLibrary.simpleMessage("Brief"),
        "busy": MessageLookupByLibrary.simpleMessage("Busy"),
        "by": MessageLookupByLibrary.simpleMessage("By"),
        "by_sheikh": m0,
        "calendar": MessageLookupByLibrary.simpleMessage("Calendar"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "catalog": MessageLookupByLibrary.simpleMessage("Catalog"),
        "categories": MessageLookupByLibrary.simpleMessage("Categories"),
        "change_language":
            MessageLookupByLibrary.simpleMessage("Change Language"),
        "change_password":
            MessageLookupByLibrary.simpleMessage("Change password"),
        "children": MessageLookupByLibrary.simpleMessage("Children"),
        "choose_your_price_method_and_edit_current_price":
            MessageLookupByLibrary.simpleMessage(
                "Choose your price type and edit current price"),
        "city": MessageLookupByLibrary.simpleMessage("City"),
        "clients": MessageLookupByLibrary.simpleMessage("clients"),
        "confirm": MessageLookupByLibrary.simpleMessage("Confirm"),
        "confirm_new_password":
            MessageLookupByLibrary.simpleMessage("Confirm new password"),
        "confirm_password":
            MessageLookupByLibrary.simpleMessage("Confirm password"),
        "connection_error":
            MessageLookupByLibrary.simpleMessage("Connection Error"),
        "contact_info": MessageLookupByLibrary.simpleMessage("Contact info"),
        "country": MessageLookupByLibrary.simpleMessage("Country"),
        "country_code": MessageLookupByLibrary.simpleMessage("Country Code"),
        "current_category":
            MessageLookupByLibrary.simpleMessage("Current Category"),
        "current_password":
            MessageLookupByLibrary.simpleMessage("Current password"),
        "current_subcategory":
            MessageLookupByLibrary.simpleMessage("Current sub-category"),
        "custom_pricing":
            MessageLookupByLibrary.simpleMessage("Custom pricing"),
        "dark_mode": MessageLookupByLibrary.simpleMessage("Dark mode"),
        "deactivate": MessageLookupByLibrary.simpleMessage("Deactivate"),
        "deactivated": MessageLookupByLibrary.simpleMessage("Deactivated"),
        "delete": MessageLookupByLibrary.simpleMessage("Delete"),
        "delete_package":
            MessageLookupByLibrary.simpleMessage("Delete package"),
        "delete_service":
            MessageLookupByLibrary.simpleMessage("Delete service"),
        "deleting": MessageLookupByLibrary.simpleMessage("Deleting..."),
        "description": MessageLookupByLibrary.simpleMessage("Description"),
        "dio_bad_request_error":
            MessageLookupByLibrary.simpleMessage("Bad Request!"),
        "dio_cancel_error": MessageLookupByLibrary.simpleMessage(
            "Request to API server was cancelled"),
        "dio_connection_timeout_error": MessageLookupByLibrary.simpleMessage(
            "Connection timeout with API server"),
        "dio_not_found_error":
            MessageLookupByLibrary.simpleMessage("Not found error!"),
        "dio_receive_connection_timeout_error":
            MessageLookupByLibrary.simpleMessage(
                "Receive timeout in connection with API server"),
        "dio_send_timeout_to_the_server": MessageLookupByLibrary.simpleMessage(
            "Send timeout in connection with API server"),
        "do_not_receive_code":
            MessageLookupByLibrary.simpleMessage("Don\'t receive the code?"),
        "done": MessageLookupByLibrary.simpleMessage("Done"),
        "edit": MessageLookupByLibrary.simpleMessage("Edit"),
        "edit_package": MessageLookupByLibrary.simpleMessage("Edit package"),
        "edit_service": MessageLookupByLibrary.simpleMessage("Edit Service"),
        "edit_staff_member_info":
            MessageLookupByLibrary.simpleMessage("Edit staff member info"),
        "edit_tag": MessageLookupByLibrary.simpleMessage("Edit tag"),
        "end_at": MessageLookupByLibrary.simpleMessage("End at"),
        "end_error_strings": MessageLookupByLibrary.simpleMessage(
            "========================================================"),
        "ending_at": MessageLookupByLibrary.simpleMessage("Ending at"),
        "enter_your_current_password":
            MessageLookupByLibrary.simpleMessage("Enter your current password"),
        "enter_your_email":
            MessageLookupByLibrary.simpleMessage("Enter your email"),
        "enter_your_new_password":
            MessageLookupByLibrary.simpleMessage("Enter your new password"),
        "enter_your_password":
            MessageLookupByLibrary.simpleMessage("Enter your password"),
        "enter_your_password_again":
            MessageLookupByLibrary.simpleMessage("Enter your password again"),
        "enter_your_phone":
            MessageLookupByLibrary.simpleMessage("Enter your phone"),
        "enter_your_salon_brief": MessageLookupByLibrary.simpleMessage(
            "Enter a brief about your business"),
        "enter_your_salon_business_type":
            MessageLookupByLibrary.simpleMessage("Enter your business type"),
        "enter_your_salon_email":
            MessageLookupByLibrary.simpleMessage("Enter your business email"),
        "enter_your_salon_name":
            MessageLookupByLibrary.simpleMessage("Enter your business name"),
        "enter_your_salon_phone":
            MessageLookupByLibrary.simpleMessage("Enter your business phone"),
        "enter_your_salon_website_url": MessageLookupByLibrary.simpleMessage(
            "Enter your business website url"),
        "enter_your_staff_member_name": MessageLookupByLibrary.simpleMessage(
            "Enter your staff member name"),
        "enter_your_user_name":
            MessageLookupByLibrary.simpleMessage("Enter your user name"),
        "enter_your_valid_url":
            MessageLookupByLibrary.simpleMessage("Enter your valid url"),
        "err_duplicated_credential":
            MessageLookupByLibrary.simpleMessage("Duplicated credential"),
        "err_invalid_credential":
            MessageLookupByLibrary.simpleMessage("Invalid credential"),
        "err_operation_not_allowed":
            MessageLookupByLibrary.simpleMessage("Operation not allowed"),
        "err_this_email_is_already_in_use":
            MessageLookupByLibrary.simpleMessage(
                "This email is already in use"),
        "err_too_many_requests":
            MessageLookupByLibrary.simpleMessage("Too many requests"),
        "err_unexpected_error_happened":
            MessageLookupByLibrary.simpleMessage("Unexpected error happened"),
        "err_user_disabled":
            MessageLookupByLibrary.simpleMessage("User was disabled"),
        "err_user_not_found":
            MessageLookupByLibrary.simpleMessage("User was not found"),
        "err_valid_email":
            MessageLookupByLibrary.simpleMessage("Not valid email"),
        "err_wrong_email":
            MessageLookupByLibrary.simpleMessage("Invalid email"),
        "err_wrong_email_or_password":
            MessageLookupByLibrary.simpleMessage("Invalid email or password"),
        "error": MessageLookupByLibrary.simpleMessage("Error"),
        "error_internal_server":
            MessageLookupByLibrary.simpleMessage("Internal server error"),
        "error_unexpected":
            MessageLookupByLibrary.simpleMessage("Unexpected Error happened"),
        "facebook": MessageLookupByLibrary.simpleMessage("Facebook"),
        "forgot_password":
            MessageLookupByLibrary.simpleMessage("Forgot password"),
        "forgot_password_":
            MessageLookupByLibrary.simpleMessage("Forgot password?"),
        "free": MessageLookupByLibrary.simpleMessage("Free"),
        "gallery": MessageLookupByLibrary.simpleMessage("Gallery"),
        "greeting": m8,
        "hairdresser": MessageLookupByLibrary.simpleMessage("Hairdresser"),
        "here": MessageLookupByLibrary.simpleMessage(
            "here ============================"),
        "home": MessageLookupByLibrary.simpleMessage("Home"),
        "home_menu_button":
            MessageLookupByLibrary.simpleMessage("Home menu button"),
        "hours_count": m1,
        "hours_count_short": m2,
        "instagram": MessageLookupByLibrary.simpleMessage("Instagram"),
        "islamic_library":
            MessageLookupByLibrary.simpleMessage("Islamic Library"),
        "k": MessageLookupByLibrary.simpleMessage("K"),
        "khatma": MessageLookupByLibrary.simpleMessage("Khatma"),
        "khatma_details":
            MessageLookupByLibrary.simpleMessage("Khatma Details"),
        "khatmat": MessageLookupByLibrary.simpleMessage("Khatmat"),
        "kids": MessageLookupByLibrary.simpleMessage("Kids"),
        "language": MessageLookupByLibrary.simpleMessage("Language"),
        "languages": MessageLookupByLibrary.simpleMessage("Languages"),
        "later": MessageLookupByLibrary.simpleMessage("Later"),
        "library": MessageLookupByLibrary.simpleMessage("Library"),
        "links": MessageLookupByLibrary.simpleMessage("Links"),
        "location": MessageLookupByLibrary.simpleMessage("Location"),
        "log_in": MessageLookupByLibrary.simpleMessage("Log In"),
        "log_out": MessageLookupByLibrary.simpleMessage("Log out"),
        "logout_message": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to log out?"),
        "m": MessageLookupByLibrary.simpleMessage("M"),
        "main_business_type":
            MessageLookupByLibrary.simpleMessage("Main business type"),
        "main_info": MessageLookupByLibrary.simpleMessage("Main Info"),
        "men": MessageLookupByLibrary.simpleMessage("Men"),
        "minutes_count": m3,
        "minutes_count_short": m4,
        "more": MessageLookupByLibrary.simpleMessage("More"),
        "nWombats": m9,
        "name": MessageLookupByLibrary.simpleMessage("Name"),
        "new_account": MessageLookupByLibrary.simpleMessage("New account"),
        "new_password": MessageLookupByLibrary.simpleMessage("New password"),
        "new_service": MessageLookupByLibrary.simpleMessage("New Service"),
        "not_set": MessageLookupByLibrary.simpleMessage("Not set"),
        "notifications": MessageLookupByLibrary.simpleMessage("Notifications"),
        "notifications_settings":
            MessageLookupByLibrary.simpleMessage("Notifications settings"),
        "off": MessageLookupByLibrary.simpleMessage("Off"),
        "offer": MessageLookupByLibrary.simpleMessage("Offer"),
        "offers": MessageLookupByLibrary.simpleMessage("Offers"),
        "open_now": MessageLookupByLibrary.simpleMessage("Open Now"),
        "opening_hours": MessageLookupByLibrary.simpleMessage("Opening Hours"),
        "options": MessageLookupByLibrary.simpleMessage("Options"),
        "package_description":
            MessageLookupByLibrary.simpleMessage("Package description"),
        "package_name": MessageLookupByLibrary.simpleMessage("Package name"),
        "package_services":
            MessageLookupByLibrary.simpleMessage("Package services"),
        "packages": MessageLookupByLibrary.simpleMessage("Packages"),
        "password": MessageLookupByLibrary.simpleMessage("Password"),
        "percentage_discount":
            MessageLookupByLibrary.simpleMessage("Percentage discount"),
        "phone_number": MessageLookupByLibrary.simpleMessage("Phone number"),
        "phone_number_verification":
            MessageLookupByLibrary.simpleMessage("Phone number verification"),
        "price": MessageLookupByLibrary.simpleMessage("Price"),
        "price_type": MessageLookupByLibrary.simpleMessage("Price type"),
        "processing": MessageLookupByLibrary.simpleMessage("Processing"),
        "quran": MessageLookupByLibrary.simpleMessage("Quran"),
        "rating": MessageLookupByLibrary.simpleMessage("Rating"),
        "ratings": MessageLookupByLibrary.simpleMessage("Ratings"),
        "read_less": MessageLookupByLibrary.simpleMessage("Read less"),
        "read_more": MessageLookupByLibrary.simpleMessage("Read more"),
        "reciter": MessageLookupByLibrary.simpleMessage("Reciter"),
        "reciters": MessageLookupByLibrary.simpleMessage("Reciters"),
        "remember_me": MessageLookupByLibrary.simpleMessage("Remember me"),
        "resend": MessageLookupByLibrary.simpleMessage("Resend"),
        "reset": MessageLookupByLibrary.simpleMessage("Reset"),
        "reset_password":
            MessageLookupByLibrary.simpleMessage("Reset password"),
        "retail_price": MessageLookupByLibrary.simpleMessage("Retail price"),
        "retry": MessageLookupByLibrary.simpleMessage("Retry"),
        "retype_your_new_password":
            MessageLookupByLibrary.simpleMessage("Retype your new password"),
        "review": MessageLookupByLibrary.simpleMessage("Review"),
        "reviews": MessageLookupByLibrary.simpleMessage("Reviews"),
        "s": MessageLookupByLibrary.simpleMessage("S"),
        "salon_customers":
            MessageLookupByLibrary.simpleMessage("Business customers"),
        "salon_customers_from":
            MessageLookupByLibrary.simpleMessage("Your customers from"),
        "salon_email": MessageLookupByLibrary.simpleMessage("Business email"),
        "salon_info": MessageLookupByLibrary.simpleMessage("Salon Info"),
        "salon_location":
            MessageLookupByLibrary.simpleMessage("Salon Location"),
        "salon_name": MessageLookupByLibrary.simpleMessage("Business name"),
        "salon_phone": MessageLookupByLibrary.simpleMessage("Business phone"),
        "save": MessageLookupByLibrary.simpleMessage("Save"),
        "search": MessageLookupByLibrary.simpleMessage("Search"),
        "search_by_location_or_code":
            MessageLookupByLibrary.simpleMessage("Search by location or code"),
        "seconds_count": m5,
        "seconds_count_short": m6,
        "seek_backward_button":
            MessageLookupByLibrary.simpleMessage("Seek backward button"),
        "seek_forward_button":
            MessageLookupByLibrary.simpleMessage("Seek forward button"),
        "select_another_service":
            MessageLookupByLibrary.simpleMessage("Select another service(s)"),
        "select_duration":
            MessageLookupByLibrary.simpleMessage("Select duration"),
        "select_one": MessageLookupByLibrary.simpleMessage("Select one"),
        "select_price_type":
            MessageLookupByLibrary.simpleMessage("Select price type"),
        "select_service":
            MessageLookupByLibrary.simpleMessage("Select service"),
        "select_service_s":
            MessageLookupByLibrary.simpleMessage("Select service(s)"),
        "service": MessageLookupByLibrary.simpleMessage("Service"),
        "service_available_for":
            MessageLookupByLibrary.simpleMessage("Service available for"),
        "service_category":
            MessageLookupByLibrary.simpleMessage("Service category"),
        "service_color": MessageLookupByLibrary.simpleMessage("Service color"),
        "service_description":
            MessageLookupByLibrary.simpleMessage("Service description"),
        "service_discount":
            MessageLookupByLibrary.simpleMessage("Service discount"),
        "service_duration":
            MessageLookupByLibrary.simpleMessage("Service duration"),
        "service_name": MessageLookupByLibrary.simpleMessage("Service name"),
        "service_price": MessageLookupByLibrary.simpleMessage("Service price"),
        "service_pricing":
            MessageLookupByLibrary.simpleMessage("Service pricing"),
        "service_subcategory":
            MessageLookupByLibrary.simpleMessage("Service sub-category"),
        "services": MessageLookupByLibrary.simpleMessage("Services"),
        "set_this_discount_forever":
            MessageLookupByLibrary.simpleMessage("Set this discount forever"),
        "settings": MessageLookupByLibrary.simpleMessage("Settings"),
        "sign_up": MessageLookupByLibrary.simpleMessage("Sign up"),
        "size": MessageLookupByLibrary.simpleMessage("Size"),
        "social": MessageLookupByLibrary.simpleMessage("Social"),
        "something_went_wrong_check_connection":
            MessageLookupByLibrary.simpleMessage(
                "Something went wrong, please check your internet connection and try again"),
        "something_went_wrong_please_try_again":
            MessageLookupByLibrary.simpleMessage(
                "Something went wrong,\n Please try again."),
        "spa": MessageLookupByLibrary.simpleMessage("SPA"),
        "staff": MessageLookupByLibrary.simpleMessage("Staff"),
        "start": MessageLookupByLibrary.simpleMessage("Start"),
        "start_error_strings": MessageLookupByLibrary.simpleMessage(
            "=============== Start Error Strings =================="),
        "start_from": MessageLookupByLibrary.simpleMessage("Start from"),
        "starting_from": MessageLookupByLibrary.simpleMessage("Starting from"),
        "statistics": MessageLookupByLibrary.simpleMessage("Statistics"),
        "stay_tuned": MessageLookupByLibrary.simpleMessage("Stay tuned"),
        "street": MessageLookupByLibrary.simpleMessage("Street"),
        "stylist": MessageLookupByLibrary.simpleMessage("Stylist"),
        "submit": MessageLookupByLibrary.simpleMessage("Submit"),
        "tag_color": MessageLookupByLibrary.simpleMessage("Tag color"),
        "tag_description":
            MessageLookupByLibrary.simpleMessage("Tag description"),
        "tag_name": MessageLookupByLibrary.simpleMessage("Tag name"),
        "tags": MessageLookupByLibrary.simpleMessage("Tags"),
        "tap_again_to_eit":
            MessageLookupByLibrary.simpleMessage("Tap again to exit!"),
        "tap_to_pick_salon_location_on_the_map":
            MessageLookupByLibrary.simpleMessage(
                "Tap to pick your location on the map"),
        "the_account_info_are_not_valid": MessageLookupByLibrary.simpleMessage(
            "The account info are not valid"),
        "tiktok": MessageLookupByLibrary.simpleMessage("Tiktok"),
        "time_bought": MessageLookupByLibrary.simpleMessage("Time bought"),
        "times_bought": MessageLookupByLibrary.simpleMessage("Times bought"),
        "total_duration":
            MessageLookupByLibrary.simpleMessage("Total duration"),
        "total_price": MessageLookupByLibrary.simpleMessage("Total price"),
        "try_again": MessageLookupByLibrary.simpleMessage("Try again"),
        "twitter": MessageLookupByLibrary.simpleMessage("Twitter"),
        "type_the_verification_code_we_have_sent_you":
            MessageLookupByLibrary.simpleMessage(
                "Type the verification code\nthat we\'ve sent it you."),
        "un_authorized_error":
            MessageLookupByLibrary.simpleMessage("Unauthorized Error"),
        "unknown_error": MessageLookupByLibrary.simpleMessage("UnKnown error"),
        "unknown_size": MessageLookupByLibrary.simpleMessage("Unknown size"),
        "update": MessageLookupByLibrary.simpleMessage("Update"),
        "updated_successfully":
            MessageLookupByLibrary.simpleMessage("Updated successfully"),
        "url": MessageLookupByLibrary.simpleMessage("Url"),
        "user_cancel_error":
            MessageLookupByLibrary.simpleMessage("Canceled by the user"),
        "user_email": MessageLookupByLibrary.simpleMessage("User email"),
        "user_name": MessageLookupByLibrary.simpleMessage("User name"),
        "validator_invalid_email":
            MessageLookupByLibrary.simpleMessage("Invalid email!"),
        "validator_it_does_not_match":
            MessageLookupByLibrary.simpleMessage("It does not match"),
        "validator_should_be_with_minimum_length_of_characters": m7,
        "validator_should_be_with_range_of": m10,
        "validator_this_field_is_required":
            MessageLookupByLibrary.simpleMessage("This field is required"),
        "verify": MessageLookupByLibrary.simpleMessage("Verify"),
        "we_will_send_your_4_digit_verification_code_to":
            MessageLookupByLibrary.simpleMessage(
                "We\'ll send your 4 digit verification code to"),
        "website": MessageLookupByLibrary.simpleMessage("Website"),
        "whoops": MessageLookupByLibrary.simpleMessage("Whoops!"),
        "whoops_info": MessageLookupByLibrary.simpleMessage("Whoops!!"),
        "women": MessageLookupByLibrary.simpleMessage("Women"),
        "working_hours": MessageLookupByLibrary.simpleMessage("Working Hours"),
        "you_have_to_choose_an_option_for_service_availability":
            MessageLookupByLibrary.simpleMessage(
                "You have to choose an option for service availability"),
        "your_new_password":
            MessageLookupByLibrary.simpleMessage("Your new password")
      };
}
