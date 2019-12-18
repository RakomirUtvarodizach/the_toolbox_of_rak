import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:toolbox/models/shopping_list_item.dart';
import '../shoppingFriend.dart';

part 'shoppingListProvider.g.dart';

@JsonSerializable(anyMap: true)
class ShoppingListProvider {
  List<ShoppingListItem> localShoppingListItems;
  List<ShoppingFriend> shoppingFriends;
  List<String> recentItems;

  @JsonKey(ignore: true)
  List<ShoppingListItem> itemsBeingEdited;

  @JsonKey(ignore: true)
  bool editing;

  // @JsonKey(ignore: true)
  // bool isThereANewItem;

  @JsonKey(ignore: true)
  ShoppingListItem newEditingItem;

  ShoppingListProvider(
      {this.localShoppingListItems,
      this.shoppingFriends,
      this.recentItems,
      this.itemsBeingEdited,
      this.editing: false,
      // this.isThereANewItem: false,
      this.newEditingItem}) {
    if (localShoppingListItems == null) {
      localShoppingListItems = List();
    }
    if (itemsBeingEdited == null) {
      itemsBeingEdited = List();
    }
  }

  factory ShoppingListProvider.fromJson(Map<String, dynamic> json) =>
      _$ShoppingListProviderFromJson(json);

  Map<String, dynamic> toJson() => _$ShoppingListProviderToJson(this);

  void updateRecentItems(String newItem) {
    if (recentItems == null) {
      List<String> sl = [];
      sl.add(newItem);
      recentItems = sl;
      return;
    }
    for (int i = 0; i < recentItems.length; i++) {
      if (recentItems[i] == newItem) {
        recentItems.removeAt(i);
        recentItems.add(newItem);
        return;
      }
    }
    if (recentItems.length > 10) {
      recentItems.removeLast();
    }
    recentItems.add(newItem);
  }
}
