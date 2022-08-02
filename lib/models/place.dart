import 'dart:io';

class PlaceLocation {
  double? latitude;
  double? longitude;
  String? address;

  PlaceLocation(
      {required this.latitude, required this.longitude, this.address});
}

class Place {
  String? id;
  String? title;
  PlaceLocation? location;
  File? image;

  Place({required this.id, this.title, this.location, this.image});
}
