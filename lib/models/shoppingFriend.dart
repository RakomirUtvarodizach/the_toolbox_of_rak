import 'package:json_annotation/json_annotation.dart';

part 'shoppingFriend.g.dart';

@JsonSerializable()
class ShoppingFriend {
  String friendName;
  int numberOfChanges;

  ShoppingFriend({this.friendName, this.numberOfChanges});

  factory ShoppingFriend.fromJson(Map<String, dynamic> json) =>
      _$ShoppingFriendFromJson(json);

  Map<String, dynamic> toJson() => _$ShoppingFriendToJson(this);
}
