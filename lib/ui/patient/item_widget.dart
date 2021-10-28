import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rehab_web/ui/data/datas.dart';

class ItemWidget extends StatelessWidget {
  final Item item;
  final Animation animation;
  final VoidCallback onClicked;

  const ItemWidget({
    @required this.item,
    @required this.animation,
    @required this.onClicked,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ScaleTransition(
        scale: animation,
        child: Container(
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(item.description, style: TextStyle(fontSize: 20)),
                if (item.value != null) Text(item.value, style: TextStyle(fontSize: 20)),
              ],
            ),
            trailing: IconButton(
              icon: Icon(Icons.remove_circle, color: Colors.red, size: 32),
              onPressed: onClicked,
            ),
          ),
        ),
      );
}
