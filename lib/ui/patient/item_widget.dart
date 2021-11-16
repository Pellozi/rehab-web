import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rehab_web/ui/controller/care_controller.dart';
import 'package:rehab_web/ui/data/datas.dart';

class ItemWidget extends StatelessWidget {
  final CareModel item;
  final Animation animation;
  final VoidCallback onClicked;
  final Function onTap;

  const ItemWidget({
    @required this.item,
    @required this.animation,
    @required this.onClicked,
    this.onTap,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: ScaleTransition(
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
                  Text(item.descricao, style: TextStyle(fontSize: 20)),
                  if (item.quantidade != null) Text(item.quantidade, style: TextStyle(fontSize: 20)),
                ],
              ),
              trailing: IconButton(
                icon: Icon(Icons.remove_circle, color: Colors.red, size: 32),
                onPressed: onClicked,
              ),
            ),
          ),
        ),
      );
}

class ItemExerciseWidget extends StatelessWidget {
  final CareExerciseModel item;
  final Animation animation;
  final VoidCallback onClicked;
  final Function onTap;

  const ItemExerciseWidget({
    @required this.item,
    @required this.animation,
    @required this.onClicked,
    this.onTap,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: ScaleTransition(
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
                  Text(item.descricao, style: TextStyle(fontSize: 20)),
                  if (item.quantidade != null) Text(item.quantidade, style: TextStyle(fontSize: 20)),
                ],
              ),
              trailing: IconButton(
                icon: Icon(Icons.remove_circle, color: Colors.red, size: 32),
                onPressed: onClicked,
              ),
            ),
          ),
        ),
      );
}
