// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dataThree.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataThree _$DataThreeFromJson(Map<String, dynamic> json) {
  return DataThree(
    threeString: json['threeString'] as String,
    threeInt: json['threeInt'] as int,
    threeBool: json['threeBool'] as bool,
    listOfStringsInThree: (json['listOfStringsInThree'] as List)
        ?.map((e) => e as String)
        ?.toList(),
  );
}

Map<String, dynamic> _$DataThreeToJson(DataThree instance) => <String, dynamic>{
      'threeString': instance.threeString,
      'threeInt': instance.threeInt,
      'threeBool': instance.threeBool,
      'listOfStringsInThree': instance.listOfStringsInThree,
    };
