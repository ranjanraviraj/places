import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widget/image_input.dart';
import '../providers/great_places.dart';
import '../widget/location_input.dart';
import '../models/places.dart';

class AddNewPlace extends StatefulWidget {
  static const routeName = '/add-place';

  @override
  _AddNewPlaceState createState() => _AddNewPlaceState();
}

class _AddNewPlaceState extends State<AddNewPlace> {
  final _titleController = TextEditingController();
  File _pickedImage;
  PlaceLocation _mSelectedLocation;

  void _setSelectedImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _selectedLocation(double lat, double long){
    _mSelectedLocation = PlaceLocation(latitude: lat, longitude: long);
  }

  void _savePlace() {
    if (_titleController.text.isEmpty || _pickedImage == null || _mSelectedLocation == null) {
      return;
    }
    Provider.of<GreatePlaces>(context, listen: false).addPlace(
      _titleController.text,
      _pickedImage,
      _mSelectedLocation,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a New Place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(labelText: 'Title'),
                      controller: _titleController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ImageInput(_setSelectedImage),
                    SizedBox(
                      height: 10,
                    ),
                    LocationInput(_selectedLocation),
                  ],
                ),
              ),
            ),
          ),
          RaisedButton.icon(
            onPressed: _savePlace,
            icon: Icon(Icons.add),
            label: Text('Add Place'),
            elevation: 0,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            color: Theme.of(context).accentColor,
          )
        ],
      ),
    );
  }
}
