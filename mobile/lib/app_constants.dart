// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:salon_app/core/constants/constants.dart';
import 'package:salon_app/core/managers/localization/app_translation.dart';

///
/// This is a general enum used across the whole application.
/// Contains all possible gender on our earth up until now.
/// I think so *_* ...
enum Gender {
  @JsonValue(0)
  none,
  @JsonValue(1)
  male,
  @JsonValue(2)
  female,
  @JsonValue(3)
  other,
}

enum BookingStatus {
  @JsonValue(0)
  none,
  @JsonValue(1)
  new_,
  @JsonValue(2)
  approved,
  @JsonValue(3)
  rejected,
  @JsonValue(4)
  cancelledByClient,
  @JsonValue(5)
  cancelledBySalon,
  @JsonValue(6)
  completed,
  @JsonValue(7)
  rescheduled,
}

enum FileType { image, video, none }

enum SalonAvailability {
  openedNow,
  closesSoon,
  closedNow,
  opensSoon,
}

/*
  /// Backend Values
enum CategoryType
    {
        All = 1,
        Men ,
        Women,
        Kids

    }
 */
final customerList = CustomerTypeAttribute.values.sublist(0, 3);
final genderList = Gender.values.sublist(1, 4);
Map<int, String> customerLabelMap = {
  // 0: translate.all,
  0: translate.men,
  1: translate.women,
  2: translate.children,
  // 4: translate.not_set,
};
Map<int, String> genderLabelMap = {
  // 0: translate.all,
  1: translate.male,
  2: translate.female,
  3: translate.other,
  // 4: translate.not_set,
};

enum CustomerTypeAttribute {
  // all,
  @JsonValue(1)
  men,
  @JsonValue(2)
  women,
  @JsonValue(3)
  kids,
  @JsonValue(0)
  none

  // int toJson() {
  //   return index;
  // }

  // factory CustomerTypeAttribute.fromJson(int index) {
  //   return values[index];
  // }
  //
  // static int _toJson(CustomerTypeAttribute? type) =>
  //     (type?.index ?? CustomerTypeAttribute.none.index);

  // static CustomerTypeAttribute _fromJson(int? value) =>
  //     value != null ? values[value] : CustomerTypeAttribute.none;
  //
  // static List<int> toListJson(List<CustomerTypeAttribute?>? types) =>
  //     types?.map((e) => _toJson(e)).toList() ?? [];
  //
  // static List<CustomerTypeAttribute> fromListJson(List? days) =>
  //     days?.map((e) => _fromJson(e)).toList() ?? [];
}

/*
  /// Backend Values
    BusinessType
      {
          Barber = 1,
          Hairdresser,
          SPA
      }
 */

// final businessTypeList = [...BusinessType.values];
final businessTypeList = BusinessType.values.sublist(0, 3);

Map<int, String> businessTypeLabelMap = {
  // 0: translate.none,
  0: translate.barber,
  1: translate.hairdresser,
  2: translate.spa,
  // 4: translate.not_set,
};

enum BusinessType {
  @JsonValue(1)
  barber,
  @JsonValue(2)
  hairdresser,
  @JsonValue(3)
  spa,
  @JsonValue(0)
  none;

  static int toTypeJson(BusinessType? type) =>
      (type?.index ?? BusinessType.none.index) + 1;

  static BusinessType fromTypeJson(int? value) =>
      value != null ? values[value - 1] : BusinessType.none;
}

/*
  /// Backend Values
WorkingDayNumber
    {

        //
        // Summary:
        //     Indicates Sunday.
        Sunday = 0,
        //
        // Summary:
        //     Indicates Monday.
        Monday = 1,
        //
        // Summary:
        //     Indicates Tuesday.
        Tuesday = 2,
        //
        // Summary:
        //     Indicates Wednesday.
        Wednesday = 3,
        //
        // Summary:
        //     Indicates Thursday.
        Thursday = 4,
        //
        // Summary:
        //     Indicates Friday.
        Friday = 5,
        //
        // Summary:
        //     Indicates Saturday.
        Saturday = 6

}
 */
final workingDayNumberList = WorkingDayNumber.values.sublist(0, 7);

Map<int, String> workingDayNumberLabelMap = {
  0: translate.sunday,
  1: translate.monday,
  2: translate.tuesday,
  3: translate.wednesday,
  4: translate.thursday,
  5: translate.friday,
  6: translate.saturday,
  7: translate.none,
};

enum WorkingDayNumber {
  @JsonValue(0)
  sunday,
  @JsonValue(1)
  monday,
  @JsonValue(2)
  tuesday,
  @JsonValue(3)
  wednesday,
  @JsonValue(4)
  thursday,
  @JsonValue(5)
  friday,
  @JsonValue(6)
  saturday,
  @JsonValue(7)
  none;

  static int toDayJson(WorkingDayNumber? type) =>
      type?.index ?? WorkingDayNumber.sunday.index;

  static WorkingDayNumber fromDayJson(int? value) =>
      value != null ? values[value] : WorkingDayNumber.sunday;

  static List<int> toListJson(List<WorkingDayNumber?>? types) =>
      types?.map((e) => toDayJson(e)).toList() ?? [];

  static List<WorkingDayNumber> fromListJson(List<int?>? days) =>
      days?.map((e) => fromDayJson(e)).toList() ?? [];
}

const List<Color> defaultColors = [
  AppColors.appPrimaryColor,
  Colors.red,
  Colors.pink,
  Colors.purple,
  Colors.deepPurple,
  Colors.indigo,
  Colors.blue,
  Colors.lightBlue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.lightGreen,
  Colors.lime,
  Colors.yellow,
  Colors.amber,
  Colors.orange,
  Colors.deepOrange,
  Colors.brown,
  Colors.grey,
  Colors.blueGrey,
  Colors.black,
];

enum CodeVerificationType {
  @JsonValue(1)
  register,
  @JsonValue(2)
  changeEmail,
  @JsonValue(3)
  forgetPassword,
}
