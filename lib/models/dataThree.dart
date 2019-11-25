import 'package:json_annotation/json_annotation.dart';

part 'dataThree.g.dart';

@JsonSerializable()
class DataThree {
  String threeString;
  int threeInt;
  bool threeBool;
  List<String> listOfStringsInThree;

  DataThree(
      {this.threeString,
      this.threeInt,
      this.threeBool,
      this.listOfStringsInThree});

  factory DataThree.fromJson(Map<String, dynamic> json) =>
      _$DataThreeFromJson(json);

  Map<String, dynamic> toJson() => _$DataThreeToJson(this);

  String toString() {
    return "\n\tthreeString => $threeString\n\tthreeInt => $threeInt\n\tthreeBool => $threeBool\n\tlistOfStringsInThree => ${listOfStringsInThree.toString()}\n\n";
  }
}
