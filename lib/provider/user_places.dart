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

class UserPlacesNotifier extends StateNotifier<List<Place>> {
  UserPlacesNotifier() : super(const []);

  void addPlace(String title, File image, PlaceLocation location) async {
    final appDir = await  syspaths.getApplicationDocumentsDirectory();
    final filename = path.basename(image.path);
   final copiedImage = await  image.copy('${appDir.path}/$filename');

    final newPlace = Place(title: title, image: copiedImage, location: location);
    state = [newPlace, ...state];
  }
}

final userPlacesProvider =
    StateNotifierProvider<UserPlacesNotifier, List<Place>>(
  (ref) => UserPlacesNotifier(),
);
