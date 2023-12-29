// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ar_EG locale. All the
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
  String get localeName => 'ar_EG';

  static String m0(sheikh_name) => "للقارئ الشيخ: ${sheikh_name}";

  static String m1(int count) =>
      "${Intl.plural(count, zero: '', one: '1 ساعة', other: '${count} ساعات')}";

  static String m2(count) => "${count} س";

  static String m3(int count) =>
      "${Intl.plural(count, zero: '', one: '1 دقيقة', other: '${count} دقائق')}";

  static String m4(count) => "${count} د";

  static String m5(int count) =>
      "${Intl.plural(count, zero: '', one: '1 ثانية', other: '${count} ثواني')}";

  static String m6(count) => "${count} ث";

  static String m7(minLength) =>
      "يجب ألا يقل طول هذا الحقل عن ${minLength} حرفًا";

  final messages = _notInlinedMessages(_notInlinedMessages);

  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "activate": MessageLookupByLibrary.simpleMessage("تفيل"),
        "activated": MessageLookupByLibrary.simpleMessage("مفعلة"),
        "add": MessageLookupByLibrary.simpleMessage("أضف"),
        "add_another_phone_number":
            MessageLookupByLibrary.simpleMessage("أضف رقم هاتف آخر"),
        "add_category": MessageLookupByLibrary.simpleMessage("إضافة فئة"),
        "add_discount": MessageLookupByLibrary.simpleMessage("Add discount"),
        "add_new_service":
            MessageLookupByLibrary.simpleMessage("اضافة خدمة جديدة"),
        "add_package": MessageLookupByLibrary.simpleMessage("اضافة باقة"),
        "add_short_description":
            MessageLookupByLibrary.simpleMessage("Add short description"),
        "add_staff_member": MessageLookupByLibrary.simpleMessage("إضافة موظف"),
        "add_tag": MessageLookupByLibrary.simpleMessage("إضافة فئة"),
        "added_successfully":
            MessageLookupByLibrary.simpleMessage("تمت الاضافة بنجاح"),
        "address1": MessageLookupByLibrary.simpleMessage("العنوان 1"),
        "address1_notes": MessageLookupByLibrary.simpleMessage(
            "المنطقة ، المبنى ، الكتلة ، رقم المنزل ، اسم الشركة ، إلخ"),
        "address2": MessageLookupByLibrary.simpleMessage("العنوان 2"),
        "address2_notes": MessageLookupByLibrary.simpleMessage(
            "المعالم القريبة ، أو المباني أو الأماكن المعروفة ، وما إلى ذلك"),
        "are_you_sure_to_continue":
            MessageLookupByLibrary.simpleMessage("هل أنت متأكد من المتابعة؟"),
        "assign_services_to_your_package": MessageLookupByLibrary.simpleMessage(
            "Assign services to your package"),
        "attach_file": MessageLookupByLibrary.simpleMessage("Attach file(s)"),
        "attach_image_or_video":
            MessageLookupByLibrary.simpleMessage("قم باضافة صورة او فيديو"),
        "b": MessageLookupByLibrary.simpleMessage("B"),
        "barber": MessageLookupByLibrary.simpleMessage("حلاق"),
        "brief": MessageLookupByLibrary.simpleMessage("موجز"),
        "busy": MessageLookupByLibrary.simpleMessage("مشغول"),
        "by": MessageLookupByLibrary.simpleMessage("من قبل"),
        "by_sheikh": m0,
        "calendar": MessageLookupByLibrary.simpleMessage("التقويم"),
        "cancel": MessageLookupByLibrary.simpleMessage("إلفاء"),
        "catalog": MessageLookupByLibrary.simpleMessage("قائمة"),
        "categories": MessageLookupByLibrary.simpleMessage("الفئات"),
        "change_language": MessageLookupByLibrary.simpleMessage("تغير اللغة"),
        "change_password":
            MessageLookupByLibrary.simpleMessage("تغيير كلمة المرور"),
        "children": MessageLookupByLibrary.simpleMessage("أطفال"),
        "choose_your_price_method_and_edit_current_price":
            MessageLookupByLibrary.simpleMessage(
                "Choose your price method and edit current price"),
        "city": MessageLookupByLibrary.simpleMessage("المدينة"),
        "clients": MessageLookupByLibrary.simpleMessage("الزبائن"),
        "confirm": MessageLookupByLibrary.simpleMessage("تأكيد"),
        "confirm_new_password":
            MessageLookupByLibrary.simpleMessage("تأكيد كلمة المرور الجديدة"),
        "confirm_password":
            MessageLookupByLibrary.simpleMessage("تأكيد كلمة المرور"),
        "connection_error":
            MessageLookupByLibrary.simpleMessage("حصل خطأ بالاتسال"),
        "contact_info": MessageLookupByLibrary.simpleMessage("معلومات الاتصال"),
        "country": MessageLookupByLibrary.simpleMessage("الدولة"),
        "country_code": MessageLookupByLibrary.simpleMessage("الرمز الدولي"),
        "current_category":
            MessageLookupByLibrary.simpleMessage("الفئة الحالية"),
        "current_password":
            MessageLookupByLibrary.simpleMessage("كلمة المرور الحالية"),
        "current_subcategory":
            MessageLookupByLibrary.simpleMessage("Current sub-category"),
        "custom_pricing":
            MessageLookupByLibrary.simpleMessage("Custom pricing"),
        "dark_mode": MessageLookupByLibrary.simpleMessage("الوضع المظلم"),
        "deactivate": MessageLookupByLibrary.simpleMessage("الغاء التفعيل"),
        "deactivated": MessageLookupByLibrary.simpleMessage("غير مفعل"),
        "delete": MessageLookupByLibrary.simpleMessage("حذف"),
        "delete_package": MessageLookupByLibrary.simpleMessage("حذف الباقة"),
        "delete_service": MessageLookupByLibrary.simpleMessage("حذف الخدمة"),
        "deleting": MessageLookupByLibrary.simpleMessage("جاري الحذف..."),
        "description": MessageLookupByLibrary.simpleMessage("وصف"),
        "dio_bad_request_error":
            MessageLookupByLibrary.simpleMessage("طلب غير صالح للخادم!"),
        "dio_cancel_error":
            MessageLookupByLibrary.simpleMessage("تم إلغاء الطلب إلى الخادم"),
        "dio_connection_timeout_error":
            MessageLookupByLibrary.simpleMessage("انتهت مهلة الإتصال بالخادم"),
        "dio_not_found_error": MessageLookupByLibrary.simpleMessage(
            "لم يتم العثور على نقطة الاتصال"),
        "dio_receive_connection_timeout_error":
            MessageLookupByLibrary.simpleMessage(
                "انتهت مهلة الإستجابة بالخادم"),
        "dio_send_timeout_to_the_server":
            MessageLookupByLibrary.simpleMessage("انتهت مهلة الإرسال بالخادم"),
        "do_not_receive_code":
            MessageLookupByLibrary.simpleMessage("لم تتلقى الرمز؟"),
        "done": MessageLookupByLibrary.simpleMessage("تم"),
        "edit": MessageLookupByLibrary.simpleMessage("إضافة"),
        "edit_package": MessageLookupByLibrary.simpleMessage("تعديل الباقة"),
        "edit_service": MessageLookupByLibrary.simpleMessage("تعديل خدمة"),
        "edit_staff_member_info":
            MessageLookupByLibrary.simpleMessage("تعديل معلومات الموظف"),
        "edit_tag": MessageLookupByLibrary.simpleMessage("تعديل فئة"),
        "end_at": MessageLookupByLibrary.simpleMessage("End at"),
        "end_error_strings": MessageLookupByLibrary.simpleMessage(
            "========================================================"),
        "ending_at": MessageLookupByLibrary.simpleMessage("Ending at"),
        "enter_your_current_password":
            MessageLookupByLibrary.simpleMessage("أدخل كلمة المرور الحالية"),
        "enter_your_email":
            MessageLookupByLibrary.simpleMessage("أدخل بريدك الإلكتروني"),
        "enter_your_new_password":
            MessageLookupByLibrary.simpleMessage("اكتب كلمة المرور الجديدة"),
        "enter_your_password":
            MessageLookupByLibrary.simpleMessage("اكتب كلمة المرور الخاص بك"),
        "enter_your_password_again":
            MessageLookupByLibrary.simpleMessage("اكتب كلمة المرور مرة أخرى"),
        "enter_your_phone":
            MessageLookupByLibrary.simpleMessage("ادخل رقم الموبايل"),
        "enter_your_salon_brief":
            MessageLookupByLibrary.simpleMessage("أدخل موجز عملك"),
        "enter_your_salon_business_type":
            MessageLookupByLibrary.simpleMessage("أدخل نوع عملك"),
        "enter_your_salon_email": MessageLookupByLibrary.simpleMessage(
            "أدخل البريد الإلكتروني لعملك"),
        "enter_your_salon_name":
            MessageLookupByLibrary.simpleMessage("اكتب اسم الصالون الخاص بك"),
        "enter_your_salon_phone":
            MessageLookupByLibrary.simpleMessage("أكتب هاتف الصالون الخاص بك"),
        "enter_your_salon_website_url":
            MessageLookupByLibrary.simpleMessage("أدخل عنوان url لموقع عملك"),
        "enter_your_staff_member_name":
            MessageLookupByLibrary.simpleMessage("أدخل اسم الموظف الخاص بك"),
        "enter_your_user_name":
            MessageLookupByLibrary.simpleMessage("ادخل اسم المستخدم"),
        "enter_your_valid_url": MessageLookupByLibrary.simpleMessage(
            "أدخل عنوان url الخاص بك صالحً"),
        "err_duplicated_credential":
            MessageLookupByLibrary.simpleMessage("Duplicated credential"),
        "err_invalid_credential":
            MessageLookupByLibrary.simpleMessage("Invalid credential"),
        "err_operation_not_allowed":
            MessageLookupByLibrary.simpleMessage("العملية غير مسموح بها"),
        "err_this_email_is_already_in_use":
            MessageLookupByLibrary.simpleMessage(
                "هذا البريد الإلكتروني قيد الاستخدام بالفعل"),
        "err_too_many_requests":
            MessageLookupByLibrary.simpleMessage("طلبات كثيرة جدا"),
        "err_unexpected_error_happened":
            MessageLookupByLibrary.simpleMessage("حدث خطأ غير متوقع"),
        "err_user_disabled":
            MessageLookupByLibrary.simpleMessage("تم تعطيل المستخدم"),
        "err_user_not_found":
            MessageLookupByLibrary.simpleMessage("لم يتم العثور على المستخدم"),
        "err_valid_email":
            MessageLookupByLibrary.simpleMessage("البريد الإلكتروني غير صالح"),
        "err_wrong_email":
            MessageLookupByLibrary.simpleMessage("البريد الالكتروني غير صالح"),
        "err_wrong_email_or_password": MessageLookupByLibrary.simpleMessage(
            "البريد الالكتروني او كلمة المرور غير صالحة "),
        "error": MessageLookupByLibrary.simpleMessage("خطأ"),
        "error_internal_server":
            MessageLookupByLibrary.simpleMessage("حصل خطأ في الخادم الداخلي"),
        "error_unexpected":
            MessageLookupByLibrary.simpleMessage("حصل خطأ غير متوقع"),
        "facebook": MessageLookupByLibrary.simpleMessage("فيسبوك"),
        "forgot_password":
            MessageLookupByLibrary.simpleMessage("نسيت كلمة المرور"),
        "forgot_password_":
            MessageLookupByLibrary.simpleMessage("نسيت كلمة المرور؟"),
        "free": MessageLookupByLibrary.simpleMessage("Free"),
        "gallery": MessageLookupByLibrary.simpleMessage("المعرض"),
        "hairdresser": MessageLookupByLibrary.simpleMessage("كُوافِير"),
        "here": MessageLookupByLibrary.simpleMessage(
            "here ============================"),
        "home": MessageLookupByLibrary.simpleMessage("رئيسي"),
        "hours_count": m1,
        "hours_count_short": m2,
        "instagram": MessageLookupByLibrary.simpleMessage("انستغرام"),
        "islamic_library":
            MessageLookupByLibrary.simpleMessage("المكتبة الاسلامية"),
        "k": MessageLookupByLibrary.simpleMessage("K"),
        "khatma": MessageLookupByLibrary.simpleMessage("ختمة"),
        "khatma_details": MessageLookupByLibrary.simpleMessage("تفاصيل الختمة"),
        "khatmat": MessageLookupByLibrary.simpleMessage("ختمات"),
        "kids": MessageLookupByLibrary.simpleMessage("أطفال"),
        "language": MessageLookupByLibrary.simpleMessage("اللغة"),
        "languages": MessageLookupByLibrary.simpleMessage("اللغات"),
        "later": MessageLookupByLibrary.simpleMessage("لاحقاً"),
        "library": MessageLookupByLibrary.simpleMessage("المكتبة"),
        "links": MessageLookupByLibrary.simpleMessage("الروابط"),
        "location": MessageLookupByLibrary.simpleMessage("الموقع"),
        "log_in": MessageLookupByLibrary.simpleMessage("تسجيل الدخول"),
        "log_out": MessageLookupByLibrary.simpleMessage("تسجيل الخروج"),
        "logout_message": MessageLookupByLibrary.simpleMessage(
            "هل أنت متأكد أنك تريد تسجيل الخروج؟"),
        "m": MessageLookupByLibrary.simpleMessage("M"),
        "main_business_type":
            MessageLookupByLibrary.simpleMessage("نوع العمل الرئيسي"),
        "main_info": MessageLookupByLibrary.simpleMessage("المعلومات الرئيسية"),
        "men": MessageLookupByLibrary.simpleMessage("رجال"),
        "minutes_count": m3,
        "minutes_count_short": m4,
        "more": MessageLookupByLibrary.simpleMessage("المزيد"),
        "name": MessageLookupByLibrary.simpleMessage("الاسم"),
        "new_account": MessageLookupByLibrary.simpleMessage("حساب جديد"),
        "new_password":
            MessageLookupByLibrary.simpleMessage("كلمة المرور الجديدة"),
        "new_service": MessageLookupByLibrary.simpleMessage("اضافة خدمة"),
        "not_set": MessageLookupByLibrary.simpleMessage("Not set"),
        "notifications": MessageLookupByLibrary.simpleMessage("الإشعارات"),
        "notifications_settings":
            MessageLookupByLibrary.simpleMessage("إعدادات الإشعارات"),
        "off": MessageLookupByLibrary.simpleMessage("Off"),
        "offer": MessageLookupByLibrary.simpleMessage("عرض"),
        "offers": MessageLookupByLibrary.simpleMessage("عروض"),
        "open_now": MessageLookupByLibrary.simpleMessage("مفتوح الان"),
        "opening_hours": MessageLookupByLibrary.simpleMessage("ساعات العمل"),
        "options": MessageLookupByLibrary.simpleMessage("الخيارات"),
        "package_description":
            MessageLookupByLibrary.simpleMessage("تفاصيل الباقة"),
        "package_name": MessageLookupByLibrary.simpleMessage("اسم الباقة"),
        "package_services":
            MessageLookupByLibrary.simpleMessage("Package Services"),
        "packages": MessageLookupByLibrary.simpleMessage("الحزم"),
        "password": MessageLookupByLibrary.simpleMessage("كلمة المرور"),
        "percentage_discount":
            MessageLookupByLibrary.simpleMessage("Percentage discount"),
        "phone_number": MessageLookupByLibrary.simpleMessage("رقم الهاتف"),
        "phone_number_verification":
            MessageLookupByLibrary.simpleMessage("التحقق من رقم الهاتف"),
        "price": MessageLookupByLibrary.simpleMessage("Price"),
        "price_type": MessageLookupByLibrary.simpleMessage("Price type"),
        "processing": MessageLookupByLibrary.simpleMessage("جاري المعالجة"),
        "quran": MessageLookupByLibrary.simpleMessage("القران"),
        "rating": MessageLookupByLibrary.simpleMessage("تقييم"),
        "ratings": MessageLookupByLibrary.simpleMessage("التقييمات"),
        "read_less": MessageLookupByLibrary.simpleMessage("أقرأ أقل"),
        "read_more": MessageLookupByLibrary.simpleMessage("قراءة المزيد"),
        "reciter": MessageLookupByLibrary.simpleMessage("القارئ"),
        "reciters": MessageLookupByLibrary.simpleMessage("القرًاء"),
        "remember_me": MessageLookupByLibrary.simpleMessage("تذكر هذا الخيار"),
        "resend": MessageLookupByLibrary.simpleMessage("إعادة إرسال"),
        "reset": MessageLookupByLibrary.simpleMessage("إعادة الضبط"),
        "reset_password":
            MessageLookupByLibrary.simpleMessage("إعادة تعيين كلمة المرور"),
        "retail_price": MessageLookupByLibrary.simpleMessage("Retail price"),
        "retry": MessageLookupByLibrary.simpleMessage("إعادة المحاولة"),
        "retype_your_new_password": MessageLookupByLibrary.simpleMessage(
            "أعد كتابة كلمة المرور الجديدة"),
        "review": MessageLookupByLibrary.simpleMessage("تقيم"),
        "reviews": MessageLookupByLibrary.simpleMessage("تقيمات"),
        "s": MessageLookupByLibrary.simpleMessage("S"),
        "salon_customers": MessageLookupByLibrary.simpleMessage("عملائك"),
        "salon_customers_from":
            MessageLookupByLibrary.simpleMessage("عملائك من"),
        "salon_email": MessageLookupByLibrary.simpleMessage("بريد العمل"),
        "salon_info": MessageLookupByLibrary.simpleMessage("معلومات الصالون"),
        "salon_location":
            MessageLookupByLibrary.simpleMessage("Salon Location"),
        "salon_name": MessageLookupByLibrary.simpleMessage("اسم الصالون"),
        "salon_phone": MessageLookupByLibrary.simpleMessage("هاتف الصالون"),
        "save": MessageLookupByLibrary.simpleMessage("حفظ"),
        "search": MessageLookupByLibrary.simpleMessage("ابحث"),
        "search_by_location_or_code": MessageLookupByLibrary.simpleMessage(
            "البحث بالموقع أو الرمز الدولي"),
        "seconds_count": m5,
        "seconds_count_short": m6,
        "select_another_service":
            MessageLookupByLibrary.simpleMessage("Select another service(s)"),
        "select_duration": MessageLookupByLibrary.simpleMessage("اختر الوقت"),
        "select_one": MessageLookupByLibrary.simpleMessage("اختر واحدة"),
        "select_price_type":
            MessageLookupByLibrary.simpleMessage("Select price type"),
        "select_service":
            MessageLookupByLibrary.simpleMessage("Select service"),
        "select_service_s":
            MessageLookupByLibrary.simpleMessage("اختر خدم(ة/ات)"),
        "service": MessageLookupByLibrary.simpleMessage("خدمة"),
        "service_available_for":
            MessageLookupByLibrary.simpleMessage("Service available for"),
        "service_category": MessageLookupByLibrary.simpleMessage("فئة الخدمة"),
        "service_color": MessageLookupByLibrary.simpleMessage("لون الخدمة"),
        "service_description":
            MessageLookupByLibrary.simpleMessage("وصف الخدمة"),
        "service_discount": MessageLookupByLibrary.simpleMessage("خصم الخدمة"),
        "service_duration": MessageLookupByLibrary.simpleMessage("وقت الخدمة"),
        "service_name": MessageLookupByLibrary.simpleMessage("اسم الخدمة"),
        "service_price": MessageLookupByLibrary.simpleMessage("سعر الخدمة"),
        "service_pricing":
            MessageLookupByLibrary.simpleMessage("Service pricing"),
        "service_subcategory":
            MessageLookupByLibrary.simpleMessage("Service sub-category"),
        "services": MessageLookupByLibrary.simpleMessage("خدمات"),
        "set_this_discount_forever":
            MessageLookupByLibrary.simpleMessage("Set this discount forever"),
        "settings": MessageLookupByLibrary.simpleMessage("الإعدادات"),
        "sign_up": MessageLookupByLibrary.simpleMessage("تسجيل حساب"),
        "size": MessageLookupByLibrary.simpleMessage("الحجم"),
        "social":
            MessageLookupByLibrary.simpleMessage("وسائل التواصل الاجتماعي"),
        "something_went_wrong_check_connection":
            MessageLookupByLibrary.simpleMessage(
                "حدث خطأ ما ، يرجى التحقق من اتصالك بالإنترنت والمحاولة مرة أخرى"),
        "something_went_wrong_please_try_again":
            MessageLookupByLibrary.simpleMessage(
                "حدث خطأ ما.\nأعد المحاولة من فضلك."),
        "spa": MessageLookupByLibrary.simpleMessage("منتجع صحي"),
        "staff": MessageLookupByLibrary.simpleMessage("طاقم عمل"),
        "start": MessageLookupByLibrary.simpleMessage("ابدأ"),
        "start_error_strings": MessageLookupByLibrary.simpleMessage(
            "=============== Start Error Strings =================="),
        "statistics": MessageLookupByLibrary.simpleMessage("الإحصائيات"),
        "stay_tuned": MessageLookupByLibrary.simpleMessage("ابقى متيقظا"),
        "street": MessageLookupByLibrary.simpleMessage("شارع"),
        "stylist": MessageLookupByLibrary.simpleMessage("Stylist"),
        "submit": MessageLookupByLibrary.simpleMessage("إرسال"),
        "tag_color": MessageLookupByLibrary.simpleMessage("لون الفئة"),
        "tag_description": MessageLookupByLibrary.simpleMessage("تفاصيل الفئة"),
        "tag_name": MessageLookupByLibrary.simpleMessage("اسم الفئة"),
        "tags": MessageLookupByLibrary.simpleMessage("tags"),
        "tap_again_to_eit":
            MessageLookupByLibrary.simpleMessage("اضغط مجدداً للخروج!"),
        "tap_to_pick_salon_location_on_the_map":
            MessageLookupByLibrary.simpleMessage(
                "انقر لتحديد موقعك على الخريطة"),
        "tiktok": MessageLookupByLibrary.simpleMessage("تيك توك"),
        "time_bought": MessageLookupByLibrary.simpleMessage("اشترى مرة"),
        "times_bought": MessageLookupByLibrary.simpleMessage("اشترى مرات"),
        "total_duration": MessageLookupByLibrary.simpleMessage("المدة الكلية"),
        "total_price": MessageLookupByLibrary.simpleMessage("السعر الكلي"),
        "try_again": MessageLookupByLibrary.simpleMessage("أعد المحاولة"),
        "twitter": MessageLookupByLibrary.simpleMessage("تويتر"),
        "type_the_verification_code_we_have_sent_you":
            MessageLookupByLibrary.simpleMessage(
                "اكتب رمز التحقق الذي تم إرساله لك"),
        "un_authorized_error":
            MessageLookupByLibrary.simpleMessage("غير مصرح لتنفيذ العملية"),
        "unknown_error":
            MessageLookupByLibrary.simpleMessage("حصل خطأ غير معروف"),
        "unknown_size": MessageLookupByLibrary.simpleMessage("حجم غير معروف"),
        "update": MessageLookupByLibrary.simpleMessage("تحديث"),
        "updated_successfully":
            MessageLookupByLibrary.simpleMessage("تمت التعديل بنجاح"),
        "url": MessageLookupByLibrary.simpleMessage("عنوان Url"),
        "user_cancel_error":
            MessageLookupByLibrary.simpleMessage("تم الإلغاء من قبل المستخدم"),
        "user_email": MessageLookupByLibrary.simpleMessage("البريد الالكتروني"),
        "user_name": MessageLookupByLibrary.simpleMessage("اسم المستخدم"),
        "validator_invalid_email":
            MessageLookupByLibrary.simpleMessage("بريد إلكتروني غير صحيح!"),
        "validator_it_does_not_match":
            MessageLookupByLibrary.simpleMessage("غير متطابق"),
        "validator_should_be_with_minimum_length_of_characters": m7,
        "validator_this_field_is_required":
            MessageLookupByLibrary.simpleMessage("هذه الحقل مطلوب"),
        "verify": MessageLookupByLibrary.simpleMessage("تحقق"),
        "we_will_send_your_4_digit_verification_code_to":
            MessageLookupByLibrary.simpleMessage(
                "سيتم إرسال رمز التحقق المكون من 4 أرقام إلى"),
        "website": MessageLookupByLibrary.simpleMessage("الموقع الكتروني"),
        "whoops": MessageLookupByLibrary.simpleMessage("Whoops!"),
        "whoops_info": MessageLookupByLibrary.simpleMessage("اوووبس"),
        "women": MessageLookupByLibrary.simpleMessage("نساء"),
        "working_hours": MessageLookupByLibrary.simpleMessage("ساعات العمل"),
        "you_have_to_choose_an_option_for_service_availability":
            MessageLookupByLibrary.simpleMessage(
                "You have to choose an option for service availability"),
        "your_new_password": MessageLookupByLibrary.simpleMessage(
            "كلمة المرور الجديدة الخاصة بك")
      };
}
