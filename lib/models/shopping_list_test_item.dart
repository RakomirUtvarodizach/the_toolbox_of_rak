class ShoppingListTestItem {
  String _item, _description;
  int _priority;

  ShoppingListTestItem(this._item, this._description, {int priority}) {
    this._priority = priority ?? 1;
  }

  String get getItem => _item;

  String get getDescription => _description;

  int get getPriority => _priority;

  set setItem(String item) => this._item = item;

  set setDescription(String description) => this._description = description;

  set setPriority(int priority) => this._priority = priority;

  //Convert a shopping list test item object into a Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['item'] = _item;
    map['description'] = _description;
    map['priority'] = _priority;

    return map;
  }

  //Extract a shopping list test item object from a Map object
  ShoppingListTestItem.fromMapObject(Map<String, dynamic> map) {
    this._item = map['item'];
    this._description = map['description'];
    this._priority = map['priority'];
  }
}
