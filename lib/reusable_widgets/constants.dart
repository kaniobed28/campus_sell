import 'package:flutter/material.dart';

int imageHeightForDashBoard = 120;
int imageWidthForDashBoard = 120;
// int imageHeightSmallClickableImage = 50;
// int imageWidthSmallClickableImage = 50;


const List<DropdownMenuItem<String>> productTypes = [
  DropdownMenuItem<String>(
    value: "",
    child: Text("Select Item Type"),
  ),
  DropdownMenuItem<String>(
    value: "beauty",
    child: Text("Beauty Products"),
  ),
  DropdownMenuItem<String>(
    value: "electronic",
    child: Text("Electronic"),
  ),
  DropdownMenuItem<String>(
    value: "fashion",
    child: Text("Fashion"),
  ),
  DropdownMenuItem<String>(
    value: "food",
    child: Text("Food"),
  ),
  DropdownMenuItem<String>(
    value: "healthcare",
    child: Text("Healthcare Products"),
  ),
  DropdownMenuItem<String>(
    value: "jewelry",
    child: Text("Jewelry"),
  ),
  DropdownMenuItem<String>(
    value: "kitchen",
    child: Text("Kitchen Appliances"),
  ),
  DropdownMenuItem<String>(
    value: "services",
    child: Text("Services"),
  ),
  DropdownMenuItem<String>(
    value: "sports",
    child: Text("Sports Equipment"),
  ),
  DropdownMenuItem<String>(
    value: "stationery",
    child: Text("Stationery"),
  ),
  DropdownMenuItem<String>(
    value: "others",
    child: Text("Others"),
  ),
];
