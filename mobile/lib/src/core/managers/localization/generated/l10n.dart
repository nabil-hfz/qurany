// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class Translations {
  Translations();

  static Translations? _current;

  static Translations get current {
    assert(_current != null,
        'No instance of Translations was loaded. Try to initialize the Translations delegate before accessing Translations.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<Translations> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = Translations();
      Translations._current = instance;

      return instance;
    });
  }

  static Translations of(BuildContext context) {
    final instance = Translations.maybeOf(context);
    assert(instance != null,
        'No instance of Translations present in the widget tree. Did you add Translations.delegate in localizationsDelegates?');
    return instance!;
  }

  static Translations? maybeOf(BuildContext context) {
    return Localizations.of<Translations>(context, Translations);
  }

  /// `=============== Start Error Strings ==================`
  String get start_error_strings {
    return Intl.message(
      '=============== Start Error Strings ==================',
      name: 'start_error_strings',
      desc: '',
      args: [],
    );
  }

  /// `Unauthorized Error`
  String get un_authorized_error {
    return Intl.message(
      'Unauthorized Error',
      name: 'un_authorized_error',
      desc: '',
      args: [],
    );
  }

  /// `Connection Error`
  String get connection_error {
    return Intl.message(
      'Connection Error',
      name: 'connection_error',
      desc: '',
      args: [],
    );
  }

  /// `Canceled by the user`
  String get user_cancel_error {
    return Intl.message(
      'Canceled by the user',
      name: 'user_cancel_error',
      desc: '',
      args: [],
    );
  }

  /// `UnKnown error`
  String get unknown_error {
    return Intl.message(
      'UnKnown error',
      name: 'unknown_error',
      desc: '',
      args: [],
    );
  }

  /// `Internal server error`
  String get error_internal_server {
    return Intl.message(
      'Internal server error',
      name: 'error_internal_server',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong, please check your internet connection and try again`
  String get something_went_wrong_check_connection {
    return Intl.message(
      'Something went wrong, please check your internet connection and try again',
      name: 'something_went_wrong_check_connection',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong,\n Please try again.`
  String get something_went_wrong_please_try_again {
    return Intl.message(
      'Something went wrong,\n Please try again.',
      name: 'something_went_wrong_please_try_again',
      desc: '',
      args: [],
    );
  }

  /// `Unexpected Error happened`
  String get error_unexpected {
    return Intl.message(
      'Unexpected Error happened',
      name: 'error_unexpected',
      desc: '',
      args: [],
    );
  }

  /// `Request to API server was cancelled`
  String get dio_cancel_error {
    return Intl.message(
      'Request to API server was cancelled',
      name: 'dio_cancel_error',
      desc: '',
      args: [],
    );
  }

  /// `Connection timeout with API server`
  String get dio_connection_timeout_error {
    return Intl.message(
      'Connection timeout with API server',
      name: 'dio_connection_timeout_error',
      desc: '',
      args: [],
    );
  }

  /// `Receive timeout in connection with API server`
  String get dio_receive_connection_timeout_error {
    return Intl.message(
      'Receive timeout in connection with API server',
      name: 'dio_receive_connection_timeout_error',
      desc: '',
      args: [],
    );
  }

  /// `Send timeout in connection with API server`
  String get dio_send_timeout_to_the_server {
    return Intl.message(
      'Send timeout in connection with API server',
      name: 'dio_send_timeout_to_the_server',
      desc: '',
      args: [],
    );
  }

  /// `Bad Request!`
  String get dio_bad_request_error {
    return Intl.message(
      'Bad Request!',
      name: 'dio_bad_request_error',
      desc: '',
      args: [],
    );
  }

  /// `Not found error!`
  String get dio_not_found_error {
    return Intl.message(
      'Not found error!',
      name: 'dio_not_found_error',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email!`
  String get validator_invalid_email {
    return Intl.message(
      'Invalid email!',
      name: 'validator_invalid_email',
      desc: '',
      args: [],
    );
  }

  /// `It does not match`
  String get validator_it_does_not_match {
    return Intl.message(
      'It does not match',
      name: 'validator_it_does_not_match',
      desc: '',
      args: [],
    );
  }

  /// `This field should minimum length of {minLength} characters`
  String validator_should_be_with_minimum_length_of_characters(int minLength) {
    return Intl.message(
      'This field should minimum length of $minLength characters',
      name: 'validator_should_be_with_minimum_length_of_characters',
      desc: 'This is the text for the text min length validator',
      args: [minLength],
    );
  }

  /// `This value should should be in range of ({min},{max})`
  String validator_should_be_with_range_of(Object min, Object max) {
    return Intl.message(
      'This value should should be in range of ($min,$max)',
      name: 'validator_should_be_with_range_of',
      desc: '',
      args: [min, max],
    );
  }

  /// `This field is required`
  String get validator_this_field_is_required {
    return Intl.message(
      'This field is required',
      name: 'validator_this_field_is_required',
      desc: '',
      args: [],
    );
  }

  /// `========================================================`
  String get end_error_strings {
    return Intl.message(
      '========================================================',
      name: 'end_error_strings',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Languages`
  String get languages {
    return Intl.message(
      'Languages',
      name: 'languages',
      desc: '',
      args: [],
    );
  }

  /// `Change Language`
  String get change_language {
    return Intl.message(
      'Change Language',
      name: 'change_language',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Start`
  String get start {
    return Intl.message(
      'Start',
      name: 'start',
      desc: '',
      args: [],
    );
  }

  /// `Reset`
  String get reset {
    return Intl.message(
      'Reset',
      name: 'reset',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Log In`
  String get log_in {
    return Intl.message(
      'Log In',
      name: 'log_in',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get sign_up {
    return Intl.message(
      'Sign up',
      name: 'sign_up',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Processing`
  String get processing {
    return Intl.message(
      'Processing',
      name: 'processing',
      desc: '',
      args: [],
    );
  }

  /// `Remember me`
  String get remember_me {
    return Intl.message(
      'Remember me',
      name: 'remember_me',
      desc: '',
      args: [],
    );
  }

  /// `Tap again to exit!`
  String get tap_again_to_eit {
    return Intl.message(
      'Tap again to exit!',
      name: 'tap_again_to_eit',
      desc: '',
      args: [],
    );
  }

  /// `By`
  String get by {
    return Intl.message(
      'By',
      name: 'by',
      desc: '',
      args: [],
    );
  }

  /// `Links`
  String get links {
    return Intl.message(
      'Links',
      name: 'links',
      desc: '',
      args: [],
    );
  }

  /// `Size`
  String get size {
    return Intl.message(
      'Size',
      name: 'size',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `New account`
  String get new_account {
    return Intl.message(
      'New account',
      name: 'new_account',
      desc: '',
      args: [],
    );
  }

  /// `Unknown size`
  String get unknown_size {
    return Intl.message(
      'Unknown size',
      name: 'unknown_size',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `User name`
  String get user_name {
    return Intl.message(
      'User name',
      name: 'user_name',
      desc: '',
      args: [],
    );
  }

  /// `Phone number`
  String get phone_number {
    return Intl.message(
      'Phone number',
      name: 'phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Enter your business name`
  String get enter_your_salon_name {
    return Intl.message(
      'Enter your business name',
      name: 'enter_your_salon_name',
      desc: '',
      args: [],
    );
  }

  /// `Enter your user name`
  String get enter_your_user_name {
    return Intl.message(
      'Enter your user name',
      name: 'enter_your_user_name',
      desc: '',
      args: [],
    );
  }

  /// `Business name`
  String get salon_name {
    return Intl.message(
      'Business name',
      name: 'salon_name',
      desc: '',
      args: [],
    );
  }

  /// `Enter your business phone`
  String get enter_your_salon_phone {
    return Intl.message(
      'Enter your business phone',
      name: 'enter_your_salon_phone',
      desc: '',
      args: [],
    );
  }

  /// `Enter your phone`
  String get enter_your_phone {
    return Intl.message(
      'Enter your phone',
      name: 'enter_your_phone',
      desc: '',
      args: [],
    );
  }

  /// `Business phone`
  String get salon_phone {
    return Intl.message(
      'Business phone',
      name: 'salon_phone',
      desc: '',
      args: [],
    );
  }

  /// `Search by location or code`
  String get search_by_location_or_code {
    return Intl.message(
      'Search by location or code',
      name: 'search_by_location_or_code',
      desc: '',
      args: [],
    );
  }

  /// `Country Code`
  String get country_code {
    return Intl.message(
      'Country Code',
      name: 'country_code',
      desc: '',
      args: [],
    );
  }

  /// `Country`
  String get country {
    return Intl.message(
      'Country',
      name: 'country',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get city {
    return Intl.message(
      'City',
      name: 'city',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Enter your password`
  String get enter_your_password {
    return Intl.message(
      'Enter your password',
      name: 'enter_your_password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password`
  String get confirm_password {
    return Intl.message(
      'Confirm password',
      name: 'confirm_password',
      desc: '',
      args: [],
    );
  }

  /// `Enter your password again`
  String get enter_your_password_again {
    return Intl.message(
      'Enter your password again',
      name: 'enter_your_password_again',
      desc: '',
      args: [],
    );
  }

  /// `Type the verification code\nthat we've sent it you.`
  String get type_the_verification_code_we_have_sent_you {
    return Intl.message(
      'Type the verification code\nthat we\'ve sent it you.',
      name: 'type_the_verification_code_we_have_sent_you',
      desc: '',
      args: [],
    );
  }

  /// `Verify`
  String get verify {
    return Intl.message(
      'Verify',
      name: 'verify',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `Don't receive the code?`
  String get do_not_receive_code {
    return Intl.message(
      'Don\'t receive the code?',
      name: 'do_not_receive_code',
      desc: '',
      args: [],
    );
  }

  /// `Resend`
  String get resend {
    return Intl.message(
      'Resend',
      name: 'resend',
      desc: '',
      args: [],
    );
  }

  /// `Phone number verification`
  String get phone_number_verification {
    return Intl.message(
      'Phone number verification',
      name: 'phone_number_verification',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to continue?`
  String get are_you_sure_to_continue {
    return Intl.message(
      'Are you sure you want to continue?',
      name: 'are_you_sure_to_continue',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `We'll send your 4 digit verification code to`
  String get we_will_send_your_4_digit_verification_code_to {
    return Intl.message(
      'We\'ll send your 4 digit verification code to',
      name: 'we_will_send_your_4_digit_verification_code_to',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password`
  String get forgot_password {
    return Intl.message(
      'Forgot password',
      name: 'forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password?`
  String get forgot_password_ {
    return Intl.message(
      'Forgot password?',
      name: 'forgot_password_',
      desc: '',
      args: [],
    );
  }

  /// `Reset password`
  String get reset_password {
    return Intl.message(
      'Reset password',
      name: 'reset_password',
      desc: '',
      args: [],
    );
  }

  /// `Your new password`
  String get your_new_password {
    return Intl.message(
      'Your new password',
      name: 'your_new_password',
      desc: '',
      args: [],
    );
  }

  /// `New password`
  String get new_password {
    return Intl.message(
      'New password',
      name: 'new_password',
      desc: '',
      args: [],
    );
  }

  /// `Enter your new password`
  String get enter_your_new_password {
    return Intl.message(
      'Enter your new password',
      name: 'enter_your_new_password',
      desc: '',
      args: [],
    );
  }

  /// `Retype your new password`
  String get retype_your_new_password {
    return Intl.message(
      'Retype your new password',
      name: 'retype_your_new_password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm new password`
  String get confirm_new_password {
    return Intl.message(
      'Confirm new password',
      name: 'confirm_new_password',
      desc: '',
      args: [],
    );
  }

  /// `Whoops!`
  String get whoops {
    return Intl.message(
      'Whoops!',
      name: 'whoops',
      desc: '',
      args: [],
    );
  }

  /// `Try again`
  String get try_again {
    return Intl.message(
      'Try again',
      name: 'try_again',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Calendar`
  String get calendar {
    return Intl.message(
      'Calendar',
      name: 'calendar',
      desc: '',
      args: [],
    );
  }

  /// `Tags`
  String get tags {
    return Intl.message(
      'Tags',
      name: 'tags',
      desc: '',
      args: [],
    );
  }

  /// `Services`
  String get services {
    return Intl.message(
      'Services',
      name: 'services',
      desc: '',
      args: [],
    );
  }

  /// `Service`
  String get service {
    return Intl.message(
      'Service',
      name: 'service',
      desc: '',
      args: [],
    );
  }

  /// `Offers`
  String get offers {
    return Intl.message(
      'Offers',
      name: 'offers',
      desc: '',
      args: [],
    );
  }

  /// `Offer`
  String get offer {
    return Intl.message(
      'Offer',
      name: 'offer',
      desc: '',
      args: [],
    );
  }

  /// `More`
  String get more {
    return Intl.message(
      'More',
      name: 'more',
      desc: '',
      args: [],
    );
  }

  /// `Catalog`
  String get catalog {
    return Intl.message(
      'Catalog',
      name: 'catalog',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get categories {
    return Intl.message(
      'Categories',
      name: 'categories',
      desc: '',
      args: [],
    );
  }

  /// `Packages`
  String get packages {
    return Intl.message(
      'Packages',
      name: 'packages',
      desc: '',
      args: [],
    );
  }

  /// `Options`
  String get options {
    return Intl.message(
      'Options',
      name: 'options',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Add tag`
  String get add_tag {
    return Intl.message(
      'Add tag',
      name: 'add_tag',
      desc: '',
      args: [],
    );
  }

  /// `Edit tag`
  String get edit_tag {
    return Intl.message(
      'Edit tag',
      name: 'edit_tag',
      desc: '',
      args: [],
    );
  }

  /// `Tag name`
  String get tag_name {
    return Intl.message(
      'Tag name',
      name: 'tag_name',
      desc: '',
      args: [],
    );
  }

  /// `Tag color`
  String get tag_color {
    return Intl.message(
      'Tag color',
      name: 'tag_color',
      desc: '',
      args: [],
    );
  }

  /// `Tag description`
  String get tag_description {
    return Intl.message(
      'Tag description',
      name: 'tag_description',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message(
      'Update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `Added successfully`
  String get added_successfully {
    return Intl.message(
      'Added successfully',
      name: 'added_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Updated successfully`
  String get updated_successfully {
    return Intl.message(
      'Updated successfully',
      name: 'updated_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Read more`
  String get read_more {
    return Intl.message(
      'Read more',
      name: 'read_more',
      desc: '',
      args: [],
    );
  }

  /// `Read less`
  String get read_less {
    return Intl.message(
      'Read less',
      name: 'read_less',
      desc: '',
      args: [],
    );
  }

  /// `Brief`
  String get brief {
    return Intl.message(
      'Brief',
      name: 'brief',
      desc: '',
      args: [],
    );
  }

  /// `Contact info`
  String get contact_info {
    return Intl.message(
      'Contact info',
      name: 'contact_info',
      desc: '',
      args: [],
    );
  }

  /// `Social`
  String get social {
    return Intl.message(
      'Social',
      name: 'social',
      desc: '',
      args: [],
    );
  }

  /// `Location`
  String get location {
    return Intl.message(
      'Location',
      name: 'location',
      desc: '',
      args: [],
    );
  }

  /// `Opening Hours`
  String get opening_hours {
    return Intl.message(
      'Opening Hours',
      name: 'opening_hours',
      desc: '',
      args: [],
    );
  }

  /// `Off`
  String get off {
    return Intl.message(
      'Off',
      name: 'off',
      desc: '',
      args: [],
    );
  }

  /// `Gallery`
  String get gallery {
    return Intl.message(
      'Gallery',
      name: 'gallery',
      desc: '',
      args: [],
    );
  }

  /// `Ratings`
  String get ratings {
    return Intl.message(
      'Ratings',
      name: 'ratings',
      desc: '',
      args: [],
    );
  }

  /// `Rating`
  String get rating {
    return Intl.message(
      'Rating',
      name: 'rating',
      desc: '',
      args: [],
    );
  }

  /// `Working Hours`
  String get working_hours {
    return Intl.message(
      'Working Hours',
      name: 'working_hours',
      desc: '',
      args: [],
    );
  }

  /// `Main Info`
  String get main_info {
    return Intl.message(
      'Main Info',
      name: 'main_info',
      desc: '',
      args: [],
    );
  }

  /// `clients`
  String get clients {
    return Intl.message(
      'clients',
      name: 'clients',
      desc: '',
      args: [],
    );
  }

  /// `Enter a brief about your business`
  String get enter_your_salon_brief {
    return Intl.message(
      'Enter a brief about your business',
      name: 'enter_your_salon_brief',
      desc: '',
      args: [],
    );
  }

  /// `Business email`
  String get salon_email {
    return Intl.message(
      'Business email',
      name: 'salon_email',
      desc: '',
      args: [],
    );
  }

  /// `Enter your business email`
  String get enter_your_salon_email {
    return Intl.message(
      'Enter your business email',
      name: 'enter_your_salon_email',
      desc: '',
      args: [],
    );
  }

  /// `Business customers`
  String get salon_customers {
    return Intl.message(
      'Business customers',
      name: 'salon_customers',
      desc: '',
      args: [],
    );
  }

  /// `Your customers from`
  String get salon_customers_from {
    return Intl.message(
      'Your customers from',
      name: 'salon_customers_from',
      desc: '',
      args: [],
    );
  }

  /// `Main business type`
  String get main_business_type {
    return Intl.message(
      'Main business type',
      name: 'main_business_type',
      desc: '',
      args: [],
    );
  }

  /// `Enter your business type`
  String get enter_your_salon_business_type {
    return Intl.message(
      'Enter your business type',
      name: 'enter_your_salon_business_type',
      desc: '',
      args: [],
    );
  }

  /// `Men`
  String get men {
    return Intl.message(
      'Men',
      name: 'men',
      desc: '',
      args: [],
    );
  }

  /// `Women`
  String get women {
    return Intl.message(
      'Women',
      name: 'women',
      desc: '',
      args: [],
    );
  }

  /// `Kids`
  String get kids {
    return Intl.message(
      'Kids',
      name: 'kids',
      desc: '',
      args: [],
    );
  }

  /// `Children`
  String get children {
    return Intl.message(
      'Children',
      name: 'children',
      desc: '',
      args: [],
    );
  }

  /// `Not set`
  String get not_set {
    return Intl.message(
      'Not set',
      name: 'not_set',
      desc: '',
      args: [],
    );
  }

  /// `Barber`
  String get barber {
    return Intl.message(
      'Barber',
      name: 'barber',
      desc: '',
      args: [],
    );
  }

  /// `Hairdresser`
  String get hairdresser {
    return Intl.message(
      'Hairdresser',
      name: 'hairdresser',
      desc: '',
      args: [],
    );
  }

  /// `SPA`
  String get spa {
    return Intl.message(
      'SPA',
      name: 'spa',
      desc: '',
      args: [],
    );
  }

  /// `Street`
  String get street {
    return Intl.message(
      'Street',
      name: 'street',
      desc: '',
      args: [],
    );
  }

  /// `Address1`
  String get address1 {
    return Intl.message(
      'Address1',
      name: 'address1',
      desc: '',
      args: [],
    );
  }

  /// `Address2`
  String get address2 {
    return Intl.message(
      'Address2',
      name: 'address2',
      desc: '',
      args: [],
    );
  }

  /// `Nearby Landmark,Well-known building or Places,etc`
  String get address2_notes {
    return Intl.message(
      'Nearby Landmark,Well-known building or Places,etc',
      name: 'address2_notes',
      desc: '',
      args: [],
    );
  }

  /// `Area,Block,Building,House no,Company Name,etc`
  String get address1_notes {
    return Intl.message(
      'Area,Block,Building,House no,Company Name,etc',
      name: 'address1_notes',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Tap to pick your location on the map`
  String get tap_to_pick_salon_location_on_the_map {
    return Intl.message(
      'Tap to pick your location on the map',
      name: 'tap_to_pick_salon_location_on_the_map',
      desc: '',
      args: [],
    );
  }

  /// `Facebook`
  String get facebook {
    return Intl.message(
      'Facebook',
      name: 'facebook',
      desc: '',
      args: [],
    );
  }

  /// `Twitter`
  String get twitter {
    return Intl.message(
      'Twitter',
      name: 'twitter',
      desc: '',
      args: [],
    );
  }

  /// `Instagram`
  String get instagram {
    return Intl.message(
      'Instagram',
      name: 'instagram',
      desc: '',
      args: [],
    );
  }

  /// `Website`
  String get website {
    return Intl.message(
      'Website',
      name: 'website',
      desc: '',
      args: [],
    );
  }

  /// `Enter your business website url`
  String get enter_your_salon_website_url {
    return Intl.message(
      'Enter your business website url',
      name: 'enter_your_salon_website_url',
      desc: '',
      args: [],
    );
  }

  /// `Tiktok`
  String get tiktok {
    return Intl.message(
      'Tiktok',
      name: 'tiktok',
      desc: '',
      args: [],
    );
  }

  /// `Select one`
  String get select_one {
    return Intl.message(
      'Select one',
      name: 'select_one',
      desc: '',
      args: [],
    );
  }

  /// `Url`
  String get url {
    return Intl.message(
      'Url',
      name: 'url',
      desc: '',
      args: [],
    );
  }

  /// `Enter your valid url`
  String get enter_your_valid_url {
    return Intl.message(
      'Enter your valid url',
      name: 'enter_your_valid_url',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Stylist`
  String get stylist {
    return Intl.message(
      'Stylist',
      name: 'stylist',
      desc: '',
      args: [],
    );
  }

  /// `Salon Info`
  String get salon_info {
    return Intl.message(
      'Salon Info',
      name: 'salon_info',
      desc: '',
      args: [],
    );
  }

  /// `Busy`
  String get busy {
    return Intl.message(
      'Busy',
      name: 'busy',
      desc: '',
      args: [],
    );
  }

  /// `Statistics`
  String get statistics {
    return Intl.message(
      'Statistics',
      name: 'statistics',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Log out`
  String get log_out {
    return Intl.message(
      'Log out',
      name: 'log_out',
      desc: '',
      args: [],
    );
  }

  /// `Open Now`
  String get open_now {
    return Intl.message(
      'Open Now',
      name: 'open_now',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Add staff member`
  String get add_staff_member {
    return Intl.message(
      'Add staff member',
      name: 'add_staff_member',
      desc: '',
      args: [],
    );
  }

  /// `Edit staff member info`
  String get edit_staff_member_info {
    return Intl.message(
      'Edit staff member info',
      name: 'edit_staff_member_info',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Enter your staff member name`
  String get enter_your_staff_member_name {
    return Intl.message(
      'Enter your staff member name',
      name: 'enter_your_staff_member_name',
      desc: '',
      args: [],
    );
  }

  /// `Staff`
  String get staff {
    return Intl.message(
      'Staff',
      name: 'staff',
      desc: '',
      args: [],
    );
  }

  /// `Later`
  String get later {
    return Intl.message(
      'Later',
      name: 'later',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to log out?`
  String get logout_message {
    return Intl.message(
      'Are you sure you want to log out?',
      name: 'logout_message',
      desc: '',
      args: [],
    );
  }

  /// `User email`
  String get user_email {
    return Intl.message(
      'User email',
      name: 'user_email',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email`
  String get enter_your_email {
    return Intl.message(
      'Enter your email',
      name: 'enter_your_email',
      desc: '',
      args: [],
    );
  }

  /// `Change password`
  String get change_password {
    return Intl.message(
      'Change password',
      name: 'change_password',
      desc: '',
      args: [],
    );
  }

  /// `Notifications settings`
  String get notifications_settings {
    return Intl.message(
      'Notifications settings',
      name: 'notifications_settings',
      desc: '',
      args: [],
    );
  }

  /// `Dark mode`
  String get dark_mode {
    return Intl.message(
      'Dark mode',
      name: 'dark_mode',
      desc: '',
      args: [],
    );
  }

  /// `Current password`
  String get current_password {
    return Intl.message(
      'Current password',
      name: 'current_password',
      desc: '',
      args: [],
    );
  }

  /// `Enter your current password`
  String get enter_your_current_password {
    return Intl.message(
      'Enter your current password',
      name: 'enter_your_current_password',
      desc: '',
      args: [],
    );
  }

  /// `Add another phone number`
  String get add_another_phone_number {
    return Intl.message(
      'Add another phone number',
      name: 'add_another_phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Review`
  String get review {
    return Intl.message(
      'Review',
      name: 'review',
      desc: '',
      args: [],
    );
  }

  /// `Reviews`
  String get reviews {
    return Intl.message(
      'Reviews',
      name: 'reviews',
      desc: '',
      args: [],
    );
  }

  /// `K`
  String get k {
    return Intl.message(
      'K',
      name: 'k',
      desc: '',
      args: [],
    );
  }

  /// `M`
  String get m {
    return Intl.message(
      'M',
      name: 'm',
      desc: '',
      args: [],
    );
  }

  /// `B`
  String get b {
    return Intl.message(
      'B',
      name: 'b',
      desc: '',
      args: [],
    );
  }

  /// `S`
  String get s {
    return Intl.message(
      'S',
      name: 's',
      desc: '',
      args: [],
    );
  }

  /// `Stay tuned`
  String get stay_tuned {
    return Intl.message(
      'Stay tuned',
      name: 'stay_tuned',
      desc: '',
      args: [],
    );
  }

  /// `Current Category`
  String get current_category {
    return Intl.message(
      'Current Category',
      name: 'current_category',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get retry {
    return Intl.message(
      'Retry',
      name: 'retry',
      desc: '',
      args: [],
    );
  }

  /// `Times bought`
  String get times_bought {
    return Intl.message(
      'Times bought',
      name: 'times_bought',
      desc: '',
      args: [],
    );
  }

  /// `Time bought`
  String get time_bought {
    return Intl.message(
      'Time bought',
      name: 'time_bought',
      desc: '',
      args: [],
    );
  }

  /// `Add Category`
  String get add_category {
    return Intl.message(
      'Add Category',
      name: 'add_category',
      desc: '',
      args: [],
    );
  }

  /// `New Service`
  String get new_service {
    return Intl.message(
      'New Service',
      name: 'new_service',
      desc: '',
      args: [],
    );
  }

  /// `Add New Service`
  String get add_new_service {
    return Intl.message(
      'Add New Service',
      name: 'add_new_service',
      desc: '',
      args: [],
    );
  }

  /// `Edit Service`
  String get edit_service {
    return Intl.message(
      'Edit Service',
      name: 'edit_service',
      desc: '',
      args: [],
    );
  }

  /// `Service name`
  String get service_name {
    return Intl.message(
      'Service name',
      name: 'service_name',
      desc: '',
      args: [],
    );
  }

  /// `Service color`
  String get service_color {
    return Intl.message(
      'Service color',
      name: 'service_color',
      desc: '',
      args: [],
    );
  }

  /// `Service description`
  String get service_description {
    return Intl.message(
      'Service description',
      name: 'service_description',
      desc: '',
      args: [],
    );
  }

  /// `Service category`
  String get service_category {
    return Intl.message(
      'Service category',
      name: 'service_category',
      desc: '',
      args: [],
    );
  }

  /// `Service duration`
  String get service_duration {
    return Intl.message(
      'Service duration',
      name: 'service_duration',
      desc: '',
      args: [],
    );
  }

  /// `Service discount`
  String get service_discount {
    return Intl.message(
      'Service discount',
      name: 'service_discount',
      desc: '',
      args: [],
    );
  }

  /// `Service price`
  String get service_price {
    return Intl.message(
      'Service price',
      name: 'service_price',
      desc: '',
      args: [],
    );
  }

  /// `Delete service`
  String get delete_service {
    return Intl.message(
      'Delete service',
      name: 'delete_service',
      desc: '',
      args: [],
    );
  }

  /// `Select service(s)`
  String get select_service_s {
    return Intl.message(
      'Select service(s)',
      name: 'select_service_s',
      desc: '',
      args: [],
    );
  }

  /// `Select another service(s)`
  String get select_another_service {
    return Intl.message(
      'Select another service(s)',
      name: 'select_another_service',
      desc: '',
      args: [],
    );
  }

  /// `Package services`
  String get package_services {
    return Intl.message(
      'Package services',
      name: 'package_services',
      desc: '',
      args: [],
    );
  }

  /// `Assign services to your package`
  String get assign_services_to_your_package {
    return Intl.message(
      'Assign services to your package',
      name: 'assign_services_to_your_package',
      desc: '',
      args: [],
    );
  }

  /// `Service pricing`
  String get service_pricing {
    return Intl.message(
      'Service pricing',
      name: 'service_pricing',
      desc: '',
      args: [],
    );
  }

  /// `Service available for`
  String get service_available_for {
    return Intl.message(
      'Service available for',
      name: 'service_available_for',
      desc: '',
      args: [],
    );
  }

  /// `Select service`
  String get select_service {
    return Intl.message(
      'Select service',
      name: 'select_service',
      desc: '',
      args: [],
    );
  }

  /// `Select duration`
  String get select_duration {
    return Intl.message(
      'Select duration',
      name: 'select_duration',
      desc: '',
      args: [],
    );
  }

  /// `Deleting...`
  String get deleting {
    return Intl.message(
      'Deleting...',
      name: 'deleting',
      desc: '',
      args: [],
    );
  }

  /// `Whoops!!`
  String get whoops_info {
    return Intl.message(
      'Whoops!!',
      name: 'whoops_info',
      desc: '',
      args: [],
    );
  }

  /// `Add package`
  String get add_package {
    return Intl.message(
      'Add package',
      name: 'add_package',
      desc: '',
      args: [],
    );
  }

  /// `Edit package`
  String get edit_package {
    return Intl.message(
      'Edit package',
      name: 'edit_package',
      desc: '',
      args: [],
    );
  }

  /// `Delete package`
  String get delete_package {
    return Intl.message(
      'Delete package',
      name: 'delete_package',
      desc: '',
      args: [],
    );
  }

  /// `Package name`
  String get package_name {
    return Intl.message(
      'Package name',
      name: 'package_name',
      desc: '',
      args: [],
    );
  }

  /// `Package description`
  String get package_description {
    return Intl.message(
      'Package description',
      name: 'package_description',
      desc: '',
      args: [],
    );
  }

  /// `Add short description`
  String get add_short_description {
    return Intl.message(
      'Add short description',
      name: 'add_short_description',
      desc: '',
      args: [],
    );
  }

  /// `Total duration`
  String get total_duration {
    return Intl.message(
      'Total duration',
      name: 'total_duration',
      desc: '',
      args: [],
    );
  }

  /// `Custom pricing`
  String get custom_pricing {
    return Intl.message(
      'Custom pricing',
      name: 'custom_pricing',
      desc: '',
      args: [],
    );
  }

  /// `Percentage discount`
  String get percentage_discount {
    return Intl.message(
      'Percentage discount',
      name: 'percentage_discount',
      desc: '',
      args: [],
    );
  }

  /// `Free`
  String get free {
    return Intl.message(
      'Free',
      name: 'free',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get price {
    return Intl.message(
      'Price',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `Choose your price type and edit current price`
  String get choose_your_price_method_and_edit_current_price {
    return Intl.message(
      'Choose your price type and edit current price',
      name: 'choose_your_price_method_and_edit_current_price',
      desc: '',
      args: [],
    );
  }

  /// `Price type`
  String get price_type {
    return Intl.message(
      'Price type',
      name: 'price_type',
      desc: '',
      args: [],
    );
  }

  /// `Select price type`
  String get select_price_type {
    return Intl.message(
      'Select price type',
      name: 'select_price_type',
      desc: '',
      args: [],
    );
  }

  /// `Retail price`
  String get retail_price {
    return Intl.message(
      'Retail price',
      name: 'retail_price',
      desc: '',
      args: [],
    );
  }

  /// `Add discount`
  String get add_discount {
    return Intl.message(
      'Add discount',
      name: 'add_discount',
      desc: '',
      args: [],
    );
  }

  /// `Attach file(s)`
  String get attach_file {
    return Intl.message(
      'Attach file(s)',
      name: 'attach_file',
      desc: '',
      args: [],
    );
  }

  /// `Attach image(s) or video(s)`
  String get attach_image_or_video {
    return Intl.message(
      'Attach image(s) or video(s)',
      name: 'attach_image_or_video',
      desc: '',
      args: [],
    );
  }

  /// `Total price`
  String get total_price {
    return Intl.message(
      'Total price',
      name: 'total_price',
      desc: '',
      args: [],
    );
  }

  /// `Deactivated`
  String get deactivated {
    return Intl.message(
      'Deactivated',
      name: 'deactivated',
      desc: '',
      args: [],
    );
  }

  /// `Deactivate`
  String get deactivate {
    return Intl.message(
      'Deactivate',
      name: 'deactivate',
      desc: '',
      args: [],
    );
  }

  /// `Activate`
  String get activate {
    return Intl.message(
      'Activate',
      name: 'activate',
      desc: '',
      args: [],
    );
  }

  /// `Activated`
  String get activated {
    return Intl.message(
      'Activated',
      name: 'activated',
      desc: '',
      args: [],
    );
  }

  /// `Service sub-category`
  String get service_subcategory {
    return Intl.message(
      'Service sub-category',
      name: 'service_subcategory',
      desc: '',
      args: [],
    );
  }

  /// `Current sub-category`
  String get current_subcategory {
    return Intl.message(
      'Current sub-category',
      name: 'current_subcategory',
      desc: '',
      args: [],
    );
  }

  /// `Starting from`
  String get starting_from {
    return Intl.message(
      'Starting from',
      name: 'starting_from',
      desc: '',
      args: [],
    );
  }

  /// `Start from`
  String get start_from {
    return Intl.message(
      'Start from',
      name: 'start_from',
      desc: '',
      args: [],
    );
  }

  /// `Ending at`
  String get ending_at {
    return Intl.message(
      'Ending at',
      name: 'ending_at',
      desc: '',
      args: [],
    );
  }

  /// `End at`
  String get end_at {
    return Intl.message(
      'End at',
      name: 'end_at',
      desc: '',
      args: [],
    );
  }

  /// `Set this discount forever`
  String get set_this_discount_forever {
    return Intl.message(
      'Set this discount forever',
      name: 'set_this_discount_forever',
      desc: '',
      args: [],
    );
  }

  /// `You have to choose an option for service availability`
  String get you_have_to_choose_an_option_for_service_availability {
    return Intl.message(
      'You have to choose an option for service availability',
      name: 'you_have_to_choose_an_option_for_service_availability',
      desc: '',
      args: [],
    );
  }

  /// `Salon Location`
  String get salon_location {
    return Intl.message(
      'Salon Location',
      name: 'salon_location',
      desc: '',
      args: [],
    );
  }

  /// `here ============================`
  String get here {
    return Intl.message(
      'here ============================',
      name: 'here',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email or password`
  String get err_wrong_email_or_password {
    return Intl.message(
      'Invalid email or password',
      name: 'err_wrong_email_or_password',
      desc: '',
      args: [],
    );
  }

  /// `The account info are not valid`
  String get the_account_info_are_not_valid {
    return Intl.message(
      'The account info are not valid',
      name: 'the_account_info_are_not_valid',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email`
  String get err_wrong_email {
    return Intl.message(
      'Invalid email',
      name: 'err_wrong_email',
      desc: '',
      args: [],
    );
  }

  /// `User was not found`
  String get err_user_not_found {
    return Intl.message(
      'User was not found',
      name: 'err_user_not_found',
      desc: '',
      args: [],
    );
  }

  /// `User was disabled`
  String get err_user_disabled {
    return Intl.message(
      'User was disabled',
      name: 'err_user_disabled',
      desc: '',
      args: [],
    );
  }

  /// `Unexpected error happened`
  String get err_unexpected_error_happened {
    return Intl.message(
      'Unexpected error happened',
      name: 'err_unexpected_error_happened',
      desc: '',
      args: [],
    );
  }

  /// `Too many requests`
  String get err_too_many_requests {
    return Intl.message(
      'Too many requests',
      name: 'err_too_many_requests',
      desc: '',
      args: [],
    );
  }

  /// `Operation not allowed`
  String get err_operation_not_allowed {
    return Intl.message(
      'Operation not allowed',
      name: 'err_operation_not_allowed',
      desc: '',
      args: [],
    );
  }

  /// `Not valid email`
  String get err_valid_email {
    return Intl.message(
      'Not valid email',
      name: 'err_valid_email',
      desc: '',
      args: [],
    );
  }

  /// `This email is already in use`
  String get err_this_email_is_already_in_use {
    return Intl.message(
      'This email is already in use',
      name: 'err_this_email_is_already_in_use',
      desc: '',
      args: [],
    );
  }

  /// `Duplicated credential`
  String get err_duplicated_credential {
    return Intl.message(
      'Duplicated credential',
      name: 'err_duplicated_credential',
      desc: '',
      args: [],
    );
  }

  /// `Invalid credential`
  String get err_invalid_credential {
    return Intl.message(
      'Invalid credential',
      name: 'err_invalid_credential',
      desc: '',
      args: [],
    );
  }

  /// `Reciters`
  String get reciters {
    return Intl.message(
      'Reciters',
      name: 'reciters',
      desc: '',
      args: [],
    );
  }

  /// `Quran`
  String get quran {
    return Intl.message(
      'Quran',
      name: 'quran',
      desc: '',
      args: [],
    );
  }

  /// `Library`
  String get library {
    return Intl.message(
      'Library',
      name: 'library',
      desc: '',
      args: [],
    );
  }

  /// `Islamic Library`
  String get islamic_library {
    return Intl.message(
      'Islamic Library',
      name: 'islamic_library',
      desc: '',
      args: [],
    );
  }

  /// `Reciter`
  String get reciter {
    return Intl.message(
      'Reciter',
      name: 'reciter',
      desc: '',
      args: [],
    );
  }

  /// `Khatmat`
  String get khatmat {
    return Intl.message(
      'Khatmat',
      name: 'khatmat',
      desc: '',
      args: [],
    );
  }

  /// `Khatma`
  String get khatma {
    return Intl.message(
      'Khatma',
      name: 'khatma',
      desc: '',
      args: [],
    );
  }

  /// `Khatma Details`
  String get khatma_details {
    return Intl.message(
      'Khatma Details',
      name: 'khatma_details',
      desc: '',
      args: [],
    );
  }

  /// `By sheikh: {sheikh_name}`
  String by_sheikh(Object sheikh_name) {
    return Intl.message(
      'By sheikh: $sheikh_name',
      name: 'by_sheikh',
      desc: '',
      args: [sheikh_name],
    );
  }

  /// `{count,plural, =0{} =1{1 hour} other{{count} hours}}`
  String hours_count(num count) {
    return Intl.plural(
      count,
      zero: '',
      one: '1 hour',
      other: '$count hours',
      name: 'hours_count',
      desc: '',
      args: [count],
    );
  }

  /// `{count} h`
  String hours_count_short(Object count) {
    return Intl.message(
      '$count h',
      name: 'hours_count_short',
      desc: '',
      args: [count],
    );
  }

  /// `{count,plural, =0{} =1{1 minute} other{{count} minutes}}`
  String minutes_count(num count) {
    return Intl.plural(
      count,
      zero: '',
      one: '1 minute',
      other: '$count minutes',
      name: 'minutes_count',
      desc: '',
      args: [count],
    );
  }

  /// `{count} m`
  String minutes_count_short(Object count) {
    return Intl.message(
      '$count m',
      name: 'minutes_count_short',
      desc: '',
      args: [count],
    );
  }

  /// `{count,plural, =0{} =1{1 second} other{{count} seconds}}`
  String seconds_count(num count) {
    return Intl.plural(
      count,
      zero: '',
      one: '1 second',
      other: '$count seconds',
      name: 'seconds_count',
      desc: '',
      args: [count],
    );
  }

  /// `{count} s`
  String seconds_count_short(Object count) {
    return Intl.message(
      '$count s',
      name: 'seconds_count_short',
      desc: '',
      args: [count],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<Translations> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar', countryCode: 'EG'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<Translations> load(Locale locale) => Translations.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
