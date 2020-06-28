import 'dart:io';

import 'package:flutter/foundation.dart';

import '../models/places.dart';
import '../helper/db_helper.dart';
import '../helper/location_helper.dart';

class GreatePlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Place getPlace(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  Future<void> addPlace(
      String title, File _pickedImage, PlaceLocation location) async {
    final address = await LocationHelper.getPlaceAddress(
        location.latitude, location.longitude);
    final updatedLocation = PlaceLocation(
      latitude: location.latitude,
      longitude: location.longitude,
      address: address,
    );
    final newPlace = Place(
      id: DateTime.now().toIso8601String(),
      title: title,
      location: updatedLocation,
      image: _pickedImage,
    );
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert(
      DBHelper.TABLE_PLACE,
      {
        DBHelper.ID: newPlace.id,
        DBHelper.TITLE: newPlace.title,
        DBHelper.IMAGE: newPlace.image.path,
        DBHelper.LATTITUDE: newPlace.location.latitude,
        DBHelper.LONGITUDE: newPlace.location.longitude,
        DBHelper.ADDRESS: newPlace.location.address,
      },
    );
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData(DBHelper.TABLE_PLACE);

    _items = dataList
        .map((item) => Place(
              id: item[DBHelper.ID],
              title: item[DBHelper.TITLE],
              location: PlaceLocation(
                latitude: item[DBHelper.LATTITUDE],
                longitude: item[DBHelper.LONGITUDE],
                address: item[DBHelper.ADDRESS],
              ),
              image: File(item[DBHelper.IMAGE]),
            ))
        .toList();
    notifyListeners();
  }
}
