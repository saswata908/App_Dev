import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_app/data/categories.dart';
import 'package:shopping_app/models/grocery_item.dart';
import 'package:shopping_app/widget/bridge.dart';
import 'package:shopping_app/widget/new_item.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<GroceryItem> _groceryItems = [];
  bool _isLoading = true;
  //late Future<List<GroceryItem>> _loadedItems;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadItem();
    //_loadedItems = _loadItem();
  }

  void _loadItem() async {
    //Future<List<GroceryItem>>
    final url = Uri.https(
      'flutter-prep-a6eeb-default-rtdb.firebaseio.com',
      'shopping-list.json',
    );

    // try {

    // } catch (error) {
    //   throw Exception()
    // }

    final response = await http.get(url);

    if (response.statusCode >= 400) {
      setState(() {
        _error = 'Failed to fetch data.Please try again later';
      });
      //throw Exception('Failed to fetch data.Please try again later');
    }

    if (response.body == 'null') {
      setState(() {
        _isLoading = false;
      });
      return;
      //return [];
    }

    final Map<String, dynamic> listdata = json.decode(response.body);
    final List<GroceryItem> loadedItems = [];
    for (final item in listdata.entries) {
      final category =
          categories.entries
              .firstWhere(
                (catItem) => catItem.value.itemName == item.value['category'],
              )
              .value;
      loadedItems.add(
        GroceryItem(
          id: item.key,
          name: item.value['name'],
          quantity: item.value['quantity'],
          category: category,
        ),
      );
    }
    setState(() {
      _groceryItems = loadedItems;
      _isLoading = false;
    });
    //return loadedItems;
  }

  void _addItem() async {
    final newItem = await Navigator.of(
      context,
    ).push<GroceryItem>(MaterialPageRoute(builder: (ctx) => const NewItem()));
    if (newItem == null) {
      return;
    }
    setState(() {
      _groceryItems.add(newItem);
    });
  }

  void _removeItem(GroceryItem grocery) async {
    final index = _groceryItems.indexOf(grocery);
    setState(() {
      _groceryItems.remove(grocery);
    });
    final url = Uri.https(
      'flutter-prep-a6eeb-default-rtdb.firebaseio.com',
      'shopping-list/${grocery.id}.json',
    );
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      setState(() {
        _groceryItems.insert(index, grocery);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = Center(
      child: Text(
        'No items found. Start adding items',
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
          color: Theme.of(context).colorScheme.onBackground,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    if (_isLoading) {
      mainContent = const Center(child: CircularProgressIndicator());
    }

    if (_groceryItems.isNotEmpty) {
      mainContent = Bridge(
        groceryitems: _groceryItems,
        onRemoveItem: _removeItem,
      );
    }

    if (_error != null) {
      mainContent = Center(
        child: Text(
          _error!,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Theme.of(context).colorScheme.onBackground,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Groceries',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [IconButton(onPressed: _addItem, icon: const Icon(Icons.add))],
      ),

      body: mainContent,

      // body: FutureBuilder(
      //   future: _loadedItems,
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return const Center(child: CircularProgressIndicator());
      //     }

      //     if (snapshot.hasError) {
      //       return Center(
      //         child: Text(
      //           snapshot.error.toString(),
      //           style: Theme.of(context).textTheme.bodyLarge!.copyWith(
      //             color: Theme.of(context).colorScheme.onBackground,
      //             fontWeight: FontWeight.bold,
      //           ),
      //         ),
      //       );
      //     }

      //     if (snapshot.data!.isEmpty) {
      //       Center(
      //         child: Text(
      //           'No items found. Start adding items',
      //           style: Theme.of(context).textTheme.bodyLarge!.copyWith(
      //             color: Theme.of(context).colorScheme.onBackground,
      //             fontWeight: FontWeight.bold,
      //           ),
      //         ),
      //       );
      //     }

      //     return Bridge(
      //       groceryitems: snapshot.data!,
      //       onRemoveItem: _removeItem,
      //     );
      //   },
      // ),
    );
  }
}
