import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:native_device_features/providers/user_places.dart';
import 'package:native_device_features/screens/add_place.dart';
import 'package:native_device_features/services/app_services.dart';
import 'package:native_device_features/widgets/places_list.dart';

import '../model/place_model.dart';

class PlacesScreen extends ConsumerStatefulWidget {
  const PlacesScreen({super.key});

  @override
  ConsumerState<PlacesScreen> createState() {
    return _PlacesScreenState();
  }
}

class _PlacesScreenState extends ConsumerState<PlacesScreen> {
  late List<Place> _placesFuture;

  @override
  void initState() {
    super.initState();
    // _placesFuture = ref.read(userPlacesProvider.notifier).loadPlaces();
    // AppServices.loadPlaceLocation('8ad9da2e-1008-474b-accf-7451b129c2bf')
    //     .then((value) => print('${value.latitude} id of Place Location'));
    AppServices.loadPlaces().then((value) => _placesFuture = [...value]);
  }

  @override
  Widget build(BuildContext context) {
    final userPlaces = ref.watch(userPlacesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const AddPlaceScreen(),
                ),
              );
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          builder: ((context, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : PlacesList(places: userPlaces)),
        ),
      ),
    );
  }
}
