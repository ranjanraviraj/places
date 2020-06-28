import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../helper/location_helper.dart';
import '../screens/map_screen.dart';

class LocationInput extends StatefulWidget {
  final Function _selectedLocation;

  LocationInput(this._selectedLocation);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImage;

  Future<void> _getCurrentLocation() async {
    final locData = await Location().getLocation();
    final staticMapImageUrl = LocationHelper.generateLocatioPreview(
      latitide: locData.latitude,
      longitude: locData.longitude,
    );
    setState(() {
      _previewImage = staticMapImageUrl;
    });
    widget._selectedLocation(
      locData.latitude,
      locData.longitude,
    );
  }

  Future<void> _selectOnMap() async {
    final LatLng selectedLocation = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MapScreen(
          isSelecting: true,
        ),
      ),
    );
    if (selectedLocation == null) {
      return;
    }
    final staticMapImageUrl = LocationHelper.generateLocatioPreview(
      latitide: selectedLocation.latitude,
      longitude: selectedLocation.longitude,
    );
    setState(() {
      _previewImage = staticMapImageUrl;
    });
    widget._selectedLocation(
      selectedLocation.latitude,
      selectedLocation.longitude,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(10),
          height: 190,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          alignment: Alignment.center,
          child: _previewImage == null
              ? Text(
                  'No Location seelcted',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton.icon(
                onPressed: _getCurrentLocation,
                icon: Icon(Icons.location_on),
                textColor: Theme.of(context).primaryColor,
                label: Text('Current Location')),
            FlatButton.icon(
                onPressed: _selectOnMap,
                textColor: Theme.of(context).primaryColor,
                icon: Icon(Icons.map),
                label: Text('Select on map')),
          ],
        ),
      ],
    );
  }
}
