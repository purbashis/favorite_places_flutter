// import 'package:favorite_places/models/place.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class UserPlacesNotifier extends StateNotifier<List<Place>> {
//   UserPlacesNotifier() : super(const []);

//   // void addPlace(Place place) {
//   //   state = [...state, place];
//   // }

//   void addPlace(String title) {
//     final newPlace = Place(title: title);
//     state = [newPlace,...state];
//   }

//   // void updatePlace(Place updatedPlace) {
//   //   state = [
//   //     for (final place in state)
//   //       if (place.id == updatedPlace.id) updatedPlace else place
//   //   ];
//   // }
// final userPlacesProvider =
//       StateNotifierProvider<UserPlacesNotifier, List<Place>>(
//     (ref) => UserPlacesNotifier(),
//   );

//   // void removePlace(String placeId) {
//   //   state = state.where((place) => place.id != placeId).toList();
//   // }
// }
import 'dart:io';

import 'package:favorite_places/models/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

class UserPlacesNotifier extends StateNotifier<List<Place>> {
  UserPlacesNotifier() : super(const []);

  void addPlace(String title, File image, PlaceLocation location) async {
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final filename = path.basename(image.path);
    final copiedImage = await image.copy('${appDir.path}/$filename');

    final newPlace =
        Place(title: title, image: copiedImage, location: location);

    final dbPath = await sql.getDatabasesPath();
    final db = await sql.openDatabase(path.join(dbPath, 'places.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_places(id TEXT PRIMARY KEY ,title TEXT , image TEXT , lat REAL ,lng REAL ,address TEXT)');
    }, version: 1);
    db.insert(
      'user_places',
    {
      'id': newPlace.id,
      'title':newPlace.title,
      'image':newPlace.image.path,
      'lat':newPlace.location.latitude,
      'lng':newPlace.location.longitude,
      'address':newPlace.location.address
    });
    state = [newPlace, ...state];
  }
}

final userPlacesProvider =
    StateNotifierProvider<UserPlacesNotifier, List<Place>>(
  (ref) => UserPlacesNotifier(),
);
