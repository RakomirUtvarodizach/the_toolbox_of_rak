import 'package:json_annotation/json_annotation.dart';
import 'package:toolbox/models/shopping_list_item.dart';
import '../shoppingFriend.dart';

part 'shoppingListProvider.g.dart';

@JsonSerializable()
class ShoppingListProvider {
  List<ShoppingListItem> localShoppingListItems;
  List<ShoppingFriend> shoppingFriends;
  List<String> recentItems;

  ShoppingListProvider(
      {this.localShoppingListItems, this.shoppingFriends, this.recentItems});

  factory ShoppingListProvider.fromJson(Map<String, dynamic> json) =>
      _$ShoppingListProviderFromJson(json);

  Map<String, dynamic> toJson() => _$ShoppingListProviderToJson(this);
}
