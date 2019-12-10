import 'package:flutter/material.dart';
import 'package:toolbox/etc/icons.dart';
import 'package:toolbox/models/shopping_list_item.dart';
import 'package:toolbox/screens/widgets/sharedWidgets/customExpandingListTile.dart';
import 'package:toolbox/etc/styles.dart';

class ListItemWidget extends StatefulWidget {
  final AssetImage image;
  final String name, email, colorType, radiusType;
  final int notificationCount, listItemType;
  final Color notificationBubbleColor, notificationCountColor;
  final Function onTap;
  final ShoppingListItem sli;

  ListItemWidget(
      {this.listItemType = 0,
      this.image,
      this.name = "Dummy Dumming",
      this.email = "dummydumming@gmail.com",
      this.colorType: "green",
      this.radiusType: "tr",
      this.notificationCount = 0,
      this.notificationBubbleColor = Colors.deepPurple,
      this.notificationCountColor = Colors.white,
      this.onTap,
      this.sli});

  @override
  _ListItemWidgetState createState() => _ListItemWidgetState();
}

class _ListItemWidgetState extends State<ListItemWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.listItemType == 0) {
      return Card(
        color: Colors.white,
        elevation: 8.0,
        shape: CircleBorder(
          side: BorderSide(color: Colors.transparent),
        ),
        child: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 20.0),
              decoration: BoxDecoration(
                border: Border.all(width: 3.5, color: Colors.black87),
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: this.widget.image ??
                      AssetImage(
                        'images/rolph.jpg',
                      ),
                ),
              ),
            ),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(width: 3.0, color: Colors.black),
                    bottom: BorderSide(width: 1.0, color: Colors.black),
                    right: BorderSide(width: 1.0, color: Colors.black),
                    left: BorderSide(width: 1.0, color: Colors.black),
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Flexible(
                          child: Padding(
                            padding: EdgeInsets.only(left: 2.0),
                            child: Text(
                              this.widget.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                        )
                      ],
                    ),
                    Divider(
                      thickness: 2.0,
                    ),
                    Row(
                      children: <Widget>[
                        Flexible(
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 2.0, left: 3.0),
                            child: Text(
                              this.widget.email,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            _shouldIShowNotificationBubble(),
            Positioned(
              left: 0.0,
              right: 0.0,
              top: 0.0,
              bottom: 0.0,
              child: Container(
                color: Colors.transparent,
                child: InkWell(
                  highlightColor: AccentColor,
                  onTap: this.widget.onTap ??
                      () {
                        debugPrint("Ink is, well, clicked.");
                      },
                ),
              ),
            )
          ],
        ),
      );
    } else if (widget.listItemType == 1 && widget.sli != null) {
      return CustomExpandingListTile(
        borderGradient: typeOneGradient(),
        borderRadius: typeOneRadius(),
        leading: Container(
          padding: EdgeInsets.only(right: 12.0),
          decoration: new BoxDecoration(
            border: new Border(
              right: new BorderSide(width: 1.0, color: Colors.white24),
            ),
          ),
          child: Icon(
            _manageSliType(widget.sli.type),
            color: Colors.white.withOpacity(0.65),
          ),
        ),
        title: Column(
          children: <Widget>[
            Text(
              widget.sli.title,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: MediumTextSize),
            ),
            Row(
              children: <Widget>[
                Icon(
                  Icons.traffic,
                  color: _manageSliPriorityColor(widget.sli.priority),
                ),
                SizedBox(
                  width: 4.0,
                ),
                Text(
                  "Priority:  " + _manageSliPriorityName(widget.sli.priority),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: BodyTextSize,
                  ),
                ),
              ],
            ),
          ],
        ),
        children: <Widget>[
          Divider(
            color: Colors.white,
          ),
          Container(
            margin: EdgeInsets.only(bottom: 8.0),
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              widget.sli.description,
              style: TextStyle(
                color: Colors.white,
                fontSize: BodyTextSize,
              ),
            ),
          ),
        ],
      );
    } else if (widget.listItemType == 2 && widget.sli != null) {
      return Card(
        elevation: 8.0,
        shape: RoundedRectangleBorder(
          borderRadius: typeOneRadius(),
        ),
        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.blueGrey.withOpacity(0.6),
                  offset: Offset(1.11, 4.0),
                  blurRadius: 8.0),
            ],
            gradient: typeOneGradient(),
            borderRadius: typeOneRadius(),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              customBorder: RoundedRectangleBorder(
                borderRadius: typeOneRadius(),
              ),
              splashColor: AccentColor400.withOpacity(0.2),
              onTap: () {
                debugPrint("InkWell from LIST ITEM TYPE 2 tapped");
              },
              child: ListTile(
                leading: Container(
                  padding: EdgeInsets.only(right: 12.0),
                  decoration: new BoxDecoration(
                    border: new Border(
                      right: new BorderSide(width: 1.0, color: Colors.white24),
                    ),
                  ),
                  child: Icon(
                    _manageSliType(widget.sli.type),
                    color: Colors.white.withOpacity(0.65),
                  ),
                ),
                title: Column(
                  children: <Widget>[
                    Text(
                      widget.sli.title,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: MediumTextSize),
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.traffic,
                          color: _manageSliPriorityColor(widget.sli.priority),
                        ),
                        SizedBox(
                          width: 4.0,
                        ),
                        Text(
                          "Priority:  " +
                              _manageSliPriorityName(widget.sli.priority),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: BodyTextSize,
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 8.0),
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        widget.sli.description,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: BodyTextSize,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      return Card(
        elevation: 8.0,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
          decoration: BoxDecoration(
            border: Border.all(
              width: 3.0,
              color: Colors.black,
            ),
            gradient: LinearGradient(
              colors: [Colors.yellow, Colors.blue, Colors.green],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
          child: SizedBox(
            height: 50.0,
            child: Center(
              child: Text(
                "Sorry there are no list item designs that match your requirements :(",
                textAlign: TextAlign.center,
                style: TextStyle(
                    wordSpacing: 0.4,
                    fontSize: 20.0,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
      );
    }
  }

  Widget _shouldIShowNotificationBubble() {
    if (widget.notificationCount > 0) {
      return Positioned(
        top: 3.0,
        left: 3.0,
        child: Container(
          padding:
              EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0, bottom: 5.0),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black54,
                offset: Offset(-2.0, 2.0),
              )
            ],
            color: ComplementaryColor500,
            borderRadius: BorderRadius.circular(50.0),
          ),
          child: Text(
            this.widget.notificationCount.toString(),
            style:
                TextStyle(color: Colors.white, fontSize: LowerMediumTextSize),
          ),
        ),
      );
    } else {
      return SizedBox();
    }
  }

  Color _manageSliPriorityColor(int priority) {
    if (priority == 1) {
      return Colors.green[700];
    } else if (priority == 2) {
      return Colors.yellow[700];
    } else if (priority == 3) {
      return Colors.red[700];
    } else {
      return Colors.black;
    }
  }

  String _manageSliPriorityName(int priority) {
    if (priority == 1) {
      return "Low";
    } else if (priority == 2) {
      return "Medium";
    } else if (priority == 3) {
      return "High";
    } else {
      return "Unknown";
    }
  }

  IconData _manageSliType(String type) {
    if (type == "Food") {
      return CustomIcons.food;
    } else if (type == "Chemicals") {
      return CustomIcons.beaker;
    } else if (type == "Cosmetics") {
      return Icons.bubble_chart;
    } else if (type == "Clothes") {
      return CustomIcons.shirt;
    } else {
      return Icons.cancel;
    }
  }

  BorderRadius typeOneRadius() {
    if (widget.radiusType == "tr") {
      return BorderRadius.only(
        bottomRight: Radius.circular(8.0),
        bottomLeft: Radius.circular(8.0),
        topLeft: Radius.circular(8.0),
        topRight: Radius.circular(54.0),
      );
    } else if (widget.radiusType == "bl") {
      return BorderRadius.only(
        bottomRight: Radius.circular(8.0),
        bottomLeft: Radius.circular(54.0),
        topLeft: Radius.circular(8.0),
        topRight: Radius.circular(8.0),
      );
    } else if (widget.radiusType == "br") {
      return BorderRadius.only(
        bottomRight: Radius.circular(54.0),
        bottomLeft: Radius.circular(8.0),
        topLeft: Radius.circular(8.0),
        topRight: Radius.circular(8.0),
      );
    } else if (widget.radiusType == "tl") {
      return BorderRadius.only(
        bottomRight: Radius.circular(8.0),
        bottomLeft: Radius.circular(8.0),
        topLeft: Radius.circular(54.0),
        topRight: Radius.circular(8.0),
      );
    } else {
      return BorderRadius.all(Radius.zero);
    }
  }

  Gradient typeOneGradient() {
    if (widget.colorType == "green") {
      return LinearGradient(
        colors: [DarkColor, NeutralColor],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else if (widget.colorType == "blue") {
      return LinearGradient(
        colors: [LightComplementaryColor600, LightComplementaryColor],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else if (widget.colorType == "green_comp") {
      return LinearGradient(
        colors: [DarkComplementaryColor, NeutralComplementaryColor],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else {
      return LinearGradient(
        colors: [DarkColor, NeutralColor],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    }
  }
}
