import 'dataThree.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dataTwo.g.dart';

@JsonSerializable()
class DataTwo {
  String twoString;
  int twoInt;
  bool twoBool;
  List<DataThree> listOfTwosInThree;

  DataTwo({this.twoString, this.twoBool, this.twoInt, this.listOfTwosInThree});

  factory DataTwo.fromJson(Map<String, dynamic> json) =>
      _$DataTwoFromJson(json);

  Map<String, dynamic> toJson() => _$DataTwoToJson(this);
}
