import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:native_device_features/providers/user_places.dart';
import 'package:native_device_features/screens/places.dart';
import 'package:native_device_features/services/app_services.dart';
import 'package:native_device_features/widgets/image_input.dart';
import 'package:native_device_features/widgets/location_input.dart';

import '../model/place_locations_model.dart';
import '../model/place_model.dart';

//TODO, ak bude cas zmenit na Form widget
class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key, required this.signedUser});

  final String signedUser;

  @override
  ConsumerState<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File? _selectedImage;
  PlaceLocation? _selectedLocation;

  void _savePlace() async {
    final enteredTitle = _titleController.text;

    if (enteredTitle.isEmpty ||
        _selectedImage == null ||
        _selectedLocation == null) {
      return;
    }

    print('toto je userID v AddPlace ${widget.signedUser}');
    // print('addressa je toto ${_selectedLocation!.address!}');

    final Place place = await AppServices.createPlace(
        _selectedLocation!.address!,
        _selectedLocation!.latitude!,
        _selectedLocation!.longtitude!,
        widget.signedUser,
        enteredTitle,
        _selectedImage!,
        'dfdfdf');

    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => PlacesScreen(
              signedUser: widget.signedUser,
              newPlace: place,
            )));

    // ref
    //     .read(userPlacesProvider.notifier)
    //     .addPlace(enteredTitle, _selectedImage!, _selectedLocation!);
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new place'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: _titleController,
              style:
                  TextStyle(color: Theme.of(context).colorScheme.onBackground),
            ),
            const SizedBox(
              height: 16,
            ),
            ImageInput(
              onPickImage: (File image) {
                _selectedImage = image;
              },
            ),
            const SizedBox(
              height: 16,
            ),
            LocationInput(
              onSelectLocation: (location) {
                _selectedLocation = location;
              },
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton.icon(
              onPressed: _savePlace,
              icon: const Icon(Icons.add),
              label: const Text('Add place'),
            )
          ],
        ),
      ),
    );
  }
}
