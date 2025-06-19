import 'package:flutter/material.dart';
import 'package:shopping_app/models/grocery_item.dart';

class Items extends StatelessWidget {
  const Items({super.key, required this.givenItem});
  final GroceryItem givenItem;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListTile(
        leading: Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(color: givenItem.category.itemColor),
        ),
        title: Text(givenItem.name),
        trailing: Text(
          givenItem.quantity.toString(),
          style: TextStyle(fontSize: 17),
        ),
      ),
      // Text(givenItem.name),
      // Spacer(),
      // Text(givenItem.quantity.toString()),
    );
  }
}
