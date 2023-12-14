import 'package:firebase_chat/pages/homepage/models/product.dart';
import 'package:flutter/material.dart';

class Shop extends ChangeNotifier {
  final List<Product> _shop = [
    Product(
      name: 'iPhone 12',
      description: 'iPhone 12 - Please help me find it',
      image: 'https://i.ibb.co/23FggZQ/iphone.png',
    ),
    Product(
      name: 'Room 711B Keys',
      description: 'Please help me find my keys.',
      image: 'https://i.ibb.co/qC7HQg6/key.png',
    ),
    Product(
      name: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      image:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      name: 'Trousers',
      description: 'A nice pair of trousers.',
      image: 'https://i.ibb.co/zF1PffG/pngwing-com.png',
    ),
  ];

  List<Product> get shop => _shop;
}

//notifyListeners();