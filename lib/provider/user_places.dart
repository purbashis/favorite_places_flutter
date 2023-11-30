import 'package:favorite_places/models/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserPlacesNotifier extends StateNotifier<List<Place>> {
  UserPlacesNotifier() : super(const []);

  // void addPlace(Place place) {
  //   state = [...state, place];
  // }

  void addPlace(String title) {
    final newPlace = Place(title: title);
    state = [...state, newPlace];
  }

  // void updatePlace(Place updatedPlace) {
  //   state = [
  //     for (final place in state)
  //       if (place.id == updatedPlace.id) updatedPlace else place
  //   ];
  // }

  final userPlacesProvider = StateNotifierProvider(
    (ref) => UserPlacesNotifier(),
  );

  void removePlace(String placeId) {
    state = state.where((place) => place.id != placeId).toList();
  }
}
