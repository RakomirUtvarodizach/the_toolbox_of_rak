// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dataTwo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataTwo _$DataTwoFromJson(Map<String, dynamic> json) {
  return DataTwo(
    twoString: json['twoString'] as String,
    twoBool: json['twoBool'] as bool,
    twoInt: json['twoInt'] as int,
    listOfTwosInThree: (json['listOfTwosInThree'] as List)
        ?.map((e) =>
            e == null ? null : DataThree.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$DataTwoToJson(DataTwo instance) => <String, dynamic>{
      'twoString': instance.twoString,
      'twoInt': instance.twoInt,
      'twoBool': instance.twoBool,
      'listOfTwosInThree': instance.listOfTwosInThree,
    };
