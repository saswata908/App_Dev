import 'package:flutter/material.dart';
import 'package:shopping_app/models/grocery_item.dart';
import 'package:shopping_app/widget/items.dart';

class Bridge extends StatelessWidget {
  const Bridge({
    super.key,
    required this.groceryitems,
    required this.onRemoveItem,
  });
  final List<GroceryItem> groceryitems;
  final void Function(GroceryItem grocery) onRemoveItem;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: groceryitems.length,
      itemBuilder:
          (context, index) => Dismissible(
            background: Container(
              color: Theme.of(context).colorScheme.error,
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            key: ValueKey(groceryitems[index]),
            onDismissed: (direction) {
              onRemoveItem(groceryitems[index]);
            },
            child: Items(givenItem: groceryitems[index]),
          ),
    );
  }
}
