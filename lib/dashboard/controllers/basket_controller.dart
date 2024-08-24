import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

// BasketController handles all the operations related to the user's basket,
// such as adding/removing items and fetching the basket contents.
class BasketController extends GetxController {
  // Reference to the Firestore instance.
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Reference to the 'users_baskets' collection in Firestore.
  CollectionReference get _basketCollection => _firestore.collection('users_baskets');

  // Reference to the 'items' collection in Firestore, where item details are stored.
  CollectionReference get _itemsCollection => _firestore.collection('items');

  // Adds an item to the user's basket in the 'users_baskets' collection.
  // The basket item is identified by the userId and itemId.
  Future<void> addItemToBasket(String userId, String itemId) async {
    try {
      // Adding a new document to the basket collection for the specified user and item.
      await _basketCollection.add({
        'userId': userId,
        'itemId': itemId,
      });
    } catch (e) {
      // Log an error if adding the item fails.
      print('Failed to add item: $e');
    }
  }

  // Removes an item from the user's basket by document ID.
  // This is used to remove a specific item entry from the basket.
  Future<void> removeItemFromBasket(String documentId) async {
    try {
      // Deleting the specified document from the user's basket.
      await _basketCollection.doc(documentId).delete();
    } catch (e) {
      // Log an error if removing the item fails.
      print('Failed to remove item: $e');
    }
  }

  // Retrieves the basket items for a specific user, grouping by itemId with counts and prices.
  // This method returns a stream of basket items with their counts and associated prices.
  Stream<List<BasketItemCount>> getUserBasketWithCount(String userId) {
    return _basketCollection
        .where('userId', isEqualTo: userId)
        .snapshots()
        .asyncMap((snapshot) async {
          // A map to hold itemId as keys and their counts as values.
          final itemCounts = <String, double>{};

          // Iterate over each document in the user's basket.
          for (var doc in snapshot.docs) {
            final itemId = doc['itemId'] as String;
            // Increment the count of the item. Initialize count if not present.
            itemCounts[itemId] = (itemCounts[itemId] ?? 0) + 1;
          }

          // Fetch item names and prices for each item in the basket.
          // This assumes each item in 'items' collection has 'itemName' and 'price' fields.
          final items = await Future.wait(itemCounts.keys.map((itemId) async {
            final itemDoc = await _itemsCollection.doc(itemId).get();
            final itemName = itemDoc['itemName'] as String; // Get the item name.
            // Convert the price from String to double. Default to 0.0 if conversion fails.
            final itemPrice = double.tryParse(itemDoc['price'].toString()) ?? 0.0;
            return BasketItemCount(
              itemId: itemId,
              itemName: itemName,
              count: itemCounts[itemId]!, // Get the count for the item.
              price: itemPrice, // Use the fetched price for the item.
            );
          }));

          // Return the list of BasketItemCount, which includes the item ID, name, count, and price.
          return items;
        });
  }
}

// Model for representing an individual basket item.
class BasketItem {
  final String id;
  final String userId;
  final String itemId;

  BasketItem({
    required this.id,
    required this.userId,
    required this.itemId,
  });
}

// Model for representing an item in the basket, including its name, count, and price.
class BasketItemCount {
  final String itemId; // The ID of the item.
  final String itemName; // The name of the item.
  final double count; // The number of times this item appears in the basket.
  final double price; // The price of a single item.

  BasketItemCount({
    required this.itemId,
    required this.itemName,
    required this.count,
    required this.price,
  });

  // Calculate the total price for this item based on its count.
  double get totalPrice => count * price;
}
