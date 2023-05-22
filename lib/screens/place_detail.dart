import 'package:flutter/material.dart';
import 'package:native_device_features/model/place_locations_model.dart';

import 'package:native_device_features/screens/map.dart';
import 'package:native_device_features/services/app_services.dart';

import '../model/place_model.dart';

class PlaceDetailScreen extends StatelessWidget {
  const PlaceDetailScreen(
      {super.key, required this.placeLocationId, required this.place});

  final String placeLocationId;
  final Place place;

  // PlaceLocation get getPlaceLocation() async {
  //   PlaceLocation placeLocation = await AppServices.loadPlaceLocation(placeLocationId);
  //   return placeLocation;

  // }

  String? get locationImage {
    AppServices.loadPlaceLocation(placeLocationId).then((value) {
      final lat = value.latitude;
      final lng = value.longtitude;
      return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng=&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$lat,$lng&key=AIzaSyDqdF5F--NW7p_TIcbHVSXMrEWsPvJTXJ0';
    }).catchError((err) => 'erroor');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.title!),
      ),
      body: Center(
          child: Stack(children: [
        Container(),
        //   Image.file(
        //     place.image,
        //     fit: BoxFit.cover,
        //     width: double.infinity,
        //     height: double.infinity,
        //   ),
        //   Positioned(
        //       bottom: 0,
        //       left: 0,
        //       right: 0,
        //       child: Column(
        //         children: [
        //           GestureDetector(
        //             onTap: () {
        //               Navigator.of(context).push(
        //                 MaterialPageRoute(
        //                   builder: (ctx) => MapScreen(
        //                     location: getPlaceLocation,
        //                     isSelected: false,
        //                   ),
        //                 ),
        //               );
        //             },
        //             child: CircleAvatar(
        //               radius: 70,
        //               backgroundImage: NetworkImage(locationImage),
        //             ),
        //           ),
        //           Container(
        //             padding: const EdgeInsets.symmetric(
        //               horizontal: 24,
        //               vertical: 16,
        //             ),
        //             decoration: const BoxDecoration(
        //               gradient: LinearGradient(
        //                 colors: [
        //                   Colors.transparent,
        //                   Colors.black54,
        //                 ],
        //                 begin: Alignment.topCenter,
        //                 end: Alignment.bottomCenter,
        //               ),
        //             ),
        //             alignment: Alignment.center,
        //             child: Text(
        //               textAlign: TextAlign.center,
        //               place.address,
        //               style: Theme.of(context).textTheme.titleLarge!.copyWith(
        //                   color: Theme.of(context).colorScheme.onBackground),
        //             ),
        //           )
        //         ],
        //       ))
        // ],
      ])),
    );
  }
}
