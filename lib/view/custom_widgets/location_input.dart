import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:poc_crud_app/model/place.dart';
import 'package:poc_crud_app/view/screens/map_screen.dart';
import 'package:poc_crud_app/view_model/utils/location_util.dart';

class LocationInput extends StatefulWidget {
  final Function? onSelectPosition;

  const LocationInput({Key? key, this.onSelectPosition}) : super(key: key);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  void _showPreview(double lat, double lng) {
    final staticMapImageUrl = LocationUtil.generateLocationPreviewImage(
        latitude: lat, longitude: lng);
    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
  }

  Future<void> _getCurrentUserLocation() async {
    try {
      final locData = await Location().getLocation();

      _showPreview(locData.latitude!, locData.longitude!);
      widget.onSelectPosition!(LatLng(locData.latitude!, locData.longitude!));
    } catch (e) {
      return;
    }
  }

  Future<void> _selectOnMap() async {
    final locData = await Location().getLocation();

    final LatLng selectedPosition =
        await Navigator.of(context).push(MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) => MapScreen(
                  initialLocation: PlaceLocation(
                      latitude: locData.latitude, longitude: locData.longitude),
                )));

    if (selectedPosition == null) return;

    _showPreview(selectedPosition.latitude, selectedPosition.longitude);

    widget.onSelectPosition!(selectedPosition);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _previewImageUrl == null
              ? const Text('Localiza????o n??o informada!')
              : Image.network(
                  _previewImageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: TextButton.icon(
                onPressed: _getCurrentUserLocation,
                icon: const Icon(Icons.location_on),
                label: FittedBox(
                  child: Text(
                    'Localiza????o Atual',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: TextButton.icon(
                onPressed: _selectOnMap,
                icon: const Icon(Icons.map),
                label: FittedBox(
                  child: Text(
                    'Selecione no Mapa',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
