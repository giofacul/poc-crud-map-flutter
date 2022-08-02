import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:poc_crud_app/models/place.dart';
import 'package:poc_crud_app/utils/db_util.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  Future<void> loadPlaces() async {
    final dataList = await DBUtil.getData('places');
    _items = dataList!
        .map((item) => Place(
            id: item['id'],
            title: item['title'],
            image: item['image'],
            location: null))
        .toList();
    notifyListeners();
  }

  List<Place> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  Place getItemByIndex(int index) {
    return _items[index];
  }

  void addPlace(String? title, File? image) {
    final newPlace = Place(
        id: Random().nextDouble().toString(),
        title: title,
        image: image,
        location: null);

    _items.add(newPlace);
    DBUtil.insert('places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image,
    });
    notifyListeners();
  }
}
