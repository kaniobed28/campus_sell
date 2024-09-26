// Base CategoryPage class
import 'package:campus_sell/dashboard/category_all_product_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryPage extends StatelessWidget {
  final RxList<Map<String, dynamic>> productList; // Replace `dynamic` with your actual product type
  final String categoryLabel;

  const CategoryPage({
    super.key,
    required this.productList,
    required this.categoryLabel,
  });

  @override
  Widget build(BuildContext context) {
    return 
          CategoryAllProductsPage(
                        productList: productList,
                        categoryLabel: categoryLabel,
                        showAppBar: false,
                      )
        
    ;
  }
}

// Individual Category Pages
class FoodPage extends StatelessWidget {
  final RxList<Map<String, dynamic>> foodList; // Replace `dynamic` with your actual product type

  const FoodPage({super.key, required this.foodList});

  @override
  Widget build(BuildContext context) {
    return CategoryPage(productList: foodList, categoryLabel: 'Food');
  }
}

class ElectronicsPage extends StatelessWidget {
  final RxList<Map<String, dynamic>> electronicList;

  const ElectronicsPage({super.key, required this.electronicList});

  @override
  Widget build(BuildContext context) {
    return CategoryPage(productList: electronicList, categoryLabel: 'Electronics');
  }
}

class HealthPage extends StatelessWidget {
  final RxList<Map<String, dynamic>> healthList;

  const HealthPage({super.key, required this.healthList});

  @override
  Widget build(BuildContext context) {
    return CategoryPage(productList: healthList, categoryLabel: 'Health Products');
  }
}

class BeautyPage extends StatelessWidget {
  final RxList<Map<String, dynamic>> beautyList;

  const BeautyPage({super.key, required this.beautyList});

  @override
  Widget build(BuildContext context) {
    return CategoryPage(productList: beautyList, categoryLabel: 'Beauty Products');
  }
}

class JewelryPage extends StatelessWidget {
  final RxList<Map<String, dynamic>> jewelryList;

  const JewelryPage({super.key, required this.jewelryList});

  @override
  Widget build(BuildContext context) {
    return CategoryPage(productList: jewelryList, categoryLabel: 'Jewelry');
  }
}

class FashionPage extends StatelessWidget {
  final RxList<Map<String, dynamic>> fashionList;

  const FashionPage({super.key, required this.fashionList});

  @override
  Widget build(BuildContext context) {
    return CategoryPage(productList: fashionList, categoryLabel: 'Fashion');
  }
}

class SportsPage extends StatelessWidget {
  final RxList<Map<String, dynamic>> sportsList;

  const SportsPage({super.key, required this.sportsList});

  @override
  Widget build(BuildContext context) {
    return CategoryPage(productList: sportsList, categoryLabel: 'Sports Products');
  }
}

class StationaryPage extends StatelessWidget {
  final RxList<Map<String, dynamic>> stationaryList;

  const StationaryPage({super.key, required this.stationaryList});

  @override
  Widget build(BuildContext context) {
    return CategoryPage(productList: stationaryList, categoryLabel: 'Stationary');
  }
}

class KitchenPage extends StatelessWidget {
  final RxList<Map<String, dynamic>> kitchenList;

  const KitchenPage({super.key, required this.kitchenList});

  @override
  Widget build(BuildContext context) {
    return CategoryPage(productList: kitchenList, categoryLabel: 'Kitchen Products');
  }
}

class OtherPage extends StatelessWidget {
  final RxList<Map<String, dynamic>> otherList;

  const OtherPage({super.key, required this.otherList});

  @override
  Widget build(BuildContext context) {
    return CategoryPage(productList: otherList, categoryLabel: 'Other Products');
  }
}

class ServicesPage extends StatelessWidget {
  final RxList<Map<String, dynamic>> servicesList;

  const ServicesPage({super.key, required this.servicesList});

  @override
  Widget build(BuildContext context) {
    return CategoryPage(productList: servicesList, categoryLabel: 'Services');
  }
}
